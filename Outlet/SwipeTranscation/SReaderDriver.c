/*
 *  SReaderDriver.c
 *  SReaderV1.0
 *
 *  Created by z b on 12-7-13.
 *  Copyright 2012 h. All rights reserved.
 *
 */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#include <string.h>
#include <math.h>

#include "SReaderDriver.h"

void hello()
{
	printf("hello C world.\n");
}




#define true	1
#define false	0


static int	isDataReady = false;
static int	nDataLen = 0;

int DEBUG_MIC = 0;


/*****************************
Notify message to UI
*****************************/
int get_input(unsigned char textbuf[], int len);	


int get_isDataReady(void)
{
	return isDataReady;
}

int get_DataLen(void)
{
	return nDataLen;
}

void clearDataStatus(void)
{
	isDataReady = false;
	nDataLen = 0;

	initialize_buffer();
}

unsigned char * get_DataBuffer(int *len)
{
	if (isDataReady == false)
		return NULL;
	
	unsigned char *buffer = (unsigned char *)malloc((nDataLen+1) * sizeof(unsigned char));
	*len = get_input(buffer, nDataLen);
	buffer[nDataLen] = 0;
	
	clearDataStatus();
	
	return buffer;
}

// inside utility
void NotifyDataReady(int len)
{
	if (len > 0) {
		
		nDataLen = len;
		isDataReady = true;
		
	}
	
	return;
}


#define STARTBIT_PRE	-1
#define STARTBIT		 0
#define SAMEBIT			 1
#define NEXTBIT			 2
#define STOPBIT			 3
#define STARTBIT_FALL	 4
#define DECODE			 5
#define ENCODE			 6

static const int THRESHOLD = -100; // threshold used to process AD transfer
// start bit
static const int AMPLITUDE = -((1 << 15) - 1);


// TX vars
//static int phase = 0;
static int sample = 0;
static int lastSample = 0;
static int decState = STARTBIT;
static int step = 0;
static int laststep = 0;

#define STEPSPERBIT			20 // (44100 / 20) = 2.2kHz
#define HALFSTEPSPERBIT		10 // (44100 / 10) = 4.4kHz
#define STEPTOLERANCE		 4

// UART decoding
static int bitval = 0;
static int bitNum = 0;
static int g_uartByte = 0;
static char parityRx = 0;
static int decdatalen = 0;

// UART encoding
#define ENCBUFFERSIZE	512
#define SYNCNUM			  8 //4

static int encBuffer[ENCBUFFERSIZE];
static int r_enc = 0;
static int w_enc = 0;
static int encState = STARTBIT_PRE;


// input buffer
#define INPUT_BUFFER_SIZE		4096
static int input_buffer[INPUT_BUFFER_SIZE];
static int r_input = 0;
static int w_input = 0;

// command buffer
#define COMMAND_BUFFER_SIZE		1024
static int command_buffer[COMMAND_BUFFER_SIZE];
static int r_command = 0;
static int w_command = 0;

static int buffer_lock = 0;

void initialize_buffer()
{
	buffer_lock = 1;
	usleep(10000); // wait for callback to finish current work
	
	r_enc = 0;
	w_enc = 0;
	encState = STARTBIT_PRE;
	
	r_input = 0;
	w_input = 0;
	
	r_command = 0;
	w_command = 0;

	buffer_lock = 0;
}

// in callback thread
int put_input_byte(int uartByte) {
	int r = r_input;
	
	if (buffer_lock)
		return false;

	if ((w_input == r - 1) || (w_input >= r + INPUT_BUFFER_SIZE - 1)) {
		// buffer is flow
		return false;
	}
	
	input_buffer[w_input] = uartByte;
	
	w_input = (w_input >= (INPUT_BUFFER_SIZE - 1)) ? 0 : w_input + 1;
	
	//NSLog(@"uartByte=0x%08x",uartByte);
	return true;
}

// in main thread
int get_input(unsigned char textbuf[], int len) {
	int w = w_input;
	
	if (r_input == w) {
		// empty
		return 0;
	}
	
	int i = r_input, j = 0;
	
	while (i != w && j < len) {
		textbuf[j++] = (unsigned char)(input_buffer[i++] & 0x000000FF);
		i = (i >= INPUT_BUFFER_SIZE) ? 0 : i;
	}
	
	r_input = i;
	return j;
}

// in main thread
int get_command_space() {
	int r = r_command;
	if (w_command < r) {
		return (r - w_command - 1);
	} else {
		return (COMMAND_BUFFER_SIZE - w_command + r - 1);
	}
}

int write_command(int cmdbuf[], int len) {
	if (len <= 0 || len > get_command_space())
		return 0;
	
	int len1 = COMMAND_BUFFER_SIZE - w_command;
	len1 = len < len1 ? len : len1;
	memcpy(command_buffer+w_command, cmdbuf, len1*sizeof(int));
	if (len1 < len) {
		memcpy(command_buffer, cmdbuf+len1, (len - len1)*sizeof(int));
	}
	
	int w = w_command + len;
	w_command = (w >= COMMAND_BUFFER_SIZE) ? (w - COMMAND_BUFFER_SIZE) : w;
	
	return len;
}

// in callback thread
int get_command_byte() {
	if (r_command == w_command)
		return -1;
	
	int uartByte = command_buffer[r_command];
	r_command = (r_command >= (COMMAND_BUFFER_SIZE - 1)) ? 0 : r_command + 1;
	
	return uartByte;
}

int EncodeOneByte(int offset, int uartByte, int startSYNC) {
	int encLen = offset;
	int parity = 1; // for ODD
	int bitval1 = 0;
	int samval = 0;
	int i = 0, j = 0;
	
	if (uartByte < 0 || uartByte > 255)
		return 0;
	else if (uartByte == 0x100) {
		// gen guard flow
		for (j = 0; j < 2 * STEPSPERBIT; j++)
			encBuffer[encLen++] = AMPLITUDE;
		
		// gen SYNC pulse
		for (i = 0; i < SYNCNUM; i++) {
			for (j = 0; j < HALFSTEPSPERBIT; j++)
				encBuffer[encLen++] = -AMPLITUDE;
			for (j = 0; j < HALFSTEPSPERBIT; j++)
				encBuffer[encLen++] = AMPLITUDE;
		}
		
		w_enc = encLen;
		return encLen - offset;
	}
	
	// gen SYNC pulse
	if (startSYNC) {
		// guard flow
		for (j = 0; j < 2 * STEPSPERBIT; j++)
			encBuffer[encLen++] = AMPLITUDE;
		// SYNC pulse
		for (i = 0; i < SYNCNUM; i++) {
			for (j = 0; j < HALFSTEPSPERBIT; j++)
				encBuffer[encLen++] = -AMPLITUDE;
			for (j = 0; j < HALFSTEPSPERBIT; j++)
				encBuffer[encLen++] = AMPLITUDE;
		}
	}
	
	// gen STARTBIT
	for (j = 0; j < STEPSPERBIT; j++)
		encBuffer[encLen++] = -AMPLITUDE;
	
	// gen ByteBit
	samval = AMPLITUDE;
	for (i = 0; i < 8; i++) {
		bitval1 = uartByte & 0x01;
		uartByte = uartByte >> 1;
		
		// cal parity
		parity += bitval1;
		
		for (j = 0; j < HALFSTEPSPERBIT; j++)
			encBuffer[encLen++] = samval;
		samval = (bitval1 > 0) ? -samval : samval;
		for (j = 0; j < HALFSTEPSPERBIT; j++)
			encBuffer[encLen++] = samval;
		
		// to finish one bit
		samval = -samval;
	}
	
	// gen ParityBit
	parity = parity & 0x01;
	for (j = 0; j < HALFSTEPSPERBIT; j++)
		encBuffer[encLen++] = samval;
	samval = (parity > 0) ? -samval : samval;
	for (j = 0; j < HALFSTEPSPERBIT; j++)
		encBuffer[encLen++] = samval;
	
	// gen StopBit
	for (j = 0; j < HALFSTEPSPERBIT; j++)
		encBuffer[encLen++] = AMPLITUDE;
	for (j = 0; j < HALFSTEPSPERBIT; j++)
		encBuffer[encLen++] = -AMPLITUDE;
	
	// gen GuardBit
	for (j = 0; j < STEPSPERBIT; j++)
		encBuffer[encLen++] = AMPLITUDE;
	
	w_enc = encLen;
	
	return encLen - offset;
}


static short *readBuffer = 0;

int UART_Decode(int inNumberFrames, short *buf)
{
	
	int bufferLength = inNumberFrames;

	readBuffer = buf;
	if (readBuffer == NULL)
		return 0;
	
	//printf("UART Decode Log:\n");
	
	for (int j = 0; j < bufferLength; j++, step++) {
		// guard flow
		if (step > 2 * (STEPSPERBIT + STEPTOLERANCE)) {
			step = STEPSPERBIT + STEPTOLERANCE + 1;
			
			if (decdatalen > 0 && decState == STARTBIT) {
				NotifyDataReady(decdatalen);
				decdatalen = 0;
				printf("Input End Notify...!\n");
			}
		}
		
		// get new sample value
		int value = readBuffer[j]/10.;
		sample = value < THRESHOLD ? 0 : 1;
		
		if (lastSample != sample) {
			// Log.v(TAG, "sample diff..");
			int steplength = step;
			step = 0;
			
			// save the last sample value
			lastSample = sample;
			
			// calculate bit value
			int last_bitval = bitval;
			if ((steplength > (HALFSTEPSPERBIT - STEPTOLERANCE))
				&& (steplength < (HALFSTEPSPERBIT + STEPTOLERANCE))) {
				bitval = 1;
				
				if (laststep == 0) { // half bit is coming
					laststep = HALFSTEPSPERBIT;
					continue;
				} else { // one bit is coming
					laststep = 0;
				}
			} else if ((steplength > (STEPSPERBIT - STEPTOLERANCE))
					   && (steplength < (STEPSPERBIT + STEPTOLERANCE))) {
				bitval = 0;
				
				laststep = 0;
			} else {
				decState = STARTBIT;
				continue;
			}
			
			// we got a bitval
			//NSLog(@"we got a bit %d", bitval);
			//DEBUG_MIC = 1;//====================
			
			// Log.v(TAG, "decState=" + decState);
			switch (decState) {
				case STARTBIT_PRE:
					if (bitval == 0) {
						bitNum = 0;
						parityRx = 0;
						g_uartByte = 0;
						decState = DECODE;
					} else {
						bitNum++;
						decState = STARTBIT_PRE;
					}
					break;
				case STARTBIT:
					if (bitval == 0) {
						if (last_bitval == 0) {
							bitNum = 0;
							parityRx = 0;
							g_uartByte = 0;
							decState = DECODE;
						} else {
							bitNum = 0;
							decState = STARTBIT;
						}
						
					} else {
						bitNum = 0;
						decState = STARTBIT_PRE;
					}
					break;
					/*
					 case STARTBIT_FALL:
					 if (bitval == 1) {
					 bitNum = 0;
					 parityRx = 0;
					 g_uartByte = 0;
					 decState = DECODE;
					 } else {
					 decState = STARTBIT;
					 }
					 break;
					 */
				case DECODE:
					// then we got a valid bit value.
					
					if (bitNum < 8) {
						g_uartByte = (g_uartByte >> 1) + (bitval << 7);
						bitNum += 1;
						parityRx += bitval;
					} else if (bitNum == 8) {
						// ODD parity bit
						if (bitval == (parityRx & 0x01)) {
							// failed
							decState = STARTBIT;
							printf("DECODE FAILED at parity bit!!!\n");
							DEBUG_MIC = 1;//====================
						} else {
							// success
							bitNum += 1;
						}
					} else if (bitNum == 9) {
						// we should now have the stopbit
						if (bitval == 1) {
							// we have a new and valid byte!
							// only put to buffer if stopbit is valid!
							bitNum += 1;
							//NSLog(@"put_input_byte.. %04x", g_uartByte);
							put_input_byte(g_uartByte);
							decdatalen++;
							DEBUG_MIC = 1;//====================
						} else {
							// not a valid byte.
							bitNum = 0;
							decState = STARTBIT;
							printf("DECODE FAILED at stopbit!!!\n");
							DEBUG_MIC = 1;//====================
						}
					} else {
						// we should now have the guardbit
						if (bitval == 0 && sample == 1) {
							// not a valid byte
							bitNum = 0;
							//NSLog(@"guardbit=1");
						} else {
							// guardbit, just check it
							// keep for Hight LEVEL
							bitNum = 0;
							//NSLog(@"guardbit=0");
						}
						decState = STARTBIT;
					}
					break;
				default:
					break;
			} // switch
		} // if
	} // for
	
	return bufferLength;
}


static short* writeBufferl=0;
static short* writeBufferr=0;
void UART_Encode(int inNumberFrames, short *lbuffer, short *rbuffer)
{
	writeBufferl = lbuffer;
	writeBufferr = rbuffer;

	if (writeBufferl == NULL || writeBufferr == NULL)
		return;
	
	/*******************************
	 * Generate 11/22 kHz Tone
	 *******************************
	double waves;

	for (int j=0; j<inNumberFrames; j++) {
		
		waves = sin(M_PI_2 * (double)phase + M_PI_2); // This should be 11kHz
		//		waves = sin(M_PI * (double)phase + M_PI_2); // This should be 22kHz
		
		waves *= AMPLITUDE; // <--------- make sure to divide
		// by how
		// many waves you're stacking
		
		//writeBufferl[j] = 0;
		writeBufferr[j] = (short)waves;
		
		phase++;
		phase = phase >= 20 ? 0 : phase;
	}
	/*/
	
	/*******************************
	 * Generate command pulse
	 *******************************/
	int uartByte = 0;
	for (int j = 0; j < inNumberFrames; j++) {
		if (r_enc == w_enc) {
			r_enc = w_enc = 0;
			if (r_command != w_command) {
				uartByte = get_command_byte();
				if (uartByte != -1) {
					// send command
					EncodeOneByte(0, uartByte,
								  (int)(encState == STARTBIT_PRE ? true : false));
					encState = ENCODE;
				} else {
					// no command, channel is idle
					encState = STARTBIT_PRE;
				}
			} else {
				// no command, channel is idle
				encState = STARTBIT_PRE;
			}
		}
		
		if (encState == ENCODE && w_enc > 0)
			writeBufferl[j] = (short) encBuffer[r_enc++];
		else
			writeBufferl[j] = 0; // -AMPLITUDE;

		writeBufferr[j] = writeBufferl[j];
	}
	
}

static int errcode = 0;
unsigned char *rawData = NULL;
int rawDataLen = 0;
static int g_sw1=0, g_sw2=0;

int get_errcode() {
	return errcode;
}

unsigned char *get_rawData() {
	return rawData;
}

int get_rawDataLen() {
	return rawDataLen;
}

void get_swcode(int *sw1, int *sw2) {
	*sw1 = g_sw1;
	*sw2 = g_sw2;

	return;
}


unsigned char *processDataResult(int *size)
{
	unsigned char *resultdata_buffer = NULL;
	
	unsigned char sw1 = 0;
	unsigned char sw2 = 0;
	
	unsigned char edc = 0;
	unsigned char data_edc = 0;
	unsigned char etx = 0;
	
	unsigned char *buffer = NULL;
	int recvDataLen = 0;

	if (rawData)
		free(rawData);
	errcode = 0;

	buffer = get_DataBuffer(&recvDataLen);
	rawData = buffer;
	rawDataLen = recvDataLen;
	
	if (buffer == NULL) {
		printf("Response Frame is invalid!!0\n");
		errcode = ERR_NODATA;
		return NULL;
	}
	
	if (buffer[0] != 0x1c) {
		printf("Response Frame is invalid!!1");
		errcode = ERR_NOSTART1C;
		return NULL;
	}
	
	int data_len = (((int)buffer[1] & 0x000000FF << 8) & 0x0000FF00) | ((int)buffer[2] & 0x000000FF);
	if (data_len > recvDataLen - 4) {
		//free(buffer);
		errcode = ERR_LARGEDATALEN;
		return NULL;
	}
	
	if (data_len < 2) {
		printf("Respone Frame is invalid!!2\n");
		//free(buffer);
		errcode = ERR_SMALLDATALEN;
		return NULL;
	} else if (data_len == 0x02) {
		sw1 = buffer[3];
		sw2 = buffer[4];
		if (recvDataLen > 5) {
			etx = buffer[5];
			if (recvDataLen > 6)
				edc = buffer[6];
		}
		errcode = ERR_FUNCFAILED;
	} else {
		resultdata_buffer = (unsigned char *)malloc((data_len - 2 + 1) * sizeof(unsigned char));
		memcpy(resultdata_buffer, buffer+3, data_len - 2);
		resultdata_buffer[data_len - 2] = 0;
		
		for (int j = 0; j < data_len - 2; j++) {
			data_edc ^= resultdata_buffer[j];
		}
		
		sw1 = buffer[1 + data_len];
		sw2 = buffer[2 + data_len];
		if (recvDataLen > 3 + data_len) {
			etx = buffer[3 + data_len];
			if (recvDataLen > 4 + data_len)
				edc = buffer[4 + data_len];
		}
	}

	g_sw1 = sw1;
	g_sw2 = sw2;
	
	//free(buffer);
	
	if (etx != 0x3f) {
		printf("Respone Frame is invalid!!3\n");
		if (resultdata_buffer)
			free(resultdata_buffer);
		errcode = ERR_WRONGETX;
		return NULL;
	}
	
	if (edc != (int) (0x1c ^ sw1 ^ sw2 ^ etx ^ buffer[1] ^ buffer[2] ^ data_edc)) {
		printf("EDC is invalid!!!");
		if (resultdata_buffer)
			free(resultdata_buffer);
		errcode = ERR_WRONGEDC;
		return NULL;
	}
	
	*size = data_len - 2;
	
	printf("We have got data at %08x, size = %d\n", (unsigned int)resultdata_buffer, data_len - 2);
	
	return resultdata_buffer;
}



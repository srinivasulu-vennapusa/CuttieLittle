/*
 *  SReaderDriver.h
 *  SReaderV1.0
 *
 *  Created by z b on 12-7-13.
 *  Copyright 2012 h. All rights reserved.
 *
 */

void hello(void);

void initialize_buffer(void);
int get_isDataReady(void);
int get_DataLen(void);
void clearDataStatus(void);
unsigned char * get_DataBuffer(int *len);

int UART_Decode(int inNumberFrames, short *buf);
void UART_Encode(int inNumberFrames, short *lbuffer, short *rbuffer);

int write_command(int cmdbuf[], int len);
unsigned char *processDataResult(int *size);

#define ERR_NOERROR			0
#define ERR_NODATA			100
#define ERR_NOSTART1C		101
#define ERR_LARGEDATALEN	102
#define ERR_SMALLDATALEN	103
#define ERR_WRONGETX		104
#define ERR_WRONGEDC		105
#define ERR_FUNCFAILED		106
int get_errcode();
unsigned char *get_rawData();
int get_rawDataLen();
void get_swcode(int *sw1, int *sw2);


//unsigned char * get_DataBuffer(int *len);
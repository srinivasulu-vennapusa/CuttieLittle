/*
 *  SReaderUtility.m
 *  SReaderV1.0
 *
 *  Created by z b on 12-7-13.
 *  Copyright 2012 h. All rights reserved.
 *
 */
#include <unistd.h>
#include <time.h>

#import <CommonCrypto/CommonCryptor.h>

#include "SReaderDriver.h"
#include "SReaderUtility.h"


/************************************
 * SReader working space...
 ************************************/

unsigned char *AA = NULL;

unsigned char MainKey[25] = "SingularSINGULAR";
int MainKey_len = 16;
unsigned char *Version = NULL;
unsigned char *KSN = NULL;
int KSN_len = 0;
unsigned char *Random = NULL;
int Random_len = 0;
unsigned char *Counter = NULL;
int Counter_len = 0;
unsigned char WorkingKey[25];
int WorkingKey_len = 24;


double cmd_init_delay = 5.0; //Second

static int m_comStatus;
//define command status for m_comStatus
#define COM_IDLE			100
#define COM_GETVERSION		101
#define COM_GETKSN			102
#define COM_GETRANDOM		103
#define COM_READCARD		104
#define COM_READCANCEL		105
#define COM_GETT1_PAN		106
#define COM_GETT1_EXD		107
#define COM_GETT2_PAN		108
#define COM_GETT2_EXD		109

#define _WAITTING_RESPONSE_(timeout_ms) \
int count = 0;\
while (get_isDataReady() == false) {\
usleep(1000);\
if (count++ >= timeout_ms) return NULL;\
}



unsigned char *SReader_Initial(void)
{
	int cmdbuf[] = { 0xaa };
	
	if (AA)
		free(AA);
	AA = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETVERSION;
	
	_WAITTING_RESPONSE_(500)
	
	int size = 0;
	AA = processDataResult(&size);
	
	return AA;
}

unsigned char *SReader_GetVersion(void)
{
	int cmdbuf[] = { 0x1b, 0x31, 0x00, 0x00, 0x2f, 0x05 };
	
	if (Version)
		free(Version);
	Version = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETVERSION;
	
	_WAITTING_RESPONSE_(5000)
	
	int size = 0;
	Version = processDataResult(&size);
	
	return Version;
}

unsigned char *SReader_GetKSN(void)
{
	int cmdbuf[] = { 0x1b, 0x32, 0x00, 0x00, 0x2f, 0x06 };
	
	if (KSN)
		free(KSN);
	KSN = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETKSN;
	
	_WAITTING_RESPONSE_(5000)
	
	KSN_len = 0;
	KSN = processDataResult(&KSN_len);
	
	return KSN;
}

unsigned char *SReader_GetRandom(void)
{
	int cmdbuf[] = { 0x1b, 0x33, 0x00, 0x00, 0x2f, 0x07 };
	
	if (Random)
		free(Random);
	Random = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETRANDOM;
	
	_WAITTING_RESPONSE_(5000)
	
	Random_len = 0;
	Random = processDataResult(&Random_len);
	
	return Random;
}

unsigned char *SReader_GenerateWorkingKey(void)
{
	//to generate WorkingKey
	unsigned char outbuff[1024];
	
	unsigned char subkey[9];
	memcpy(subkey, MainKey, 8);
	subkey[8] = 0;
	
	//unsigned char testRandom[] = {0x40, 0x10, 0x91, 0x9D, 0x9E, 0XE5, 0x4A, 0xE5};
	
	size_t retNum = 0;
	BOOL ret = unDES((void *)Random, 8, subkey, (void *)outbuff, sizeof(outbuff), &retNum);
	if (ret == TRUE && retNum == 8)
	{
		if (Counter)
			free(Counter);
		Counter = (unsigned char *)malloc(8 * sizeof(unsigned char));
		memcpy(Counter, outbuff, 8);
		Counter_len = 8;
	} else {
		NSLog(@"unDES ERROR!");
		return NULL;
	}
	
	unsigned char Mixed[8];
	for (int i = 0; i < 8; i++) {
		if (i < 4)
			Mixed[i] = (KSN[3 - i] ^ Counter[4 + i]);
		else
			Mixed[i] = (KSN[i] ^ Counter[7 - i]);
	}
	unsigned char outTempKey[9];
	
	unsigned char longkey[25];
	memcpy(longkey, MainKey, 16);
	memcpy(&longkey[16], MainKey, 8);
	longkey[24] = 0;
	
	retNum = 0;
	ret = en3DES((void *)Mixed, 8, longkey, (void *)outbuff, sizeof(outbuff), &retNum);
	if (ret == TRUE && retNum == 8)
	{
		memcpy(outTempKey, outbuff, 8);
		outTempKey[8] = 0;
	} else {
		NSLog(@"WorkingKey 3DES ERROR!");
		return NULL;
	}
	
	// generate working key
	memcpy(WorkingKey, outTempKey, 8);
	memcpy(WorkingKey+8, MainKey+8, 8);
	memcpy(WorkingKey+16, outTempKey, 8);
	WorkingKey[WorkingKey_len] = 0;
	
	return WorkingKey;
}

unsigned char * SReader_ReadCard(int *size)
{
	int cmdbuf[] = { 0x1b, 0x41, 0x00, 0x00, 0x2f, 0x75 };

	// clear buffer;
	int tmpsize = 0;
	unsigned char *tmpbuf = get_DataBuffer(&tmpsize);
	if (tmpbuf)
		free(tmpbuf);
	
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_READCARD;

	*size = -1;
	_WAITTING_RESPONSE_(10000)
	
	int datasize = 0;
	unsigned char * buffer = processDataResult(&datasize);
	*size = datasize;
	
	return buffer;
}

void *SReader_Cancel()
{
	int cmdbuf[] = { 0x1b, 0x81, 0x00, 0x00, 0x2f, 0xb5 };
	
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_IDLE;

	_WAITTING_RESPONSE_(5000)
	
	int ret = 0;
	unsigned char *buffer = processDataResult(&ret);
	if (buffer)
		free(buffer);

	return NULL;
}

unsigned char *T1_PAN = NULL;
int T1_PAN_len = 0;
unsigned char *T1_ExD = NULL;
int T1_ExD_len = 0;
unsigned char *T2_PAN = NULL;
int T2_PAN_len = 0;
unsigned char *T2_ExD = NULL;
int T2_ExD_len = 0;

unsigned char *SReader_T1_PAN(void)
{
	int cmdbuf[] = { 0x1b, 0x42, 0x00, 0x00, 0x2f, 0x76 };
	
	if (T1_PAN)
		free(T1_PAN);
	T1_PAN = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETT1_PAN;
	
	_WAITTING_RESPONSE_(5000)
	
	T1_PAN_len = 0;
	T1_PAN = processDataResult(&T1_PAN_len);
	
	return T1_PAN;
}

unsigned char *SReader_T1_ExD(void)
{
	int cmdbuf[] = { 0x1b, 0x43, 0x00, 0x00, 0x2f, 0x77 };
	
	if (T1_ExD)
		free(T1_ExD);
	T1_ExD = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETT1_EXD;
	
	_WAITTING_RESPONSE_(5000)
	
	T1_ExD_len = 0;
	T1_ExD = processDataResult(&T1_ExD_len);
	
	return T1_ExD;
}

unsigned char *SReader_T2_PAN(void)
{
	int cmdbuf[] = { 0x1b, 0x44, 0x00, 0x00, 0x2f, 0x78 }; //0x70 right //0x78 wrong
	
	if (T2_PAN)
		free(T2_PAN);
	T2_PAN = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETT2_PAN;
	
	_WAITTING_RESPONSE_(5000)
	
	T2_PAN_len = 0;
	T2_PAN = processDataResult(&T2_PAN_len);
	
	return T2_PAN;
}

unsigned char *SReader_T2_ExD(void)
{
	int cmdbuf[] = { 0x1b, 0x45, 0x00, 0x00, 0x2f, 0x79 }; //0x71 right //0x79 wrong
	
	if (T2_ExD)
		free(T2_ExD);
	T2_ExD = NULL;
	clearDataStatus();
	
	write_command(cmdbuf, 6);
	m_comStatus = COM_GETT2_EXD;
	
	_WAITTING_RESPONSE_(5000)
	
	T2_ExD_len = 0;
	T2_ExD = processDataResult(&T2_ExD_len);
	
	return T2_ExD;
}



BOOL TriDesDecryptio(void *dataIn, int len, void *dataOut, int bufsize, size_t *pMovedBytes)
{
	size_t retNum = 0;
	BOOL ret = un3DES((void *)dataIn, len, WorkingKey, (void *)dataOut, bufsize, &retNum);
	retNum = retNum > bufsize ? bufsize : retNum;
	*pMovedBytes = retNum;
	
	return ret;
}

int setMainKey(char *new_MainKey)
{
	int len = strlen((char *)new_MainKey);

	memset(MainKey, 0, MainKey_len);
	len = len > MainKey_len ? MainKey_len : len;
	memcpy(MainKey, new_MainKey, len);
	MainKey[MainKey_len] = 0;

	return 1;
}

unsigned char *get_CurrentVersion(void)
{
	return Version;
}

unsigned char *get_CurrentKSN(void)
{
	static unsigned char hexstring[32+1];
	
	int retnum = 0;
	Hex2String(KSN, KSN_len, hexstring, 33, &retnum);
	retnum = MAX(retnum, 32);
	hexstring[retnum] = 0;
	
	return hexstring;
}

unsigned char *get_CurrentRandom(void)
{
	static unsigned char hexstring[32+1];
	
	int retnum = 0;
	Hex2String(Random, Random_len, hexstring, 33, &retnum);
	retnum = MAX(retnum, 32);
	hexstring[retnum] = 0;
	
	return hexstring;
}

unsigned char *get_CurrentCounter(void)
{
	static unsigned char hexstring[32+1];
	
	int retnum = 0;
	Hex2String(Counter, Counter_len, hexstring, 33, &retnum);
	retnum = MAX(retnum, 32);
	hexstring[retnum] = 0;
	
	return hexstring;
}

unsigned char *get_CurrentWorkingKey(void)
{
	static unsigned char hexstring[64+1];
	
	int retnum = 0;
	Hex2String(WorkingKey, 24, hexstring, 65, &retnum);
	retnum = MAX(retnum, 64);
	hexstring[retnum] = 0;
	
	return hexstring;
}


NSString *Hex2NSString(unsigned char buffer[], int len) {
	char *hexstring = (char *)malloc(len * 2 + 1);
	memset(hexstring, 0, len * 2 + 1);
	char *str = hexstring;
	
	for (int i=0; i<len; i++) {
		sprintf(str, "%02x", buffer[i]);
		str += 2;
		*str = 0;
	}
	
	NSString *nsstr = [[NSString alloc] initWithFormat:@"%s", hexstring];
	free(hexstring);
	
	return nsstr;
}


BOOL Hex2String(unsigned char buffer[], int len, unsigned char hexstring[], int maxlen, int *retnum)
{
	memset(hexstring, 0, maxlen);
	char *str = (char *)hexstring;
	
	int count = 0;
	for (int i=0; i<len; i++) {
		sprintf(str, "%02x", buffer[i]);
		str += 2;
		*str = 0;
		count += 2;
		if (count >= maxlen-2)
			break;
	}
	*retnum = count;
	
	return TRUE;
}


BOOL String2Hex(unsigned char hexstring[], int len, unsigned char buffer[], int maxlen, int *retnum)
{
	memset(buffer, 0, maxlen);
	char *str = (char *)hexstring;
	char numstring[5] = {'0', 'x', 0, 0, 0} ;
	unsigned int number = 0;
	
	int count = 0;
	str = (char *)hexstring;
	for (int i=0; i<len/2; i++) {
		if (i >= maxlen)
			break;
		numstring[2] = *str;
		str++;
		numstring[3] = *str;
		str++;
		sscanf(numstring, "%x", &number);
		buffer[i] = (unsigned char)(number & 0x000000FF);
		
		count++;
	}
	*retnum = count;
	
	return TRUE;
}

BOOL unDES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes)
{
	bzero(dataOut, bufsize);
	CCCryptorStatus result = CCCrypt(kCCDecrypt,
									 kCCAlgorithmDES, //kCCAlgorithmAES128,
									 kCCOptionECBMode, //kCCOptionECBMode, //kCCOptionPKCS7Padding,
									 key,
									 kCCKeySizeDES, //kCCKeySizeDES,
									 NULL,
									 dataIn,
									 len,
									 dataOut,
									 bufsize,
									 pMovedBytes);
	if (result == kCCSuccess)
		NSLog(@"unDES SUCCESS");
    else if (result == kCCParamError)
		NSLog(@"PARAM ERROR");
	else if (result == kCCBufferTooSmall)
		NSLog(@"BUFFER TOO SMALL");
	else if (result == kCCMemoryFailure)
		NSLog(@"MEMORY FAILURE");
	else if (result == kCCAlignmentError)
		NSLog(@"ALIGNMENT");
	else if (result == kCCDecodeError)
		NSLog(@"DECODE ERROR");
	else if (result == kCCUnimplemented)
		NSLog(@"UNIMPLEMENTED");
	
	return TRUE;
}

BOOL enDES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes)
{
	bzero(dataOut, bufsize);
	CCCryptorStatus result = CCCrypt(kCCEncrypt,
									 kCCAlgorithmDES, //kCCAlgorithmAES128,
									 kCCOptionECBMode, //kCCOptionPKCS7Padding,
									 key,
									 kCCKeySizeDES,
									 NULL,
									 dataIn,
									 len,
									 dataOut,
									 bufsize,
									 pMovedBytes); 
	if (result == kCCSuccess)
		NSLog(@"enDES SUCCESS");
    else if (result == kCCParamError)
		NSLog(@"PARAM ERROR");
	else if (result == kCCBufferTooSmall)
		NSLog(@"BUFFER TOO SMALL");
	else if (result == kCCMemoryFailure)
		NSLog(@"MEMORY FAILURE");
	else if (result == kCCAlignmentError)
		NSLog(@"ALIGNMENT");
	else if (result == kCCDecodeError)
		NSLog(@"DECODE ERROR");
	else if (result == kCCUnimplemented)
		NSLog(@"UNIMPLEMENTED");
	
	return TRUE;
}

BOOL un3DES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes)
{
	//	char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
	//	bzero( keyPtr, sizeof(keyPtr) ); // fill with zeroes (for padding)
	
	// fetch key data
	//	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	if (dataIn == NULL) {
		NSLog(@"un3DES input is empty!");
		return FALSE;
	}
	
	bzero(dataOut, bufsize);
	CCCryptorStatus result = CCCrypt(kCCDecrypt,
									 kCCAlgorithm3DES, //kCCAlgorithmAES128,
									 kCCOptionECBMode, //kCCOptionPKCS7Padding,
									 key,
									 kCCKeySize3DES,
									 NULL,
									 dataIn,
									 len,
									 dataOut,
									 bufsize,
									 pMovedBytes);
	if (result == kCCSuccess)
		NSLog(@"un3DES SUCCESS");
    else if (result == kCCParamError)
		NSLog(@"PARAM ERROR");
	else if (result == kCCBufferTooSmall)
		NSLog(@"BUFFER TOO SMALL");
	else if (result == kCCMemoryFailure)
		NSLog(@"MEMORY FAILURE");
	else if (result == kCCAlignmentError)
		NSLog(@"ALIGNMENT");
	else if (result == kCCDecodeError)
		NSLog(@"DECODE ERROR");
	else if (result == kCCUnimplemented)
		NSLog(@"UNIMPLEMENTED");
	
	return TRUE;
}

BOOL en3DES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes)
{
	//	char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
	//	bzero( keyPtr, sizeof(keyPtr) ); // fill with zeroes (for padding)
	
	// fetch key data
	//	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	bzero(dataOut, bufsize);
	CCCryptorStatus result = CCCrypt(kCCEncrypt,
									 kCCAlgorithm3DES, //kCCAlgorithmAES128,
									 kCCOptionECBMode, //kCCOptionPKCS7Padding,
									 key,
									 kCCKeySize3DES,
									 NULL,
									 dataIn,
									 len,
									 dataOut,
									 bufsize,
									 pMovedBytes); 
	if (result == kCCSuccess)
		NSLog(@"en3DES SUCCESS");
    else if (result == kCCParamError)
		NSLog(@"PARAM ERROR");
	else if (result == kCCBufferTooSmall)
		NSLog(@"BUFFER TOO SMALL");
	else if (result == kCCMemoryFailure)
		NSLog(@"MEMORY FAILURE");
	else if (result == kCCAlignmentError)
		NSLog(@"ALIGNMENT");
	else if (result == kCCDecodeError)
		NSLog(@"DECODE ERROR");
	else if (result == kCCUnimplemented)
		NSLog(@"UNIMPLEMENTED");
	
	return TRUE;
}


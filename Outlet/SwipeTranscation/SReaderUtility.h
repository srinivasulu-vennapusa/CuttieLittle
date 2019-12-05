/*
 *  SReaderUtility.h
 *  SReaderV1.0
 *
 *  Created by z b on 12-7-13.
 *  Copyright 2012 h. All rights reserved.
 *
 */

unsigned char *SReader_Initial(void);
unsigned char *SReader_GetVersion(void);
unsigned char *SReader_GetKSN(void);
unsigned char *SReader_GetRandom(void);
unsigned char *SReader_GenerateWorkingKey(void);

unsigned char *SReader_T1_PAN(void);
unsigned char *SReader_T1_ExD(void);
unsigned char *SReader_T2_PAN(void);
unsigned char *SReader_T2_ExD(void);

unsigned char * SReader_ReadCard(int *size);
void* SReader_Cancel();
BOOL TriDesDecryptio(void *dataIn, int len, void *dataOut, int bufsize, size_t *pMovedBytes);

int setMainKey(char *new_MainKey);
unsigned char *get_CurrentVersion(void);
unsigned char *get_CurrentKSN(void);
unsigned char *get_CurrentRandom(void);
unsigned char *get_CurrentCounter(void);
unsigned char *get_CurrentWorkingKey(void);

NSString *Hex2NSString(unsigned char buffer[], int len);

BOOL Hex2String(unsigned char buffer[], int len, unsigned char hexstring[], int manlen, int *retnum);
BOOL String2Hex(unsigned char hexstring[], int len, unsigned char buffer[], int maxlen, int *retnum);


BOOL unDES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes);
BOOL enDES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes);
BOOL un3DES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes);
BOOL en3DES(void *dataIn, int len, unsigned char *key, void *dataOut, int bufsize, size_t *pMovedBytes);



//
//  WisePadController.h
//  WisePadAPI
//
//  Created by Alex on 2013-07-05.
//  Copyright 2013 MSwipe LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <ExternalAccessory/ExternalAccessory.h>

typedef enum {
    WisePadControllerState_CommLinkUninitialized,
    WisePadControllerState_Idle,
    WisePadControllerState_WaitingForResponse,
    WisePadControllerState_Printing //Added in 2.1.0
} WisePadControllerState;

typedef enum {
    WisePadBatteryStatus_Low,
    WisePadBatteryStatus_CriticallyLow
} WisePadBatteryStatus;

typedef enum {
    WisePadEmvOption_Start,
    WisePadEmvOption_StartWithForceOnline
} WisePadEmvOption;

typedef enum {
    WisePadCheckCardResult_NoCard,
    WisePadCheckCardResult_InsertedCard,
    WisePadCheckCardResult_NotIccCard,
    WisePadCheckCardResult_BadSwipe,
    WisePadCheckCardResult_SwipedCard,
    WisePadCheckCardResult_MagHeadFail,
    WisePadCheckCardResult_NoResponse,
    WisePadCheckCardResult_OnlyTrack2
} WisePadCheckCardResult;

typedef enum {
    WisePadErrorType_InvalidInput,
	WisePadErrorType_InvalidInput_NotNumeric,
    WisePadErrorType_InvalidInput_InputValueOutOfRange,
    WisePadErrorType_InvalidInput_InvalidDataFormat,
    WisePadErrorType_InvalidInput_NoAcceptAmountForThisTransactionType,
    WisePadErrorType_InvalidInput_NotAcceptCashbackForThisTransactionType,

    WisePadErrorType_DeviceReset,
    WisePadErrorType_CommandNotAvailable,
    WisePadErrorType_CommError,
    WisePadErrorType_Unknown,
    WisePadErrorType_IllegalStateException,
    
    WisePadErrorType_BTv2FailToStart,
    WisePadErrorType_BTv4FailToStart,
    
    WisePadErrorType_InvalidFunctionInBTv2Mode,
    WisePadErrorType_InvalidFunctionInBTv4Mode,
    
    WisePadErrorType_CommLinkUninitialized,
    WisePadErrorType_BTv4Unsupported,       //Added in 1.1.0
    WisePadErrorType_DeviceError,           //Added in 1.1.0
    
    WisePadErrorType_InvalidFunctionInAudioMode, //Added in 2.1.0
    WisePadErrorType_BTv4AlreadyConnected  //Added in 2.4.0
    
} WisePadErrorType;

typedef enum {
    WisePadTransactionResult_Approved,
    WisePadTransactionResult_Terminated,
    WisePadTransactionResult_Declined,
    WisePadTransactionResult_SetAmountCancelOrTimeout,
    WisePadTransactionResult_CapkFail,
    WisePadTransactionResult_NotIcc,
    WisePadTransactionResult_SelectApplicationFail,
    WisePadTransactionResult_TdkError,
    WisePadTransactionResult_ApplicationBlocked,    //Added in 2.2.0
    WisePadTransactionResult_IccCardRemoved         //Added in 2.4.3
} WisePadTransactionResult;

typedef enum {
    WisePadTransactionType_Goods,
    WisePadTransactionType_Services,
    WisePadTransactionType_Cashback,
    WisePadTransactionType_Inquiry,
    WisePadTransactionType_Transfer,
    WisePadTransactionType_Payment,
    WisePadTransactionType_Refund   //Added in 2.4.3
} WisePadTransactionType;

typedef enum {
    WisePadReferProcessResult_Approved,
    WisePadReferProcessResult_Declined
} WisePadReferProcessResult;

typedef enum {
    WisePadDisplayText_AMOUNT_OK_OR_NOT,
    WisePadDisplayText_APPROVED,
    WisePadDisplayText_CALL_YOUR_BANK,
    WisePadDisplayText_CANCEL_OR_ENTER,
    WisePadDisplayText_CARD_ERROR,
    WisePadDisplayText_DECLINED,
    WisePadDisplayText_ENTER_PIN,
    WisePadDisplayText_INCORRECT_PIN,
    WisePadDisplayText_INSERT_CARD,
    WisePadDisplayText_NOT_ACCEPTED,
    WisePadDisplayText_PIN_OK,
    WisePadDisplayText_PLEASE_WAIT,
    WisePadDisplayText_PROCESSING_ERROR,
    WisePadDisplayText_REMOVE_CARD,
    WisePadDisplayText_USE_CHIP_READER,
    WisePadDisplayText_USE_MAG_STRIPE,
    WisePadDisplayText_TRY_AGAIN,
    WisePadDisplayText_REFER_TO_YOUR_PAYMENT_DEVICE,
    WisePadDisplayText_TRANSACTION_TERMINATED,
    WisePadDisplayText_TRY_ANOTHER_INTERFACE,
    WisePadDisplayText_ONLINE_REQUIRED,
    WisePadDisplayText_PROCESSING,
    WisePadDisplayText_WELCOME,
    WisePadDisplayText_PRESENT_ONLY_ONE_CARD,
    WisePadDisplayText_LAST_PIN_TRY,
    WisePadDisplayText_CAPK_LOADING_FAILED
} WisePadDisplayText;

typedef enum {
    WisePadPinEntryResult_PinEntered,               //For both EMV and SwipeCard
    WisePadPinEntryResult_Cancel,                   //For both EMV and SwipeCard
    WisePadPinEntryResult_Timeout,                  //For both EMV and SwipeCard
    WisePadPinEntryResult_KeyError,                 //For SwipeCard only
    WisePadPinEntryResult_ByPass,                   //For EMV only
    WisePadPinEntryResult_NoPin,                    //For SwipeCard only            //Added in 1.4.0-Beta3
    WisePadPinEntryResult_WrongPinLength,           //For SwipeCard only            //Added in 1.4.0-Beta3
    WisePadPinEntryResult_IncorrectPin              //For EMV only                  //Added in 2.1.0
    //WisePadPinEntryResult_NoPinOrWrongPinLength   //Deprecated in 1.4.0-Beta3
} WisePadPinEntryResult;

typedef enum {
    CurrencyCharacter_A, CurrencyCharacter_B, CurrencyCharacter_C, CurrencyCharacter_D, CurrencyCharacter_E,
    CurrencyCharacter_F, CurrencyCharacter_G, CurrencyCharacter_H, CurrencyCharacter_I, CurrencyCharacter_J,
    CurrencyCharacter_K, CurrencyCharacter_L, CurrencyCharacter_M, CurrencyCharacter_N, CurrencyCharacter_O,
    CurrencyCharacter_P, CurrencyCharacter_Q, CurrencyCharacter_R, CurrencyCharacter_S, CurrencyCharacter_T,
    CurrencyCharacter_U, CurrencyCharacter_V, CurrencyCharacter_W, CurrencyCharacter_X, CurrencyCharacter_Y,
    CurrencyCharacter_Z,
    CurrencyCharacter_Space,
    
    CurrencyCharacter_Dirham,
    CurrencyCharacter_Dollar,
    CurrencyCharacter_Euro,
    CurrencyCharacter_IndianRupee,
    CurrencyCharacter_Pound,
    CurrencyCharacter_SaudiRiyal,
    CurrencyCharacter_SaudiRiyal2,
    CurrencyCharacter_Won,
    CurrencyCharacter_Yen,
    
    CurrencyCharacter_SlashAndDot,  //Added in 2.1.0
    CurrencyCharacter_Dot           //Added in 2.4.4
} CurrencyCharacter;                //Added in 1.4.0-Beta3

typedef enum {
    WisePadPrinterResult_Success,
    WisePadPrinterResult_NoPaperOrCoverOpened,
    WisePadPrinterResult_WrongPrinterCommand
}WisePadPrinterResult; //Added in 2.1.0

typedef enum {
    WisePadPhoneEntryResult_Entered,
    WisePadPhoneEntryResult_Timeout,
    WisePadPhoneEntryResult_WrongLength,
    WisePadPhoneEntryResult_Cancel,
    WisePadPhoneEntryResult_Bypass
}WisePadPhoneEntryResult; //Added in 2.1.0

typedef enum {
    WisePadTerminalSettingStatus_Success,
    WisePadTerminalSettingStatus_InvalidTlvFormat,
    WisePadTerminalSettingStatus_TagNotFound,
    WisePadTerminalSettingStatus_IncorrectLength,
    WisePadTerminalSettingStatus_BootLoaderNotSupported
}WisePadTerminalSettingStatus;

typedef enum {
    WisePadCheckCardMode_SwipeOrInsert,
    WisePadCheckCardMode_Swipe,
    WisePadCheckCardMode_Insert
}WisePadCheckCardMode;

/*
typedef enum {
    WisePadStartEmvResult_Success,
    WisePadStartEmvResult_Fail
} WisePadStartEmvResult; //Deprecated in 2.1.0
*/

@protocol WisePadControllerDelegate;

@interface WisePadController : NSObject {
	NSObject <WisePadControllerDelegate>* delegate;
}

@property (nonatomic, assign) NSObject <WisePadControllerDelegate>* delegate;

- (NSString *)getApiVersion;
- (NSString *)getApiBuildNumber;

- (NSDictionary *)getIntegratedApiVersion;
- (NSDictionary *)getIntegratedApiBuildNumber;

+ (WisePadController *)sharedController;
- (WisePadControllerState)getWisePadControllerState;
- (void)releaseWisePadController;   //Added in 1.4.0 for both ARC and non-ARC
- (BOOL)isDevicePresent;

// --- Function of Transaction Flow ---
- (void)getDeviceInfo;
- (BOOL)setAmount:(NSString *)amount
   cashbackAmount:(NSString *)cashbackAmount
     currencyCode:(NSString *)currencyCode
  transactionType:(WisePadTransactionType)transactionType
currencyCharacters:(NSArray *)currencyCharacters;           //Updated in 1.4.0-Beta3
- (void)checkCard;
- (void)checkCard:(NSDictionary *)data; //Added in 2.4.2, checkCardMode require FW 
- (void)startSwipe;         //Added in 2.2.0
- (void)startEmv:(WisePadEmvOption)WisePadEmvOption;
- (void)startPinEntry;      //Added in 1.2.0
- (void)selectApplication:(int)applicationIndex;
- (void)sendFinalConfirmResult:(BOOL)isConfirmed;
- (void)sendServerConnectivity:(BOOL)isConnected;
- (void)sendOnlineProcessResult:(NSString *)tlv;

// Cancel
- (void)cancelCheckCard; //Added in 1.1.0
- (void)cancelSetAmount;
- (void)cancelSelectApplication;

// Enable Input Amount Mode
- (void)enableInputAmount:(NSString *)currencyCode
       currencyCharacters:(NSArray *)currencyCharacters;    //Added in 2.1.0
- (void)disableInputAmount;                                 //Added in 2.1.0

// Printer
- (void)startPrinting:(int)numOfData
 printNextDataTimeout:(int)printNextDataTimeout
       noPaperTimeout:(int)noPaperTimeout; //Added in 2.1.0
- (void)sendPrinterData:(NSData *)data;    //Added in 2.1.0

// Phone Number
- (void)startGetPhoneNumber; //Added in 2.1.0
- (void)cancelGetPhoneNumber; //Added in 2.1.0

// Encrypt Data
- (void)encryptData:(NSString *)data; //Added in 2.1.0

// Other
- (void)getEmvCardData; //Added in 2.1.0
- (NSDictionary *)decodeTlv:(NSString *)tlv;

// Communication Channel - Audio
- (BOOL)startAudio; //Added in 2.1.0
- (void)stopAudio; //Added in 2.1.0

// Communication Channel - BTv4
- (void)scanBTv4:(NSArray *)deviceNameArray;
- (void)scanBTv4:(NSArray *)deviceNameArray scanTimeout:(int)scanTimeout; //Addded in 2.1.0
- (void)stopScanBTv4;
- (void)connectBTv4:(CBPeripheral *)peripheral connectTimeout:(int)connectTimeout;
- (void)connectBTv4withUUID:(NSString *)UUID connectTimeout:(int)connectTimeout;   //Added in 2.1.0
- (void)disconnectBTv4;
- (NSString *)getPeripheralUUID:(CBPeripheral *)peripheral; //Added in 2.1.0

// Terminal Setting
- (void)readTerminalSetting:(NSString *)tag;
- (void)updateTerminalSetting:(NSString *)tlv;

                                               //Deprecated in 1.4.0

@end

@protocol WisePadControllerDelegate <NSObject>

@optional

- (void)onWisePadBatteryLow:(WisePadBatteryStatus)batteryStatus;

// Callback of Result
- (void)onWisePadReturnDeviceInfo:(NSDictionary *)deviceInfoDict;
- (void)onWisePadReturnCheckCardResult:(WisePadCheckCardResult)result cardDataDict:(NSDictionary *)cardDataDict;
- (void)onWisePadReturnCancelCheckCardResult:(BOOL)isSuccess;  //Added in 2.0.0
- (void)onWisePadReturnBatchData:(NSString *)tlv;
- (void)onWisePadReturnTransactionResult:(WisePadTransactionResult)result data:(NSDictionary *)data; //Updated in 2.4.0
- (void)onWisePadReturnReversalData:(NSString *)tlv;
- (void)onWisePadReturnPinEntryResult:(WisePadPinEntryResult)result
                                  epb:(NSString *)epb
                                  ksn:(NSString *)ksn;

// Callback of Request
- (void)onWisePadWaitingForCard;                //Added in 1.1.0
- (void)onWisePadRequestInsertCard;             //Added in 1.1.0
- (void)onWisePadRequestSelectApplication:(NSArray *)applicationArray;
- (void)onWisePadRequestPinEntry;
- (void)onWisePadRequestCheckServerConnectivity;
- (void)onWisePadRequestOnlineProcess:(NSString *)tlv;
- (void)onWisePadRequestFinalConfirm;
- (void)onWisePadRequestDisplayText:(WisePadDisplayText)displayMessage;
- (void)onWisePadRequestClearDisplay;

// Callback of Error
- (void)onWisePadError:(WisePadErrorType)WisePadErrorType errorMessage:(NSString *)errorMessage;

// Amount
- (void)onWisePadRequestSetAmount;
- (void)onWisePadReturnAmountConfirmResult:(BOOL)isConfirmed;
- (void)onWisePadReturnAmount:(NSString *)amount currencyCode:(NSString *)currencyCode;      //Added in 2.1.0
- (void)onWisePadReturnEnableInputAmountResult:(BOOL)isSuccess;     //Added in 2.1.0
- (void)onWisePadReturnDisableInputAmountResult:(BOOL)isSuccess;    //Added in 2.1.0

// Printer
- (void)onWisePadRequestPrinterData:(int)index isReprint:(BOOL)isReprint; //Added in 2.1.0
- (void)onWisePadReturnPrinterResult:(WisePadPrinterResult)result; //Added in 2.1.0
- (void)onWisePadPrinterOperationEnd; //Added in 2.1.0

// Phone Number
- (void)onWisePadReturnPhoneNumber:(WisePadPhoneEntryResult)result phoneNumber:(NSString *)phoneNumber;  //Added in 2.1.0

// Encrypt Data
- (void)onWisePadReturnEncryptDataResult:(NSString *)encryptedData ksn:(NSString *)ksn; //Added in 2.1.0

// New EMV Kernel
- (void)onWisePadReturnFailureMessage:(NSString *)tlv;  //Added in 2.4.0
- (void)onWisePadRequestVerifyID:(NSString *)tlv;       //Added in 2.4.0

// Terminal Setting
- (void)onWisePadReturnReadTerminalSettingResult:(WisePadTerminalSettingStatus)status tagValue:(NSString *)tagValue;
- (void)onWisePadReturnUpdateTerminalSettingResult:(WisePadTerminalSettingStatus)status;

// Other
- (void)onWisePadReturnEmvCardDataResult:(NSString *)tlv; //Added in 2.1.0

// Communication Channel - Audio
- (void)onWisePadDevicePlugged;     //Added in 2.1.0
- (void)onWisePadDeviceUnplugged;   //Added in 2.1.0
- (void)onWisePadNoDeviceDetected;  //Added in 2.1.0

// Communication Channel - BTv4
- (void)onWisePadBTv4DeviceListRefresh:(NSArray *)foundDevices; //Updated in 1.3.0
- (void)onWisePadBTv4Connected;
- (void)onWisePadBTv4Connected:(CBPeripheral *)connectedPeripheral; //Added in 2.1.0
- (void)onWisePadBTv4Disconnected;
- (void)onWisePadBTv4ScanTimeout;
- (void)onWisePadBTv4ConnectTimeout;
- (void)onWisePadRequestEnableBluetoothInSettings;


@end

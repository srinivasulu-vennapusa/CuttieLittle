//
//  MSConstants.h
//  mSwipe
//
//  Created by satish nalluru on 06/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
    #define HEIGHT_IPHONE_5 568
    #define IS_IPHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    #define IS_IPHONE_5 ([[UIScreen mainScreen] bounds ].size.height == HEIGHT_IPHONE_5 )

    #define SERVER_NAME @"Mswipe's"
    #define COMPANY_NAME @"Mswipe"
    
    #define WELCOME_MSG @"Welcome to " COMPANY_NAME
    
//help mesage
     #define HELP_LINE_NO @"1800 1022699"
     #define HELP_EMIL_ID @"helpdesk@mswipe.com"
// comman messages	
     
    #define MSWIPE_ERROR_RESPONSE  @"invalid response from the " SERVER_NAME @" server, please try  again."
	#define MSWIPE_RESENTRECIEPT_ALERTMSG @"would you like to resend the receipt for the selected transaction?"
	#define MSWIPE_RESENTRECIEPT_ERROR_PROCESSING @"error in re-sending the receipt."
	#define MSWIPE_RESENTRECIEPT_SUCCESS_PROCESSING @"the receipt was successfully resent."
	#define MSWIPE_ERROR_INDECRYPTINGKEY @"data decryption error."
	#define MSWIPE_ERROR_INENRYPTINGKEY @"data encryption error."

	// Network errors
	#define MSWIPER_ERROR_INTERNET @"error connecting to the internet, please try again"
	#define MSWIPER_ERROR_INTERNET_URL @"incorrect request accessing the network."
	#define MSWIPER_ERROR_INTERNET_URL_RESPONSE @"unable to connect to " SERVER_NAME @" server, HTTP error code@"
	//"Unable to connect to mSwiper server, " + httpConn.getResponseCode() + " "  + httpConn.getResponseMessage(), after Http error code the code is shown, and the client time out message to does appear here

    //bank sale
    #define BANKSALE_DIALOG_MSG @"bank sale "
    #define BANKSALE_ALERT_AMOUNTMSG @"the total bank sale amount is %@ %@"
    #define BANKSALE_ERROR_PROCESSIING_DATA @"error in processing bank Sale. "
    #define BANKSALE_ERROR_invalidChequeNO  @"required length of the cheque no. is 6 digits"
    
        
    // for Bank history
	#define BANKHISTORYLIST_DIALOG_MSG @"bank history"
	#define BANKHISTORYLIST_GET_HISTROYDATA @"fetch the latest bank history?"
    #define BANKHISTORYLIST_ERROR_PROCESSIING_DATA @"error in processing bank history, please try again."
	#define BANKHISTORYLIST_ERROR_NODATA_FOUND @"no bank history found on the " SERVER_NAME @" server."

    //summary
    #define BANKSUMMARY_DIALOG_MSG @"bank summary"
	#define BANKSUMMARY_ERROR_PROCESSIING_DATA @"error in processing day summary, please try again later."
	#define BANKSUMMARY_ERROR_NODATA_FOUND @"no bank summary found on the " SERVER_NAME @" server, please check the date and try again."


    //cash sale
	#define CASHSALE_DIALOG_MSG @"cash sale "
    #define CASHSALE_ALERT_AMOUNTMSG @"the total cash sale amount is %@ %@"
    #define CASHSALE_ERROR_PROCESSIING_DATA @"error in processing cash Sale. "
    #define CASHSALE_ERROR_receiptvalidation @"Please enter a valid invoice/receipt number. "
    
    
    //summary
    #define CASHSUMMARY_DIALOG_MSG @"cash summary"
	#define CASHSUMMARY_ERROR_PROCESSIING_DATA @"error in processing day summary, please try again later."
	#define CASHSUMMARY_ERROR_NODATA_FOUND @"no cash summary found on the " SERVER_NAME @" server, please check the date and try again."

    //history
	#define CASHHISTORYLIST_DIALOG_MSG @"cash history"
	#define CASHHISTORYLIST_GET_HISTROYDATA @"fetch the latest cash history?"
	#define CASHHISTORYLIST_ERROR_PROCESSIING_DATA @"error in processing cash history, please try again."
	#define CASHHISTORYLIST_ERROR_NODATA_FOUND @"no cash history found on the " SERVER_NAME @" server."


	// for Batch history
	#define BATCHHISTORYLIST_DIALOG_MSG @"batch history"
	#define BATCHHISTORYLIST_GET_HISTROYDATA @"fetch the latest batch history?"
	#define BATCHHISTORYLIST_ERROR_PROCESSIING_DATA @"error in processing batch history, please try again."
	#define BATCHHISTORYLIST_ERROR_NODATA_FOUND @"no batch history found on the " SERVER_NAME @" server."

	// for Card history
	#define CARDHISTORYLIST_DIALOG_MSG @"history"
	#define CARDHISTORYLIST_GET_HISTROYDATA @"Fetch the latest card sale history?"
	#define CARDHISTORYLIST_ERROR_PROCESSIING_DATA @"Error in processing card sale history, please try again."
	#define CARDHISTORYLIST_ERROR_NODATA_FOUND @"no card sale history found on the " SERVER_NAME @" server."

	// Card Summary
	#define CARDSUMMARY_DIALOG_MSG @"card summary"
	#define CARDSUMMARY_ERROR_PROCESSIING_DATA @"nrror in processing day summary, please try again later."
	#define CARDSUMMARY_ERROR_NODATA_FOUND @"no card summary found on the " SERVER_NAME @" server, please check the date and try again."

	// change password and Login
	#define PWD_DIALOG_MSG @"change password"
	#define PWD_ERROR_INVALIDPWD @"please enter valid password."
	#define PWD_ERROR_INVALIDPWDLENGTH @"minimum length of the password should be 6 characters."
	#define PWD_ERROR_INVALIDPWDMAXLENGTH @"length of the password should be between 6 and 10 characters."

	#define PWD_ERROR_INVALIDPWDNEWLENGTH @"minimum length of the new password should be 6 characters."
	#define PWD_ERROR_INVALIDPWDMAXNEWLENGTH @"length of the new password should be between 6 and 10 characters."
	#define PWD_ERROR_INVALIDPWDRETYPELENGTH @"minimum length of the re-entered password should be 6 characters."
	#define PWD_ERROR_INVALIDNEWANDRETYPE @"new passwords do not match."
	#define PWD_CHANGEPWD_CONFIRMATION @"Would you like to change the password?"
	#define PWD_ERROR_PROCESSIING_DATA @"error in processing your change password request."
	#define PWD_ERROR_FIRSTTIMELOGIN @"first time login need to change the password to proceed."

	// card sale
    #define CARDSALE_DIALOG_MSG @"sale "
    #define CARDSALE_ERROR_INVALIDAMT @"Invalid amount! Minimum amount should be %@ 1.00 to proceed. "
    #define CARDSALE_ERROR_INVALIDCARDDIGITS @"Invalid last 4 digits. "
    #define CARDSALE_ALERT_AMOUNTMSG @"The total card sale amount is %@ %@"

    #define CARDSALE_ALERT_swiperAMOUNTMSG @"total amount of this transaction \nis %s  "
    #define CARDSALE_ERROR_mobilenolen @"required length of the mobile number is %d digits. "
    #define CARDSALE_ERROR_mobileformat @"the mobile number cannot start with 0. "
    #define CARDSALE_ERROR_receiptvalidation @"please enter a reference number. "
    #define CARDSALE_ERROR_receiptmandatory @"receipt mandatory for this transaction, please un check the field to proceed "


    #define CARDSALE_ERROR_email @"invalid e-mail address. "

    #define CARDSALE_ERROR_LstFourDigitsNotMatched @"last 4 digits don't match, bad card. "
    #define CARDSALE_ERROR_PROCESSIING_DATA @"error in processing Card Sale. "

    #define CARDSALE_AMEX_Validation @"invalid Amex card security code, should be 4 digits length."

    #define CARDSALE_Sign_Validation @"receipt needs to be signed to proceed. "
    #define CARDSALE_Sign_ERROR_PROCESSIING_DATA @"error in uploading the receipt to " SERVER_NAME @" server. "
    #define CARDSALE_Sign_SUCCESS_Msg @"receipt successfully uploaded to " SERVER_NAME @" server. "

    
    
    #define CARDSALE_AUTO_REVERSAL @"auto reversal successfull. "
    #define CARDSALE_ERROR_FO35 @"error in processing Card Sale. "
    #define CARDSALE_REMOVED_CARD_MSG @"please remove the card."

    #define CARDSALE_PROCESSING_TRX_MSG @"processing transaction..."
    #define CARDSALE_ACKN_MSG @"acknowledging card sale..."
    #define CARDSALE_AUTO_REVERSAL_MSG @"processing auto reversal Tx..."
    #define CARDSALE_SENDONLINE_TRX_MSG @"please wait, processing Tx..."
    
    #define SWIPER_STEP2 @"detecting device"
    #define SWIPER_STEP21 @"device detected"
    

	// last transaction
	#define LSTTRXST_DIALOG_MSG @"last tx status"
	#define LSTTRXST_ERROR_FETCHING_DATA @"error in fetching last tx details."
	#define LSTTRXST_ERROR_Processing_DATA @"error in processing the last transaction request."
	#define LSTTRXST_Success_msg @"the receipt was successfully resent."
    #define LSTTRXST_NODATAFOUND @"no  transaction found on " SERVER_NAME @" server."
	// Login
	#define LOGIN_DIALOG_MSG  @"login"
	#define LOGIN_ERROR_ValidUserMsg    @"please enter a valid username and password."
	#define LOGIN_ERROR_Processing_DATA @"unable to login, please try again."
	#define LOGIN_Processing @"logging in..."

	// void
	#define VOID_DIALOG_MSG @"void sale"
	#define VOID_ERROR_Processing_DATA @"error in processing the void sale request."
	#define VOID_ERROR_Processing_FLAG @"error in updating the void sale flag."
	#define VOID_ALERT_AMOUNTMSG  @"proceed to void card sale of %@ %@ for the card ending with last 4 digits %@?"
	
    #define VOID_ALERT_FORVOID  @"would you like to void the selected transaction dated %@ of %@ %@ for the card with the last 4 digits %@?"
	
	
	#define VOID_NODATAFOUND @"no matching transaction found on " SERVER_NAME @" server."
    #define VOID_ERROR_INVALIDRRNO   @"required length of the rrno is 12 digits!"
    //Menu
    #define MAIN_MENU_TITLE @"main menu"
	
    

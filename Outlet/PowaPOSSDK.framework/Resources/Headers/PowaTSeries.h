//
//  POWATSeries.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "POWAPrinter.h"
#import "POWAScanner.h"
#import "POWACashDrawer.h"
#import "POWAPeripheral.h"
#import "POWARotationSensor.h"
#import "PowaFirmwareInfo.h"

enum
{
	kUSBInternal,
    kUSBCOMPort1,
    kUSBCOMPort2
};
typedef NSUInteger PowaUSBCOMPort;

typedef NS_ENUM(UInt8, PowaTSeriesPrinterResult)
{
    PowaTSeriesPrinterResultSuccessfull = 0x00,
    PowaTSeriesPrinterResultErrorHeadUp = 0x01,
    PowaTSeriesPrinterResultErrorOutOfPaper = 0x02,
    PowaTSeriesPrinterResultErrorVoltage = 0x03,
    PowaTSeriesPrinterResultErrorThermalMotor = 0x04,
    PowaTSeriesPrinterResultErrorHardware = 0x05,
    PowaTSeriesPrinterResultErrorReceivingData = 0x06,
    PowaTSeriesPrinterResultReady = 0x07
};
typedef void(^PowaTSeriesSystemConfigurationHandler)(NSDictionary *configuration);


typedef NS_ENUM(UInt8, PowaTSeriesAvailableFirmwareResult)
{
	PowaTSeriesAvailableFirmwareResultNewFirmwareAvailable = 0x00,
	PowaTSeriesAvailableFirmwareResultNewFirmwareNotAvailable = 0x01,
	PowaTSeriesAvailableFirmwareResultConnectionError = 0x02
};

typedef NS_ENUM(UInt8, PowaTSeriesDownloadFirmwareResult)
{
	PowaTSeriesDownloadFirmwareResultDownloaded = 0x00,
	PowaTSeriesDownloadFirmwareResultDownloadFailed = 0x01,
	PowaTSeriesDownloadFirmwareResultNotFound = 0x02,
	PowaTSeriesDownloadFirmwareResultConnectionError = 0x03
};

typedef NS_ENUM(UInt8, PowaTSeriesFirmwareHistoryResult)
{
	PowaTSeriesFirmwareHistoryResultSuccessful = 0x00,
	PowaTSeriesFirmwareHistoryResultConnectionError = 0x01
};

// Completion handler for the request firmware history method
typedef void(^PowaTSeriesFirmwareHistoryResultCompletionHandler)(NSArray *availableFirmwares, PowaTSeriesFirmwareHistoryResult result);

// Completion handler for the request latest firmware method
typedef void(^PowaTSeriesLatestFirmwareResultCompletionHandler)(PowaFirmwareInfo *latestFirmware, PowaTSeriesFirmwareHistoryResult result);

// Completion handler for the check available firmware method
typedef void(^PowaTSeriesAvailableFirmwareResultCompletionHandler)(PowaTSeriesAvailableFirmwareResult result);

// Completion handler for the download firmware methods
typedef void(^PowaTSeriesDownloadFirmwareCompletionHandler)(NSData *updateData,
															PowaTSeriesDownloadFirmwareResult result);

@class EAAccessory;

@interface PowaTSeries : NSObject <PowaPeripheral, PowaPrinter, PowaScanner, PowaCashDrawer, PowaRotationSensor>
{
}

#pragma mark - TSeries Information Properties

/**
 The firmware version for this device
 @brief Returns the firmware version
 @return the firmware version
*/

@property (nonatomic, readonly) NSString *firmwareVersion;

/**
 The hardware version for this device

 @brief Returns the hardware version
 @return the hardware version
*/

@property (nonatomic, readonly) NSString *hardwareVersion;

/**
 The serial number for this device

 @brief Returns serial number for this device
 @return the serial number
*/

@property (nonatomic, readonly) NSString *serialNumber;

/**

 @brief Returns whether the system in in firmware update mode
 @return whether a firmware update is required
 */

@property (nonatomic, readonly) BOOL *firmwareUpdateNeeded;

#pragma mark - Initializers

/*!
 * @brief Initializes a new PowaTSeries device
 * @discussion Initializes a new PowaTSeries device
 * @param accessory the accessory to use to initialize the new PowaTSeries
 * @return returns a new PowaTSeries
 * @updated 01-09-2015
 */

- (id)initWithAccessory:(EAAccessory *)accessory;

/*!
 * @brief Initializes a new PowaTSeries device
 * @discussion Initializes a new PowaTSeries device
 * @param accessory the accessory to use to initialize the new PowaTSeries
 * @param whether to print a newline on the printer when the SDK initializes
 * @return returns a new PowaTSeries
 * @updated 01-09-2015
 */

- (id)initWithAccessory:(EAAccessory *)accessory newline:(BOOL)newline;

#pragma mark - Firmware/Bootload Update

/*!
 * @brief Starts a new firmware update using the firmware data that was passed in
 * @discussion Starts a new firmware update using the firmware data
 * @param data the firmware update data
 * @updated 01-09-2015
 */

- (void)startFirmwareUpdateWithData:(NSData *)data;

/*!
 * @brief Starts a new bootcode update using the bootcode data that was passed in
 * @discussion Starts a new bootcode update using the bootcode data
 * @param data the bootcode update data
 * @updated 01-09-2015
 */

- (void)startBootcodeUpdateWithData:(NSData *)data;

#pragma mark - TSeries Control Methods

/*!
 * @brief This method restarts the TSeries
 * @discussion This method restarts the TSeries
 * @updated 01-09-2015
 */

- (void)restart;

/*!
 * @brief Resets the internal sequence numbers in the TSeries
 * @discussion Resets the internal sequence numbers in the TSeries
 * @updated 01-09-2015
 */

- (void)resetSequenceNumbers;

/*!
 * @brief Request system configuration
 * @discussion Request system configuration
 * @updated 01-09-2015
 */

- (void)requestSystemConfigurationWithCompletionHandler:(PowaTSeriesSystemConfigurationHandler)handler;

#pragma mark - HTTP Firmware Update

/*!
 * @brief Requests a history of the available firmware versions at a given server
 * @discussion Requests a history of the available firmware versions
 * @updated 01-09-2015
 */

- (void)requestFirmwareHistoryWithURL:(NSString *)url
					completionHandler:(PowaTSeriesFirmwareHistoryResultCompletionHandler)handler;

/*!
 * @brief Requests the latest firmware version
 * @discussion Requests the latest firmware version
 * @updated 01-09-2015
 */

- (void)requestLatestFirmwareWithURL:(NSString *)url
				   completionHandler:(PowaTSeriesLatestFirmwareResultCompletionHandler)handler;

/*!
 * @brief Checks whether there is a newer firmware version available
 * @discussion Checks whether there is a newer firmware version available
 * @updated 01-09-2015
 */

- (void)checkAvailableFirmwareWithURL:(NSString *)url
					completionHandler:(PowaTSeriesAvailableFirmwareResultCompletionHandler)handler;

/*!
 * @brief Downloads the latest firmware version
 * @updated 01-09-2015
 */

- (void)downloadLatestFirmwareWithURL:(NSString *)url
					completionHandler:(PowaTSeriesDownloadFirmwareCompletionHandler)handler;

/*!
 * @brief Downloads a specific firmware version (can be obtained using the requestFirmwareHistory method)
 * @updated 01-09-2015
 */

- (void)downloadFirmwareWithURL:(NSString *)urlString
						version:(NSString *)version
			  completionHandler:(PowaTSeriesDownloadFirmwareCompletionHandler)handler;


#pragma mark - FTP Firmware Update

/*!
 * @brief Requests a history of the available firmware versions at a given server
 * @discussion Requests a history of the available firmware versions
 * @param url the ftp domain and path; Eg: myupdate.powa.com/T25/
 * @param username the ftp username
 * @param password the ftp password
 * @updated 01-09-2015
 */

- (void)requestFirmwareHistoryWithURL:(NSString *)url
							 username:(NSString *)username
							 password:(NSString *)password
					completionHandler:(PowaTSeriesFirmwareHistoryResultCompletionHandler)handler;

/*!
 * @brief Requests the latest firmware version
 * @discussion Requests the latest firmware version
 * @param url the ftp domain and path; Eg: myupdate.powa.com/T25/
 * @param username the ftp username
 * @param password the ftp password
 * @updated 01-09-2015
 */

- (void)requestLatestFirmwareWithURL:(NSString *)url
							username:(NSString *)username
							password:(NSString *)password
				   completionHandler:(PowaTSeriesLatestFirmwareResultCompletionHandler)handler;

/*!
 * @brief Checks whether there is a newer firmware version available
 * @discussion Checks whether there is a newer firmware version available
 * @param url the ftp domain and path; Eg: myupdate.powa.com/T25/
 * @param username the ftp username
 * @param password the ftp password
 * @updated 01-09-2015
 */

- (void)checkAvailableFirmwareWithURL:(NSString *)url
							 username:(NSString *)username
							 password:(NSString *)password
					completionHandler:(PowaTSeriesAvailableFirmwareResultCompletionHandler)handler;

/*!
 * @brief Downloads the latest firmware version
 * @param url the ftp domain and path; Eg: myupdate.powa.com/T25/
 * @param username the ftp username
 * @param password the ftp password
 * @updated 01-09-2015
 */

- (void)downloadLatestFirmwareWithURL:(NSString *)url
							 username:(NSString *)username
							 password:(NSString *)password
					completionHandler:(PowaTSeriesDownloadFirmwareCompletionHandler)handler;

/*!
 * @brief Downloads a specific firmware version (can be obtained using the requestFirmwareHistory method)
 * @param url the ftp domain and path; Eg: myupdate.powa.com/T25/
 * @param username the ftp username
 * @param password the ftp password
 * @updated 01-09-2015
 */

- (void)downloadFirmwareWithURL:(NSString *)urlString
					   username:(NSString *)username
					   password:(NSString *)password
						version:(NSString *)version
			  completionHandler:(PowaTSeriesDownloadFirmwareCompletionHandler)handler;


#pragma mark - USB Interface

/*!
 * @brief Writes data to one of the external USB ports
 * @discussion Writes data to one of the external USB ports
 * @param data the data to write to the USB port
 * @param port the external USB port to write data to
 * @updated 01-09-2015
 */

- (void)writeData:(NSData *)data usbPort:(PowaUSBCOMPort)port;

@end

#pragma mark - PowaTSeriesObserver Events

@protocol PowaTSeriesObserver <NSObject>

@optional

- (void)tseries:(PowaTSeries *)tseries connectionStateChanged:(PowaPeripheralConnectionState)connectionState;

/*!
 * @brief This event is called when the TSeries finishes initializing. You should not call any methods on the T25 until this event is received after calling connect.
 * @discussion This event is called when the TSeries finishes initializing. You should not call any methods on the T25 until this event is received after calling connect.
 * @updated 01-09-2015
 */

- (void)tseriesDidFinishInitializing:(PowaTSeries *)tseries;

/*!
 * @brief The TSeries that started a firmware update
 * @discussion The TSeries that started a firmware update
 * @param tseries the tseries that started updating
 * @updated 01-09-2015
 */

- (void)tseriesDidStartUpdating:(PowaTSeries *)tseries;


/*!
 * @brief The progress of a firmware update
 * @discussion The progress of a firmware update
 * @param tseries the tseries that is updating
 * @param progress a value between 0.0 and 1.0 representing the update progress
 * @updated 01-09-2015
 */

- (void)tseries:(PowaTSeries *)tseries updateProgress:(CGFloat)progress;

/*!
 * @brief The TSeries that finished updating
 * @discussion The TSeries that finished updating
 * @param tseries the tseries that finished updating
 * @updated 01-09-2015
 */

- (void)tseriesDidFinishUpdating:(PowaTSeries *)tseries;

/*!
 * @brief The TSeries that started a bootcode update
 * @discussion The TSeries that started a bootcode update
 * @param tseries the tseries that started updating
 * @updated 01-09-2015
 */

- (void)tseriesDidStartUpdatingBootcode:(PowaTSeries *)tseries;

/*!
 * @brief The progress of a bootcode update
 * @discussion The progress of a bootcode update
 * @param tseries the tseries that is updating
 * @param progress a value between 0.0 and 1.0 representing the update progress
 * @updated 01-09-2015
 */

- (void)tseries:(PowaTSeries *)tseries bootcodeUpdateProgress:(CGFloat)progress;

/*!
 * @brief The TSeries that finished updating
 * @discussion The TSeries that finished updating
 * @param tseries the tseries that finished updating
 * @updated 01-09-2015
 */

- (void)tseriesDidFinishUpdatingBootcode:(PowaTSeries *)tseries;

/**
 * @brief Called when the tseries failed to update the bootcode
 * @param tseries the tseries that failed to update the bootcode
 * @param error an NSError explaining why the bootcode update failed
 */

- (void)tseriesFailedUpdatingBootcode:(PowaTSeries *)tseries error:(NSError *)error;

/**
 * @brief Called when a device is connected to the TSeries
 * @param tseries the tseries that a device was connected to
 * @param port the port that a device was connected into
 */

- (void)tseries:(PowaTSeries *)tseries deviceConnectedAtPort:(NSUInteger)port;

/**
 * @brief Called when a device is disconnected to the TSeries
 * @param tseries the tseries that a device was disconnected from
 * @param port the port that a device was connected from
 */

- (void)tseries:(PowaTSeries *)tseries deviceDisconnectedAtPort:(NSUInteger)port;


- (void)tseries:(PowaTSeries *)tseries receivedData:(NSData *)data port:(PowaUSBCOMPort)port;

/**
 * @brief Called when a cash drawer is connected
 * @param tseries the tseries that a cash drawer was connected to
 */

- (void)tseriesCashDrawerAttached:(PowaTSeries *)tseries;

/**
 * @brief Called when a cash drawer is disconnected
 * @param tseries the tseries that a cash drawer was disconnected from
 */

- (void)tseriesCashDrawerDetached:(PowaTSeries *)tseries;

/*!
 * @brief Called when the tseries is out of paper
 * @discussion Called when the tseries is out of paper
 * @updated 01-09-2015
 */

- (void)tseriesOutOfPaper:(PowaTSeries *)tseries;

/**
 * @brief Called on multiple occassions to inform the user of the state of the TSeries
 * @param result the printer result. Look through the enum for possible values.
 */

- (void)tseriesPrinterResult:(PowaTSeriesPrinterResult)result;

@end

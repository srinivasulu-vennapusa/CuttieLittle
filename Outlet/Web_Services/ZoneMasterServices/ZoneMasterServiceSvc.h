#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ZoneMasterServiceSvc_createZone;
@class ZoneMasterServiceSvc_createZoneResponse;
@class ZoneMasterServiceSvc_deleteZone;
@class ZoneMasterServiceSvc_deleteZoneResponse;
@class ZoneMasterServiceSvc_getZones;
@class ZoneMasterServiceSvc_getZonesResponse;
@class ZoneMasterServiceSvc_updateZone;
@class ZoneMasterServiceSvc_updateZoneResponse;
@interface ZoneMasterServiceSvc_createZone : NSObject {
	
/* elements */
	NSString * zoneDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_createZone *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * zoneDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_createZoneResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_createZoneResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_deleteZone : NSObject {
	
/* elements */
	NSString * delteZoneDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_deleteZone *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * delteZoneDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_deleteZoneResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_deleteZoneResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_getZones : NSObject {
	
/* elements */
	NSString * zoneID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_getZones *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * zoneID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_getZonesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_getZonesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_updateZone : NSObject {
	
/* elements */
	NSString * updateZoneDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_updateZone *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * updateZoneDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ZoneMasterServiceSvc_updateZoneResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ZoneMasterServiceSvc_updateZoneResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "ZoneMasterServiceSvc.h"
@class ZoneMasterServiceSoapBinding;
@interface ZoneMasterServiceSvc : NSObject {
	
}
+ (ZoneMasterServiceSoapBinding *)ZoneMasterServiceSoapBinding;
@end
@class ZoneMasterServiceSoapBindingResponse;
@class ZoneMasterServiceSoapBindingOperation;
@protocol ZoneMasterServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(ZoneMasterServiceSoapBindingOperation *)operation completedWithResponse:(ZoneMasterServiceSoapBindingResponse *)response;
@end
@interface ZoneMasterServiceSoapBinding : NSObject <ZoneMasterServiceSoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, strong) NSMutableArray *cookies;
@property (nonatomic, strong) NSString *authUsername;
@property (nonatomic, strong) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ZoneMasterServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ZoneMasterServiceSoapBindingResponse *)updateZoneUsingParameters:(ZoneMasterServiceSvc_updateZone *)aParameters ;
- (void)updateZoneAsyncUsingParameters:(ZoneMasterServiceSvc_updateZone *)aParameters  delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ZoneMasterServiceSoapBindingResponse *)getZonesUsingParameters:(ZoneMasterServiceSvc_getZones *)aParameters ;
- (void)getZonesAsyncUsingParameters:(ZoneMasterServiceSvc_getZones *)aParameters  delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ZoneMasterServiceSoapBindingResponse *)createZoneUsingParameters:(ZoneMasterServiceSvc_createZone *)aParameters ;
- (void)createZoneAsyncUsingParameters:(ZoneMasterServiceSvc_createZone *)aParameters  delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ZoneMasterServiceSoapBindingResponse *)deleteZoneUsingParameters:(ZoneMasterServiceSvc_deleteZone *)aParameters ;
- (void)deleteZoneAsyncUsingParameters:(ZoneMasterServiceSvc_deleteZone *)aParameters  delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface ZoneMasterServiceSoapBindingOperation : NSOperation {
	ZoneMasterServiceSoapBinding *binding;
	ZoneMasterServiceSoapBindingResponse * response;
	id<ZoneMasterServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) ZoneMasterServiceSoapBinding *binding;
@property (  readonly) ZoneMasterServiceSoapBindingResponse *response;


@property (  nonatomic) id<ZoneMasterServiceSoapBindingResponseDelegate> delegate;



@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(ZoneMasterServiceSoapBinding *)aBinding delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface ZoneMasterServiceSoapBinding_updateZone : ZoneMasterServiceSoapBindingOperation {
	ZoneMasterServiceSvc_updateZone * parameters;
}
@property (strong) ZoneMasterServiceSvc_updateZone * parameters;
- (id)initWithBinding:(ZoneMasterServiceSoapBinding *)aBinding delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ZoneMasterServiceSvc_updateZone *)aParameters
;
@end
@interface ZoneMasterServiceSoapBinding_getZones : ZoneMasterServiceSoapBindingOperation {
	ZoneMasterServiceSvc_getZones * parameters;
}
@property (strong) ZoneMasterServiceSvc_getZones * parameters;
- (id)initWithBinding:(ZoneMasterServiceSoapBinding *)aBinding delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ZoneMasterServiceSvc_getZones *)aParameters
;
@end
@interface ZoneMasterServiceSoapBinding_createZone : ZoneMasterServiceSoapBindingOperation {
	ZoneMasterServiceSvc_createZone * parameters;
}
@property (strong) ZoneMasterServiceSvc_createZone * parameters;
- (id)initWithBinding:(ZoneMasterServiceSoapBinding *)aBinding delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ZoneMasterServiceSvc_createZone *)aParameters
;
@end
@interface ZoneMasterServiceSoapBinding_deleteZone : ZoneMasterServiceSoapBindingOperation {
	ZoneMasterServiceSvc_deleteZone * parameters;
}
@property (strong) ZoneMasterServiceSvc_deleteZone * parameters;
- (id)initWithBinding:(ZoneMasterServiceSoapBinding *)aBinding delegate:(id<ZoneMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ZoneMasterServiceSvc_deleteZone *)aParameters
;
@end
@interface ZoneMasterServiceSoapBinding_envelope : NSObject {
}
+ (ZoneMasterServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ZoneMasterServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

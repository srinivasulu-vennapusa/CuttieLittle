#import <Foundation/Foundation.h>

#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ProducGroupMasterServicesSvc_createProductGroup;
@class ProducGroupMasterServicesSvc_createProductGroupResponse;
@class ProducGroupMasterServicesSvc_deleteProductGroup;
@class ProducGroupMasterServicesSvc_deleteProductGroupResponse;
@class ProducGroupMasterServicesSvc_getProductGroupChilds;
@class ProducGroupMasterServicesSvc_getProductGroupChildsResponse;
@class ProducGroupMasterServicesSvc_getProductGroups;
@class ProducGroupMasterServicesSvc_getProductGroupsResponse;
@class ProducGroupMasterServicesSvc_updateProductGroup;
@class ProducGroupMasterServicesSvc_updateProductGroupResponse;
@interface ProducGroupMasterServicesSvc_createProductGroup : NSObject {
	
/* elements */
	NSString * productGroupDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_createProductGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productGroupDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_createProductGroupResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_createProductGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_deleteProductGroup : NSObject {
	
/* elements */
	NSString * groupIds;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_deleteProductGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * groupIds;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_deleteProductGroupResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_deleteProductGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_getProductGroupChilds : NSObject {
	
/* elements */
	NSString * productGroupDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_getProductGroupChilds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productGroupDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_getProductGroupChildsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_getProductGroupChildsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_getProductGroups : NSObject {
	
/* elements */
	NSString * productGroupDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_getProductGroups *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productGroupDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_getProductGroupsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_getProductGroupsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_updateProductGroup : NSObject {
	
/* elements */
	NSString * productGroupDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_updateProductGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productGroupDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProducGroupMasterServicesSvc_updateProductGroupResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProducGroupMasterServicesSvc_updateProductGroupResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "ProducGroupMasterServicesSvc.h"
@class ProducGroupMasterServicesSoapBinding;
@interface ProducGroupMasterServicesSvc : NSObject {
	
}
+ (ProducGroupMasterServicesSoapBinding *)ProducGroupMasterServicesSoapBinding;
@end
@class ProducGroupMasterServicesSoapBindingResponse;
@class ProducGroupMasterServicesSoapBindingOperation;
@protocol ProducGroupMasterServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(ProducGroupMasterServicesSoapBindingOperation *)operation completedWithResponse:(ProducGroupMasterServicesSoapBindingResponse *)response;
@end
@interface ProducGroupMasterServicesSoapBinding : NSObject <ProducGroupMasterServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ProducGroupMasterServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ProducGroupMasterServicesSoapBindingResponse *)getProductGroupsUsingParameters:(ProducGroupMasterServicesSvc_getProductGroups *)aParameters ;
- (void)getProductGroupsAsyncUsingParameters:(ProducGroupMasterServicesSvc_getProductGroups *)aParameters  delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)responseDelegate;
- (ProducGroupMasterServicesSoapBindingResponse *)getProductGroupChildsUsingParameters:(ProducGroupMasterServicesSvc_getProductGroupChilds *)aParameters ;
- (void)getProductGroupChildsAsyncUsingParameters:(ProducGroupMasterServicesSvc_getProductGroupChilds *)aParameters  delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)responseDelegate;
- (ProducGroupMasterServicesSoapBindingResponse *)updateProductGroupUsingParameters:(ProducGroupMasterServicesSvc_updateProductGroup *)aParameters ;
- (void)updateProductGroupAsyncUsingParameters:(ProducGroupMasterServicesSvc_updateProductGroup *)aParameters  delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)responseDelegate;
- (ProducGroupMasterServicesSoapBindingResponse *)createProductGroupUsingParameters:(ProducGroupMasterServicesSvc_createProductGroup *)aParameters ;
- (void)createProductGroupAsyncUsingParameters:(ProducGroupMasterServicesSvc_createProductGroup *)aParameters  delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)responseDelegate;
- (ProducGroupMasterServicesSoapBindingResponse *)deleteProductGroupUsingParameters:(ProducGroupMasterServicesSvc_deleteProductGroup *)aParameters ;
- (void)deleteProductGroupAsyncUsingParameters:(ProducGroupMasterServicesSvc_deleteProductGroup *)aParameters  delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface ProducGroupMasterServicesSoapBindingOperation : NSOperation {
	ProducGroupMasterServicesSoapBinding *binding;
	ProducGroupMasterServicesSoapBindingResponse * response;
	id<ProducGroupMasterServicesSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) ProducGroupMasterServicesSoapBinding *binding;
@property (  readonly) ProducGroupMasterServicesSoapBindingResponse *response;
@property (nonatomic ) id<ProducGroupMasterServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(ProducGroupMasterServicesSoapBinding *)aBinding delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface ProducGroupMasterServicesSoapBinding_getProductGroups : ProducGroupMasterServicesSoapBindingOperation {
	ProducGroupMasterServicesSvc_getProductGroups * parameters;
}
@property (strong) ProducGroupMasterServicesSvc_getProductGroups * parameters;
- (id)initWithBinding:(ProducGroupMasterServicesSoapBinding *)aBinding delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(ProducGroupMasterServicesSvc_getProductGroups *)aParameters
;
@end
@interface ProducGroupMasterServicesSoapBinding_getProductGroupChilds : ProducGroupMasterServicesSoapBindingOperation {
	ProducGroupMasterServicesSvc_getProductGroupChilds * parameters;
}
@property (strong) ProducGroupMasterServicesSvc_getProductGroupChilds * parameters;
- (id)initWithBinding:(ProducGroupMasterServicesSoapBinding *)aBinding delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(ProducGroupMasterServicesSvc_getProductGroupChilds *)aParameters
;
@end
@interface ProducGroupMasterServicesSoapBinding_updateProductGroup : ProducGroupMasterServicesSoapBindingOperation {
	ProducGroupMasterServicesSvc_updateProductGroup * parameters;
}
@property (strong) ProducGroupMasterServicesSvc_updateProductGroup * parameters;
- (id)initWithBinding:(ProducGroupMasterServicesSoapBinding *)aBinding delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(ProducGroupMasterServicesSvc_updateProductGroup *)aParameters
;
@end
@interface ProducGroupMasterServicesSoapBinding_createProductGroup : ProducGroupMasterServicesSoapBindingOperation {
	ProducGroupMasterServicesSvc_createProductGroup * parameters;
}
@property (strong) ProducGroupMasterServicesSvc_createProductGroup * parameters;
- (id)initWithBinding:(ProducGroupMasterServicesSoapBinding *)aBinding delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(ProducGroupMasterServicesSvc_createProductGroup *)aParameters
;
@end
@interface ProducGroupMasterServicesSoapBinding_deleteProductGroup : ProducGroupMasterServicesSoapBindingOperation {
	ProducGroupMasterServicesSvc_deleteProductGroup * parameters;
}
@property (strong) ProducGroupMasterServicesSvc_deleteProductGroup * parameters;
- (id)initWithBinding:(ProducGroupMasterServicesSoapBinding *)aBinding delegate:(id<ProducGroupMasterServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(ProducGroupMasterServicesSvc_deleteProductGroup *)aParameters
;
@end
@interface ProducGroupMasterServicesSoapBinding_envelope : NSObject {
}
+ (ProducGroupMasterServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ProducGroupMasterServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

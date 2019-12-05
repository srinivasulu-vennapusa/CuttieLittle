#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "WebServiceUtility.h"

@class DepartmentServiceSvc_createDepartment;
@class DepartmentServiceSvc_createDepartmentResponse;
@class DepartmentServiceSvc_deleteDepartment;
@class DepartmentServiceSvc_deleteDepartmentResponse;
@class DepartmentServiceSvc_getDepartments;
@class DepartmentServiceSvc_getDepartmentsResponse;
@class DepartmentServiceSvc_updateDepartment;
@class DepartmentServiceSvc_updateDepartmentResponse;
@interface DepartmentServiceSvc_createDepartment : NSObject {
	
/* elements */
	NSString * departmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_createDepartment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * departmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_createDepartmentResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_createDepartmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_deleteDepartment : NSObject {
	
/* elements */
	NSString * requestHeader;
	NSString * primaryDepartment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_deleteDepartment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * requestHeader;
@property (strong) NSString * primaryDepartment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_deleteDepartmentResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_deleteDepartmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_getDepartments : NSObject {
	
/* elements */
	NSString * departmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_getDepartments *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * departmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_getDepartmentsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_getDepartmentsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_updateDepartment : NSObject {
	
/* elements */
	NSString * departmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_updateDepartment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * departmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DepartmentServiceSvc_updateDepartmentResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DepartmentServiceSvc_updateDepartmentResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "DepartmentServiceSvc.h"
@class DepartmentServiceSoapBinding;
@interface DepartmentServiceSvc : NSObject {
	
}
+ (DepartmentServiceSoapBinding *)DepartmentServiceSoapBinding;
@end
@class DepartmentServiceSoapBindingResponse;
@class DepartmentServiceSoapBindingOperation;
@protocol DepartmentServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(DepartmentServiceSoapBindingOperation *)operation completedWithResponse:(DepartmentServiceSoapBindingResponse *)response;
@end
@interface DepartmentServiceSoapBinding : NSObject <DepartmentServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(DepartmentServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (DepartmentServiceSoapBindingResponse *)deleteDepartmentUsingParameters:(DepartmentServiceSvc_deleteDepartment *)aParameters ;
- (void)deleteDepartmentAsyncUsingParameters:(DepartmentServiceSvc_deleteDepartment *)aParameters  delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)responseDelegate;
- (DepartmentServiceSoapBindingResponse *)createDepartmentUsingParameters:(DepartmentServiceSvc_createDepartment *)aParameters ;
- (void)createDepartmentAsyncUsingParameters:(DepartmentServiceSvc_createDepartment *)aParameters  delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)responseDelegate;
- (DepartmentServiceSoapBindingResponse *)getDepartmentsUsingParameters:(DepartmentServiceSvc_getDepartments *)aParameters ;
- (void)getDepartmentsAsyncUsingParameters:(DepartmentServiceSvc_getDepartments *)aParameters  delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)responseDelegate;
- (DepartmentServiceSoapBindingResponse *)updateDepartmentUsingParameters:(DepartmentServiceSvc_updateDepartment *)aParameters ;
- (void)updateDepartmentAsyncUsingParameters:(DepartmentServiceSvc_updateDepartment *)aParameters  delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface DepartmentServiceSoapBindingOperation : NSOperation {
	DepartmentServiceSoapBinding *binding;
	DepartmentServiceSoapBindingResponse * response;
	id<DepartmentServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) DepartmentServiceSoapBinding *binding;
@property (  readonly) DepartmentServiceSoapBindingResponse *response;
@property (nonatomic ) id<DepartmentServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(DepartmentServiceSoapBinding *)aBinding delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface DepartmentServiceSoapBinding_deleteDepartment : DepartmentServiceSoapBindingOperation {
	DepartmentServiceSvc_deleteDepartment * parameters;
}
@property (strong) DepartmentServiceSvc_deleteDepartment * parameters;
- (id)initWithBinding:(DepartmentServiceSoapBinding *)aBinding delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(DepartmentServiceSvc_deleteDepartment *)aParameters
;
@end
@interface DepartmentServiceSoapBinding_createDepartment : DepartmentServiceSoapBindingOperation {
	DepartmentServiceSvc_createDepartment * parameters;
}
@property (strong) DepartmentServiceSvc_createDepartment * parameters;
- (id)initWithBinding:(DepartmentServiceSoapBinding *)aBinding delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(DepartmentServiceSvc_createDepartment *)aParameters
;
@end
@interface DepartmentServiceSoapBinding_getDepartments : DepartmentServiceSoapBindingOperation {
    
	DepartmentServiceSvc_getDepartments * parameters;
}
@property (strong) DepartmentServiceSvc_getDepartments * parameters;
- (id)initWithBinding:(DepartmentServiceSoapBinding *)aBinding delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(DepartmentServiceSvc_getDepartments *)aParameters
;
@end
@interface DepartmentServiceSoapBinding_updateDepartment : DepartmentServiceSoapBindingOperation {
	DepartmentServiceSvc_updateDepartment * parameters;
}
@property (strong) DepartmentServiceSvc_updateDepartment * parameters;
- (id)initWithBinding:(DepartmentServiceSoapBinding *)aBinding delegate:(id<DepartmentServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(DepartmentServiceSvc_updateDepartment *)aParameters
;
@end
@interface DepartmentServiceSoapBinding_envelope : NSObject {
}
+ (DepartmentServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface DepartmentServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

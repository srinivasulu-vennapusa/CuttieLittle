#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "WebServiceUtility.h"
#import "Global.h"

@class EmployeesSvc_createEmployee;
@class EmployeesSvc_createEmployeeResponse;
@class EmployeesSvc_deleteEmployee;
@class EmployeesSvc_deleteEmployeeResponse;
@class EmployeesSvc_getEmployee;
@class EmployeesSvc_getEmployeeByRole;
@class EmployeesSvc_getEmployeeByRoleResponse;
@class EmployeesSvc_getEmployeeResponse;
@class EmployeesSvc_getEmployees;
@class EmployeesSvc_getEmployeesResponse;
@class EmployeesSvc_updateEmployee;
@class EmployeesSvc_updateEmployeeResponse;
@interface EmployeesSvc_createEmployee : NSObject {
	
/* elements */
	NSString * employeeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_createEmployee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * employeeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_createEmployeeResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_createEmployeeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_deleteEmployee : NSObject {
	
/* elements */
	NSString * employeeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_deleteEmployee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * employeeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_deleteEmployeeResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_deleteEmployeeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_getEmployee : NSObject {
	
/* elements */
	NSString * employeeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_getEmployee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * employeeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_getEmployeeByRole : NSObject {
	
/* elements */
	NSString * employeeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_getEmployeeByRole *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * employeeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_getEmployeeByRoleResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_getEmployeeByRoleResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_getEmployeeResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_getEmployeeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_getEmployees : NSObject {
	
/* elements */
	NSString * employeeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_getEmployees *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * employeeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_getEmployeesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_getEmployeesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_updateEmployee : NSObject {
	
/* elements */
	NSString * employeeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_updateEmployee *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * employeeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface EmployeesSvc_updateEmployeeResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (EmployeesSvc_updateEmployeeResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "EmployeesSvc.h"
@class EmployeesSoapBinding;
@interface EmployeesSvc : NSObject {
	
}
+ (EmployeesSoapBinding *)EmployeesSoapBinding;
@end
@class EmployeesSoapBindingResponse;
@class EmployeesSoapBindingOperation;
@protocol EmployeesSoapBindingResponseDelegate <NSObject>
- (void) operation:(EmployeesSoapBindingOperation *)operation completedWithResponse:(EmployeesSoapBindingResponse *)response;
@end
@interface EmployeesSoapBinding : NSObject <EmployeesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(EmployeesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (EmployeesSoapBindingResponse *)createEmployeeUsingParameters:(EmployeesSvc_createEmployee *)aParameters ;
- (void)createEmployeeAsyncUsingParameters:(EmployeesSvc_createEmployee *)aParameters  delegate:(id<EmployeesSoapBindingResponseDelegate>)responseDelegate;
- (EmployeesSoapBindingResponse *)getEmployeesUsingParameters:(EmployeesSvc_getEmployees *)aParameters ;
- (void)getEmployeesAsyncUsingParameters:(EmployeesSvc_getEmployees *)aParameters  delegate:(id<EmployeesSoapBindingResponseDelegate>)responseDelegate;
- (EmployeesSoapBindingResponse *)getEmployeeUsingParameters:(EmployeesSvc_getEmployee *)aParameters ;
- (void)getEmployeeAsyncUsingParameters:(EmployeesSvc_getEmployee *)aParameters  delegate:(id<EmployeesSoapBindingResponseDelegate>)responseDelegate;
- (EmployeesSoapBindingResponse *)deleteEmployeeUsingParameters:(EmployeesSvc_deleteEmployee *)aParameters ;
- (void)deleteEmployeeAsyncUsingParameters:(EmployeesSvc_deleteEmployee *)aParameters  delegate:(id<EmployeesSoapBindingResponseDelegate>)responseDelegate;
- (EmployeesSoapBindingResponse *)getEmployeeByRoleUsingParameters:(EmployeesSvc_getEmployeeByRole *)aParameters ;
- (void)getEmployeeByRoleAsyncUsingParameters:(EmployeesSvc_getEmployeeByRole *)aParameters  delegate:(id<EmployeesSoapBindingResponseDelegate>)responseDelegate;
- (EmployeesSoapBindingResponse *)updateEmployeeUsingParameters:(EmployeesSvc_updateEmployee *)aParameters ;
- (void)updateEmployeeAsyncUsingParameters:(EmployeesSvc_updateEmployee *)aParameters  delegate:(id<EmployeesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface EmployeesSoapBindingOperation : NSOperation {
	EmployeesSoapBinding *binding;
	EmployeesSoapBindingResponse * response;
	id<EmployeesSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) EmployeesSoapBinding *binding;
@property (  readonly) EmployeesSoapBindingResponse *response;
@property (nonatomic ) id<EmployeesSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate;
@end
@interface EmployeesSoapBinding_createEmployee : EmployeesSoapBindingOperation {
	EmployeesSvc_createEmployee * parameters;
}
@property (strong) EmployeesSvc_createEmployee * parameters;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate
	parameters:(EmployeesSvc_createEmployee *)aParameters
;
@end
@interface EmployeesSoapBinding_getEmployees : EmployeesSoapBindingOperation {
	EmployeesSvc_getEmployees * parameters;
}
@property (strong) EmployeesSvc_getEmployees * parameters;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate
	parameters:(EmployeesSvc_getEmployees *)aParameters
;
@end
@interface EmployeesSoapBinding_getEmployee : EmployeesSoapBindingOperation {
	EmployeesSvc_getEmployee * parameters;
}
@property (strong) EmployeesSvc_getEmployee * parameters;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate
	parameters:(EmployeesSvc_getEmployee *)aParameters
;
@end
@interface EmployeesSoapBinding_deleteEmployee : EmployeesSoapBindingOperation {
	EmployeesSvc_deleteEmployee * parameters;
}
@property (strong) EmployeesSvc_deleteEmployee * parameters;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate
	parameters:(EmployeesSvc_deleteEmployee *)aParameters
;
@end
@interface EmployeesSoapBinding_getEmployeeByRole : EmployeesSoapBindingOperation {
	EmployeesSvc_getEmployeeByRole * parameters;
}
@property (strong) EmployeesSvc_getEmployeeByRole * parameters;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate
	parameters:(EmployeesSvc_getEmployeeByRole *)aParameters
;
@end
@interface EmployeesSoapBinding_updateEmployee : EmployeesSoapBindingOperation {
	EmployeesSvc_updateEmployee * parameters;
}
@property (strong) EmployeesSvc_updateEmployee * parameters;
- (id)initWithBinding:(EmployeesSoapBinding *)aBinding delegate:(id<EmployeesSoapBindingResponseDelegate>)aDelegate
	parameters:(EmployeesSvc_updateEmployee *)aParameters
;
@end
@interface EmployeesSoapBinding_envelope : NSObject {
}
+ (EmployeesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface EmployeesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

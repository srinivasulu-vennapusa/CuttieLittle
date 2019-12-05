#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class LoginServiceSvc_createMember;
@class LoginServiceSvc_createMemberResponse;
@class LoginServiceSvc_cancelMember;
@class LoginServiceSvc_cancelMemberResponse;
@class LoginServiceSvc_updateMemberDetails;
@class LoginServiceSvc_updateMemberDetailsResponse;
@class LoginServiceSvc_authenticateUser;
@class LoginServiceSvc_authenticateUserResponse;
@class LoginServiceSvc_forgetPassword;
@class LoginServiceSvc_forgetPasswordResponse;
@class LoginServiceSvc_generateOTP;
@class LoginServiceSvc_generateOTPResponse;
@interface LoginServiceSvc_createMember : NSObject {
	
/* elements */
	NSString * userID;
	NSString * emailId;
	NSString * password;
	NSString * firstName;
	NSString * lastName;
	NSString * imei;
	NSString * country;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_createMember *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userID;
@property (retain) NSString * emailId;
@property (retain) NSString * password;
@property (retain) NSString * firstName;
@property (retain) NSString * lastName;
@property (retain) NSString * imei;
@property (retain) NSString * country;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_createMemberResponse : NSObject {
	
/* elements */
	NSString * createMemberReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_createMemberResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * createMemberReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_cancelMember : NSObject {
	
/* elements */
	NSString * userID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_cancelMember *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_cancelMemberResponse : NSObject {
	
/* elements */
	USBoolean * cancelMemberReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_cancelMemberResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * cancelMemberReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_updateMemberDetails : NSObject {
	
/* elements */
	NSString * userID;
	NSString * password;
	NSString * imei;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_updateMemberDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userID;
@property (retain) NSString * password;
@property (retain) NSString * imei;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_updateMemberDetailsResponse : NSObject {
	
/* elements */
	USBoolean * updateMemberDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_updateMemberDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * updateMemberDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_authenticateUser : NSObject {
	
/* elements */
	NSString * userID;
	NSString * password;
	NSString * imei;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_authenticateUser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userID;
@property (retain) NSString * password;
@property (retain) NSString * imei;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_authenticateUserResponse : NSObject {
	
/* elements */
	NSString * authenticateUserReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_authenticateUserResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * authenticateUserReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_forgetPassword : NSObject {
	
/* elements */
	NSString * emailId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_forgetPassword *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * emailId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_forgetPasswordResponse : NSObject {
	
/* elements */
	USBoolean * forgetPasswordReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_forgetPasswordResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * forgetPasswordReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_generateOTP : NSObject {
	
/* elements */
	NSString * mobileNumber;
	NSString * imei;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_generateOTP *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * mobileNumber;
@property (retain) NSString * imei;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_generateOTPResponse : NSObject {
	
/* elements */
	USBoolean * generateOTPReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_generateOTPResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * generateOTPReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "LoginServiceSvc.h"
@class LoginSoapBinding;
@interface LoginServiceSvc : NSObject {
	
}
+ (LoginSoapBinding *)LoginSoapBinding;
@end
@class LoginSoapBindingResponse;
@class LoginSoapBindingOperation;
@protocol LoginSoapBindingResponseDelegate <NSObject>
- (void) operation:(LoginSoapBindingOperation *)operation completedWithResponse:(LoginSoapBindingResponse *)response;
@end
@interface LoginSoapBinding : NSObject <LoginSoapBindingResponseDelegate> {
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
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(LoginSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (LoginSoapBindingResponse *)createMemberUsingParameters:(LoginServiceSvc_createMember *)aParameters ;
- (void)createMemberAsyncUsingParameters:(LoginServiceSvc_createMember *)aParameters  delegate:(id<LoginSoapBindingResponseDelegate>)responseDelegate;
- (LoginSoapBindingResponse *)cancelMemberUsingParameters:(LoginServiceSvc_cancelMember *)aParameters ;
- (void)cancelMemberAsyncUsingParameters:(LoginServiceSvc_cancelMember *)aParameters  delegate:(id<LoginSoapBindingResponseDelegate>)responseDelegate;
- (LoginSoapBindingResponse *)updateMemberDetailsUsingParameters:(LoginServiceSvc_updateMemberDetails *)aParameters ;
- (void)updateMemberDetailsAsyncUsingParameters:(LoginServiceSvc_updateMemberDetails *)aParameters  delegate:(id<LoginSoapBindingResponseDelegate>)responseDelegate;
- (LoginSoapBindingResponse *)authenticateUserUsingParameters:(LoginServiceSvc_authenticateUser *)aParameters ;
- (void)authenticateUserAsyncUsingParameters:(LoginServiceSvc_authenticateUser *)aParameters  delegate:(id<LoginSoapBindingResponseDelegate>)responseDelegate;
- (LoginSoapBindingResponse *)forgetPasswordUsingParameters:(LoginServiceSvc_forgetPassword *)aParameters ;
- (void)forgetPasswordAsyncUsingParameters:(LoginServiceSvc_forgetPassword *)aParameters  delegate:(id<LoginSoapBindingResponseDelegate>)responseDelegate;
- (LoginSoapBindingResponse *)generateOTPUsingParameters:(LoginServiceSvc_generateOTP *)aParameters ;
- (void)generateOTPAsyncUsingParameters:(LoginServiceSvc_generateOTP *)aParameters  delegate:(id<LoginSoapBindingResponseDelegate>)responseDelegate;
@end
@interface LoginSoapBindingOperation : NSOperation {
	LoginSoapBinding *binding;
	LoginSoapBindingResponse *response;
	id<LoginSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) LoginSoapBinding *binding;
@property (readonly) LoginSoapBindingResponse *response;
@property (nonatomic, assign) id<LoginSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate;
@end
@interface LoginSoapBinding_createMember : LoginSoapBindingOperation {
	LoginServiceSvc_createMember * parameters;
}
@property (retain) LoginServiceSvc_createMember * parameters;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_createMember *)aParameters
;
@end
@interface LoginSoapBinding_cancelMember : LoginSoapBindingOperation {
	LoginServiceSvc_cancelMember * parameters;
}
@property (retain) LoginServiceSvc_cancelMember * parameters;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_cancelMember *)aParameters
;
@end
@interface LoginSoapBinding_updateMemberDetails : LoginSoapBindingOperation {
	LoginServiceSvc_updateMemberDetails * parameters;
}
@property (retain) LoginServiceSvc_updateMemberDetails * parameters;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_updateMemberDetails *)aParameters
;
@end
@interface LoginSoapBinding_authenticateUser : LoginSoapBindingOperation {
	LoginServiceSvc_authenticateUser * parameters;
}
@property (retain) LoginServiceSvc_authenticateUser * parameters;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_authenticateUser *)aParameters
;
@end
@interface LoginSoapBinding_forgetPassword : LoginSoapBindingOperation {
	LoginServiceSvc_forgetPassword * parameters;
}
@property (retain) LoginServiceSvc_forgetPassword * parameters;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_forgetPassword *)aParameters
;
@end
@interface LoginSoapBinding_generateOTP : LoginSoapBindingOperation {
	LoginServiceSvc_generateOTP * parameters;
}
@property (retain) LoginServiceSvc_generateOTP * parameters;
- (id)initWithBinding:(LoginSoapBinding *)aBinding delegate:(id<LoginSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_generateOTP *)aParameters
;
@end
@interface LoginSoapBinding_envelope : NSObject {
}
+ (LoginSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface LoginSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end

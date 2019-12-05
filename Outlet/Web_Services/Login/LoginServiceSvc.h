#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class LoginServiceSvc_authenticateUser;
@class LoginServiceSvc_authenticateUserResponse;
@class LoginServiceSvc_cancelMember;
@class LoginServiceSvc_cancelMemberResponse;
@class LoginServiceSvc_createMember;
@class LoginServiceSvc_createMemberResponse;
@class LoginServiceSvc_generateOTP;
@class LoginServiceSvc_generateOTPResponse;
@class LoginServiceSvc_resetPassword;
@class LoginServiceSvc_resetPasswordResponse;
@class LoginServiceSvc_updateMemberDetails;
@class LoginServiceSvc_updateMemberDetailsResponse;
@class LoginServiceSvc_validateOTP;
@class LoginServiceSvc_validateOTPResponse;
@interface LoginServiceSvc_authenticateUser : NSObject {
	
/* elements */
	NSString * userDetails;
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
@property (strong) NSString * userDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_authenticateUserResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
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
@property (strong) NSString * userID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_cancelMemberResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_createMember : NSObject {
	
/* elements */
	NSString * memberDetails;
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
@property (strong) NSString * memberDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_createMemberResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_generateOTP : NSObject {
	
/* elements */
	NSString * userDetails;
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
@property (strong) NSString * userDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_generateOTPResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_resetPassword : NSObject {
	
/* elements */
	NSString * passwordDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_resetPassword *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * passwordDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_resetPasswordResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_resetPasswordResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_updateMemberDetails : NSObject {
	
/* elements */
	NSString * memberDetails;
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
@property (strong) NSString * memberDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_updateMemberDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_validateOTP : NSObject {
	
/* elements */
	NSString * otpDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_validateOTP *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * otpDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoginServiceSvc_validateOTPResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoginServiceSvc_validateOTPResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "LoginServiceSvc.h"
@class LoginServiceSoapBinding;
@interface LoginServiceSvc : NSObject {
	
}
+ (LoginServiceSoapBinding *)LoginServiceSoapBinding;
@end
@class LoginServiceSoapBindingResponse;
@class LoginServiceSoapBindingOperation;
@protocol LoginServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(LoginServiceSoapBindingOperation *)operation completedWithResponse:(LoginServiceSoapBindingResponse *)response;
@end
@interface LoginServiceSoapBinding : NSObject <LoginServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(LoginServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (LoginServiceSoapBindingResponse *)generateOTPUsingParameters:(LoginServiceSvc_generateOTP *)aParameters ;
- (void)generateOTPAsyncUsingParameters:(LoginServiceSvc_generateOTP *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoginServiceSoapBindingResponse *)authenticateUserUsingParameters:(LoginServiceSvc_authenticateUser *)aParameters ;
- (void)authenticateUserAsyncUsingParameters:(LoginServiceSvc_authenticateUser *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoginServiceSoapBindingResponse *)updateMemberDetailsUsingParameters:(LoginServiceSvc_updateMemberDetails *)aParameters ;
- (void)updateMemberDetailsAsyncUsingParameters:(LoginServiceSvc_updateMemberDetails *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoginServiceSoapBindingResponse *)createMemberUsingParameters:(LoginServiceSvc_createMember *)aParameters ;
- (void)createMemberAsyncUsingParameters:(LoginServiceSvc_createMember *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoginServiceSoapBindingResponse *)validateOTPUsingParameters:(LoginServiceSvc_validateOTP *)aParameters ;
- (void)validateOTPAsyncUsingParameters:(LoginServiceSvc_validateOTP *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoginServiceSoapBindingResponse *)resetPasswordUsingParameters:(LoginServiceSvc_resetPassword *)aParameters ;
- (void)resetPasswordAsyncUsingParameters:(LoginServiceSvc_resetPassword *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoginServiceSoapBindingResponse *)cancelMemberUsingParameters:(LoginServiceSvc_cancelMember *)aParameters ;
- (void)cancelMemberAsyncUsingParameters:(LoginServiceSvc_cancelMember *)aParameters  delegate:(id<LoginServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface LoginServiceSoapBindingOperation : NSOperation {
	LoginServiceSoapBinding *binding;
	LoginServiceSoapBindingResponse * response;
	id<LoginServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) LoginServiceSoapBinding *binding;
@property (  readonly) LoginServiceSoapBindingResponse *response;
@property (nonatomic ) id<LoginServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface LoginServiceSoapBinding_generateOTP : LoginServiceSoapBindingOperation {
	LoginServiceSvc_generateOTP * parameters;
}
@property (strong) LoginServiceSvc_generateOTP * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_generateOTP *)aParameters
;
@end
@interface LoginServiceSoapBinding_authenticateUser : LoginServiceSoapBindingOperation {
	LoginServiceSvc_authenticateUser * parameters;
}
@property (strong) LoginServiceSvc_authenticateUser * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_authenticateUser *)aParameters
;
@end
@interface LoginServiceSoapBinding_updateMemberDetails : LoginServiceSoapBindingOperation {
	LoginServiceSvc_updateMemberDetails * parameters;
}
@property (strong) LoginServiceSvc_updateMemberDetails * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_updateMemberDetails *)aParameters
;
@end
@interface LoginServiceSoapBinding_createMember : LoginServiceSoapBindingOperation {
	LoginServiceSvc_createMember * parameters;
}
@property (strong) LoginServiceSvc_createMember * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_createMember *)aParameters
;
@end
@interface LoginServiceSoapBinding_validateOTP : LoginServiceSoapBindingOperation {
	LoginServiceSvc_validateOTP * parameters;
}
@property (strong) LoginServiceSvc_validateOTP * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_validateOTP *)aParameters
;
@end
@interface LoginServiceSoapBinding_resetPassword : LoginServiceSoapBindingOperation {
	LoginServiceSvc_resetPassword * parameters;
}
@property (strong) LoginServiceSvc_resetPassword * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_resetPassword *)aParameters
;
@end
@interface LoginServiceSoapBinding_cancelMember : LoginServiceSoapBindingOperation {
	LoginServiceSvc_cancelMember * parameters;
}
@property (strong) LoginServiceSvc_cancelMember * parameters;
- (id)initWithBinding:(LoginServiceSoapBinding *)aBinding delegate:(id<LoginServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(LoginServiceSvc_cancelMember *)aParameters
;
@end
@interface LoginServiceSoapBinding_envelope : NSObject {
}
+ (LoginServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface LoginServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class memberServicesSvc_authenticateUser;
@class memberServicesSvc_authenticateUserResponse;
@class memberServicesSvc_changePassword;
@class memberServicesSvc_changePasswordResponse;
@class memberServicesSvc_createMember;
@class memberServicesSvc_createMemberResponse;
@class memberServicesSvc_deleteMember;
@class memberServicesSvc_deleteMemberResponse;
@class memberServicesSvc_generateOTP;
@class memberServicesSvc_generateOTPResponse;
@class memberServicesSvc_getMemberDetails;
@class memberServicesSvc_getMemberDetailsResponse;
@class memberServicesSvc_getMembers;
@class memberServicesSvc_getMembersResponse;
@class memberServicesSvc_resetPassword;
@class memberServicesSvc_resetPasswordResponse;
@class memberServicesSvc_updateMember;
@class memberServicesSvc_updateMemberResponse;
@class memberServicesSvc_userRegistration;
@class memberServicesSvc_userRegistrationResponse;
@class memberServicesSvc_validateOTP;
@class memberServicesSvc_validateOTPResponse;
@interface memberServicesSvc_authenticateUser : NSObject {
	
/* elements */
	NSString * loginDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_authenticateUser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loginDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_authenticateUserResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_authenticateUserResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_changePassword : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_changePassword *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_changePasswordResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_changePasswordResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_createMember : NSObject {
	
/* elements */
	NSString * memberDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_createMember *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * memberDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_createMemberResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_createMemberResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_deleteMember : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_deleteMember *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_deleteMemberResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_deleteMemberResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_generateOTP : NSObject {
	
/* elements */
	NSString * userDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_generateOTP *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * userDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_generateOTPResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_generateOTPResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_getMemberDetails : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_getMemberDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_getMemberDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_getMemberDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_getMembers : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_getMembers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_getMembersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_getMembersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_resetPassword : NSObject {
	
/* elements */
	NSString * passwordDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_resetPassword *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * passwordDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_resetPasswordResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_resetPasswordResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_updateMember : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_updateMember *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_updateMemberResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_updateMemberResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_userRegistration : NSObject {
	
/* elements */
	NSString * userDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_userRegistration *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * userDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_userRegistrationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_userRegistrationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_validateOTP : NSObject {
	
/* elements */
	NSString * otpDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_validateOTP *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * otpDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface memberServicesSvc_validateOTPResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (memberServicesSvc_validateOTPResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "memberServicesSvc.h"
@class memberServicesSoapBinding;
@interface memberServicesSvc : NSObject {
	
}
+ (memberServicesSoapBinding *)memberServicesSoapBinding;
@end
@class memberServicesSoapBindingResponse;
@class memberServicesSoapBindingOperation;
@protocol memberServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(memberServicesSoapBindingOperation *)operation completedWithResponse:(memberServicesSoapBindingResponse *)response;
@end
@interface memberServicesSoapBinding : NSObject <memberServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(memberServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (memberServicesSoapBindingResponse *)getMembersUsingParameters:(memberServicesSvc_getMembers *)aParameters ;
- (void)getMembersAsyncUsingParameters:(memberServicesSvc_getMembers *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)authenticateUserUsingParameters:(memberServicesSvc_authenticateUser *)aParameters ;
- (void)authenticateUserAsyncUsingParameters:(memberServicesSvc_authenticateUser *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)generateOTPUsingParameters:(memberServicesSvc_generateOTP *)aParameters ;
- (void)generateOTPAsyncUsingParameters:(memberServicesSvc_generateOTP *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)createMemberUsingParameters:(memberServicesSvc_createMember *)aParameters ;
- (void)createMemberAsyncUsingParameters:(memberServicesSvc_createMember *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)getMemberDetailsUsingParameters:(memberServicesSvc_getMemberDetails *)aParameters ;
- (void)getMemberDetailsAsyncUsingParameters:(memberServicesSvc_getMemberDetails *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)userRegistrationUsingParameters:(memberServicesSvc_userRegistration *)aParameters ;
- (void)userRegistrationAsyncUsingParameters:(memberServicesSvc_userRegistration *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)updateMemberUsingParameters:(memberServicesSvc_updateMember *)aParameters ;
- (void)updateMemberAsyncUsingParameters:(memberServicesSvc_updateMember *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)changePasswordUsingParameters:(memberServicesSvc_changePassword *)aParameters ;
- (void)changePasswordAsyncUsingParameters:(memberServicesSvc_changePassword *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)validateOTPUsingParameters:(memberServicesSvc_validateOTP *)aParameters ;
- (void)validateOTPAsyncUsingParameters:(memberServicesSvc_validateOTP *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)resetPasswordUsingParameters:(memberServicesSvc_resetPassword *)aParameters ;
- (void)resetPasswordAsyncUsingParameters:(memberServicesSvc_resetPassword *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
- (memberServicesSoapBindingResponse *)deleteMemberUsingParameters:(memberServicesSvc_deleteMember *)aParameters ;
- (void)deleteMemberAsyncUsingParameters:(memberServicesSvc_deleteMember *)aParameters  delegate:(id<memberServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface memberServicesSoapBindingOperation : NSOperation {
	memberServicesSoapBinding *binding;
	memberServicesSoapBindingResponse * response;
	id<memberServicesSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) memberServicesSoapBinding *binding;
@property (  readonly) memberServicesSoapBindingResponse *response;
@property (nonatomic ) id<memberServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface memberServicesSoapBinding_getMembers : memberServicesSoapBindingOperation {
	memberServicesSvc_getMembers * parameters;
}
@property (strong) memberServicesSvc_getMembers * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_getMembers *)aParameters
;
@end
@interface memberServicesSoapBinding_authenticateUser : memberServicesSoapBindingOperation {
	memberServicesSvc_authenticateUser * parameters;
}
@property (strong) memberServicesSvc_authenticateUser * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_authenticateUser *)aParameters
;
@end
@interface memberServicesSoapBinding_generateOTP : memberServicesSoapBindingOperation {
	memberServicesSvc_generateOTP * parameters;
}
@property (strong) memberServicesSvc_generateOTP * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_generateOTP *)aParameters
;
@end
@interface memberServicesSoapBinding_createMember : memberServicesSoapBindingOperation {
	memberServicesSvc_createMember * parameters;
}
@property (strong) memberServicesSvc_createMember * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_createMember *)aParameters
;
@end
@interface memberServicesSoapBinding_getMemberDetails : memberServicesSoapBindingOperation {
	memberServicesSvc_getMemberDetails * parameters;
}
@property (strong) memberServicesSvc_getMemberDetails * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_getMemberDetails *)aParameters
;
@end
@interface memberServicesSoapBinding_userRegistration : memberServicesSoapBindingOperation {
	memberServicesSvc_userRegistration * parameters;
}
@property (strong) memberServicesSvc_userRegistration * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_userRegistration *)aParameters
;
@end
@interface memberServicesSoapBinding_updateMember : memberServicesSoapBindingOperation {
	memberServicesSvc_updateMember * parameters;
}
@property (strong) memberServicesSvc_updateMember * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_updateMember *)aParameters
;
@end
@interface memberServicesSoapBinding_changePassword : memberServicesSoapBindingOperation {
	memberServicesSvc_changePassword * parameters;
}
@property (strong) memberServicesSvc_changePassword * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_changePassword *)aParameters
;
@end
@interface memberServicesSoapBinding_validateOTP : memberServicesSoapBindingOperation {
	memberServicesSvc_validateOTP * parameters;
}
@property (strong) memberServicesSvc_validateOTP * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_validateOTP *)aParameters
;
@end
@interface memberServicesSoapBinding_resetPassword : memberServicesSoapBindingOperation {
	memberServicesSvc_resetPassword * parameters;
}
@property (strong) memberServicesSvc_resetPassword * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_resetPassword *)aParameters
;
@end
@interface memberServicesSoapBinding_deleteMember : memberServicesSoapBindingOperation {
	memberServicesSvc_deleteMember * parameters;
}
@property (strong) memberServicesSvc_deleteMember * parameters;
- (id)initWithBinding:(memberServicesSoapBinding *)aBinding delegate:(id<memberServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(memberServicesSvc_deleteMember *)aParameters
;
@end
@interface memberServicesSoapBinding_envelope : NSObject {
}
+ (memberServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface memberServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

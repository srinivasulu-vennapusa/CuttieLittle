#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class MemberServiceSvc_authenticateUser;
@class MemberServiceSvc_authenticateUserResponse;
@class MemberServiceSvc_changePassword;
@class MemberServiceSvc_changePasswordResponse;
@class MemberServiceSvc_createMember;
@class MemberServiceSvc_createMemberResponse;
@interface MemberServiceSvc_authenticateUser : NSObject {
	
/* elements */
	NSString * loginDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MemberServiceSvc_authenticateUser *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loginDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MemberServiceSvc_authenticateUserResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MemberServiceSvc_authenticateUserResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MemberServiceSvc_changePassword : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MemberServiceSvc_changePassword *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MemberServiceSvc_changePasswordResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MemberServiceSvc_changePasswordResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MemberServiceSvc_createMember : NSObject {
	
/* elements */
	NSString * memberDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MemberServiceSvc_createMember *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * memberDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface MemberServiceSvc_createMemberResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (MemberServiceSvc_createMemberResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "MemberServiceSvc.h"
@class MemberServiceSoapBinding;
@interface MemberServiceSvc : NSObject {
	
}
+ (MemberServiceSoapBinding *)MemberServiceSoapBinding;
@end
@class MemberServiceSoapBindingResponse;
@class MemberServiceSoapBindingOperation;
@protocol MemberServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(MemberServiceSoapBindingOperation *)operation completedWithResponse:(MemberServiceSoapBindingResponse *)response;
@end
@interface MemberServiceSoapBinding : NSObject <MemberServiceSoapBindingResponseDelegate,NSURLConnectionDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(MemberServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (MemberServiceSoapBindingResponse *)createMemberUsingParameters:(MemberServiceSvc_createMember *)aParameters ;
- (void)createMemberAsyncUsingParameters:(MemberServiceSvc_createMember *)aParameters  delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate;
- (MemberServiceSoapBindingResponse *)authenticateUserUsingParameters:(MemberServiceSvc_authenticateUser *)aParameters ;
- (void)authenticateUserAsyncUsingParameters:(MemberServiceSvc_authenticateUser *)aParameters  delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate;
- (MemberServiceSoapBindingResponse *)changePasswordUsingParameters:(MemberServiceSvc_changePassword *)aParameters ;
- (void)changePasswordAsyncUsingParameters:(MemberServiceSvc_changePassword *)aParameters  delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface MemberServiceSoapBindingOperation : NSOperation {
	MemberServiceSoapBinding *binding;
	MemberServiceSoapBindingResponse * response;
	id<MemberServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) MemberServiceSoapBinding *binding;
@property (  readonly) MemberServiceSoapBindingResponse *response;
@property (nonatomic ) id<MemberServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface MemberServiceSoapBinding_createMember : MemberServiceSoapBindingOperation {
	MemberServiceSvc_createMember * parameters;
}
@property (strong) MemberServiceSvc_createMember * parameters;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(MemberServiceSvc_createMember *)aParameters
;
@end
@interface MemberServiceSoapBinding_authenticateUser : MemberServiceSoapBindingOperation {
	MemberServiceSvc_authenticateUser * parameters;
}
@property (strong) MemberServiceSvc_authenticateUser * parameters;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(MemberServiceSvc_authenticateUser *)aParameters
;
@end
@interface MemberServiceSoapBinding_changePassword : MemberServiceSoapBindingOperation {
	MemberServiceSvc_changePassword * parameters;
}
@property (strong) MemberServiceSvc_changePassword * parameters;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(MemberServiceSvc_changePassword *)aParameters
;
@end
@interface MemberServiceSoapBinding_envelope : NSObject {
}
+ (MemberServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface MemberServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "tns1.h"
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "StoreStockVerificationImplServiceSvc.h"
#import "tns1.h"
@class StoreStockVerificationImplServiceSoapBinding;
@interface StoreStockVerificationImplServiceSvc : NSObject {
	
}
+ (StoreStockVerificationImplServiceSoapBinding *)StoreStockVerificationImplServiceSoapBinding;
@end
@class StoreStockVerificationImplServiceSoapBindingResponse;
@class StoreStockVerificationImplServiceSoapBindingOperation;
@protocol StoreStockVerificationImplServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StoreStockVerificationImplServiceSoapBindingOperation *)operation completedWithResponse:(StoreStockVerificationImplServiceSoapBindingResponse *)response;
@end
@interface StoreStockVerificationImplServiceSoapBinding : NSObject <StoreStockVerificationImplServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StoreStockVerificationImplServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StoreStockVerificationImplServiceSoapBindingResponse *)updateStockUsingParameters:(tns1_updateStock *)aParameters ;
- (void)updateStockAsyncUsingParameters:(tns1_updateStock *)aParameters  delegate:(id<StoreStockVerificationImplServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreStockVerificationImplServiceSoapBindingResponse *)getSkuDetailsUsingParameters:(tns1_getSkuDetails *)aParameters ;
- (void)getSkuDetailsAsyncUsingParameters:(tns1_getSkuDetails *)aParameters  delegate:(id<StoreStockVerificationImplServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StoreStockVerificationImplServiceSoapBindingOperation : NSOperation {
	StoreStockVerificationImplServiceSoapBinding *binding;
	StoreStockVerificationImplServiceSoapBindingResponse * response;
	id<StoreStockVerificationImplServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) StoreStockVerificationImplServiceSoapBinding *binding;
@property (  readonly) StoreStockVerificationImplServiceSoapBindingResponse *response;
@property (nonatomic ) id<StoreStockVerificationImplServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StoreStockVerificationImplServiceSoapBinding *)aBinding delegate:(id<StoreStockVerificationImplServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StoreStockVerificationImplServiceSoapBinding_updateStock : StoreStockVerificationImplServiceSoapBindingOperation {
	tns1_updateStock * parameters;
}
@property (strong) tns1_updateStock * parameters;
- (id)initWithBinding:(StoreStockVerificationImplServiceSoapBinding *)aBinding delegate:(id<StoreStockVerificationImplServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(tns1_updateStock *)aParameters
;
@end
@interface StoreStockVerificationImplServiceSoapBinding_getSkuDetails : StoreStockVerificationImplServiceSoapBindingOperation {
	tns1_getSkuDetails * parameters;
}
@property (strong) tns1_getSkuDetails * parameters;
- (id)initWithBinding:(StoreStockVerificationImplServiceSoapBinding *)aBinding delegate:(id<StoreStockVerificationImplServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(tns1_getSkuDetails *)aParameters
;
@end
@interface StoreStockVerificationImplServiceSoapBinding_envelope : NSObject {
}
+ (StoreStockVerificationImplServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StoreStockVerificationImplServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end

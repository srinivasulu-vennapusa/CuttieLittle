#import "GiftCouponServicesSvc.h"
#import <libxml/xmlstring.h>
#import "WebServiceUtility.h"
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation GiftCouponServicesSvc_createGiftCoupons
- (id)init
{
    if((self = [super init])) {
        giftCouponDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.giftCouponDetails != 0) {
        xmlAddChild(node, [self.giftCouponDetails xmlNodeForDoc:node->doc elementName:@"giftCouponDetails" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize giftCouponDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_createGiftCoupons *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_createGiftCoupons *newObject = [GiftCouponServicesSvc_createGiftCoupons new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "giftCouponDetails")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.giftCouponDetails = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_createGiftCouponsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.return_ != 0) {
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize return_;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_createGiftCouponsResponse *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_createGiftCouponsResponse *newObject = [GiftCouponServicesSvc_createGiftCouponsResponse new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "return")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.return_ = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_getCouponDetails
- (id)init
{
    if((self = [super init])) {
        couponDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.couponDetails != 0) {
        xmlAddChild(node, [self.couponDetails xmlNodeForDoc:node->doc elementName:@"couponDetails" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize couponDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_getCouponDetails *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_getCouponDetails *newObject = [GiftCouponServicesSvc_getCouponDetails new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "couponDetails")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.couponDetails = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_getCouponDetailsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.return_ != 0) {
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize return_;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_getCouponDetailsResponse *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_getCouponDetailsResponse *newObject = [GiftCouponServicesSvc_getCouponDetailsResponse new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "return")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.return_ = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_getGiftCoupons
- (id)init
{
    if((self = [super init])) {
        getGiftCouponsRequest = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.getGiftCouponsRequest != 0) {
        xmlAddChild(node, [self.getGiftCouponsRequest xmlNodeForDoc:node->doc elementName:@"getGiftCouponsRequest" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize getGiftCouponsRequest;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_getGiftCoupons *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_getGiftCoupons *newObject = [GiftCouponServicesSvc_getGiftCoupons new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "getGiftCouponsRequest")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.getGiftCouponsRequest = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_getGiftCouponsMaster
- (id)init
{
    if((self = [super init])) {
        giftCouponDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.giftCouponDetails != 0) {
        xmlAddChild(node, [self.giftCouponDetails xmlNodeForDoc:node->doc elementName:@"giftCouponDetails" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize giftCouponDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_getGiftCouponsMaster *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_getGiftCouponsMaster *newObject = [GiftCouponServicesSvc_getGiftCouponsMaster new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "giftCouponDetails")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.giftCouponDetails = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_getGiftCouponsMasterResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.return_ != 0) {
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize return_;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_getGiftCouponsMasterResponse *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_getGiftCouponsMasterResponse *newObject = [GiftCouponServicesSvc_getGiftCouponsMasterResponse new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "return")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.return_ = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_getGiftCouponsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.return_ != 0) {
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize return_;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_getGiftCouponsResponse *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_getGiftCouponsResponse *newObject = [GiftCouponServicesSvc_getGiftCouponsResponse new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "return")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.return_ = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_issueGiftCouponToCustomer
- (id)init
{
    if((self = [super init])) {
        issueCoupon = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.issueCoupon != 0) {
        xmlAddChild(node, [self.issueCoupon xmlNodeForDoc:node->doc elementName:@"issueCoupon" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize issueCoupon;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_issueGiftCouponToCustomer *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_issueGiftCouponToCustomer *newObject = [GiftCouponServicesSvc_issueGiftCouponToCustomer new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "issueCoupon")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.issueCoupon = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc_issueGiftCouponToCustomerResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"GiftCouponServicesSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
    NSString *nodeName = nil;
    if(elNSPrefix != nil && elNSPrefix.length > 0)
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
    }
    else
    {
        nodeName = [NSString stringWithFormat:@"%@:%@", @"GiftCouponServicesSvc", elName];
    }
    
    xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
    
    
    [self addAttributesToNode:node];
    
    [self addElementsToNode:node];
    
    return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
    
}
- (void)addElementsToNode:(xmlNodePtr)node
{
    
    if(self.return_ != 0) {
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"GiftCouponServicesSvc"]);
    }
}
/* elements */
@synthesize return_;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (GiftCouponServicesSvc_issueGiftCouponToCustomerResponse *)deserializeNode:(xmlNodePtr)cur
{
    GiftCouponServicesSvc_issueGiftCouponToCustomerResponse *newObject = [GiftCouponServicesSvc_issueGiftCouponToCustomerResponse new];
    
    [newObject deserializeAttributesFromNode:cur];
    [newObject deserializeElementsFromNode:cur];
    
    return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
    
    
    for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
        if(cur->type == XML_ELEMENT_NODE) {
            xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
            NSString *elementString = nil;
            
            if(elementText != NULL) {
                elementString = @((char*)elementText);
                [elementString self]; // avoid compiler warning for unused var
                xmlFree(elementText);
            }
            if(xmlStrEqual(cur->name, (const xmlChar *) "return")) {
                
                Class elementClass = nil;
                xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
                if(instanceType == NULL) {
                    elementClass = [NSString  class];
                } else {
                    NSString *elementTypeString = @((char*)instanceType);
                    
                    NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
                    
                    NSString *elementClassString = nil;
                    if(elementTypeArray.count > 1) {
                        NSString *prefix = elementTypeArray[0];
                        NSString *localName = elementTypeArray[1];
                        
                        xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
                        
                        NSString *standardPrefix = ([USGlobals sharedInstance].wsdlStandardNamespaces)[@((char*)elementNamespace->href)];
                        
                        elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
                    } else {
                        elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, elementTypeString.length)];
                    }
                    
                    elementClass = NSClassFromString(elementClassString);
                    xmlFree(instanceType);
                }
                
                id newChild = [elementClass deserializeNode:cur];
                
                self.return_ = newChild;
            }
        }
    }
}
@end
@implementation GiftCouponServicesSvc
+ (void)initialize
{
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"http://www.w3.org/2001/XMLSchema"] = @"xs";
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"www.technolabssoftware.com"] = @"GiftCouponServicesSvc";
}
+ (GiftCouponServicesSoapBinding *)GiftCouponServicesSoapBinding
{
//    return [[[GiftCouponServicesSoapBinding alloc] initWithAddress:@"http://localhost:8080/OmniRetailerServices/GiftCouponServices"] autorelease];
    NSString *url = [NSString stringWithFormat:@"%@%@",[WebServiceUtility getServiceURL],@"GiftCouponServices"];
    return [[GiftCouponServicesSoapBinding alloc] initWithAddress:url];

}
@end
@implementation GiftCouponServicesSoapBinding
@synthesize address;
@synthesize defaultTimeout;
@synthesize logXMLInOut;
@synthesize cookies;
@synthesize authUsername;
@synthesize authPassword;
- (id)init
{
    if((self = [super init])) {
        address = nil;
        cookies = nil;
        defaultTimeout = 60;//seconds
        logXMLInOut = NO;
        synchronousOperationComplete = NO;
    }
    
    return self;
}
- (id)initWithAddress:(NSString *)anAddress
{
    if((self = [self init])) {
        self.address = [NSURL URLWithString:anAddress];
    }
    
    return self;
}
- (void)addCookie:(NSHTTPCookie *)toAdd
{
    if(toAdd != nil) {
        if(cookies == nil) cookies = [[NSMutableArray alloc] init];
        [cookies addObject:toAdd];
    }
}
- (GiftCouponServicesSoapBindingResponse *)performSynchronousOperation:(GiftCouponServicesSoapBindingOperation *)operation
{
    synchronousOperationComplete = NO;
    [operation start];
    
    // Now wait for response
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    
    while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    return operation.response;
}
- (void)performAsynchronousOperation:(GiftCouponServicesSoapBindingOperation *)operation
{
    [operation start];
}
- (void) operation:(GiftCouponServicesSoapBindingOperation *)operation completedWithResponse:(GiftCouponServicesSoapBindingResponse *)response
{
    synchronousOperationComplete = YES;
}
- (GiftCouponServicesSoapBindingResponse *)getGiftCouponsMasterUsingParameters:(GiftCouponServicesSvc_getGiftCouponsMaster *)aParameters 
{
    return [self performSynchronousOperation:[(GiftCouponServicesSoapBinding_getGiftCouponsMaster*)[GiftCouponServicesSoapBinding_getGiftCouponsMaster alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)getGiftCouponsMasterAsyncUsingParameters:(GiftCouponServicesSvc_getGiftCouponsMaster *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(GiftCouponServicesSoapBinding_getGiftCouponsMaster*)[GiftCouponServicesSoapBinding_getGiftCouponsMaster alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (GiftCouponServicesSoapBindingResponse *)getGiftCouponsUsingParameters:(GiftCouponServicesSvc_getGiftCoupons *)aParameters 
{
    return [self performSynchronousOperation:[(GiftCouponServicesSoapBinding_getGiftCoupons*)[GiftCouponServicesSoapBinding_getGiftCoupons alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)getGiftCouponsAsyncUsingParameters:(GiftCouponServicesSvc_getGiftCoupons *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(GiftCouponServicesSoapBinding_getGiftCoupons*)[GiftCouponServicesSoapBinding_getGiftCoupons alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (GiftCouponServicesSoapBindingResponse *)getCouponDetailsUsingParameters:(GiftCouponServicesSvc_getCouponDetails *)aParameters 
{
    return [self performSynchronousOperation:[(GiftCouponServicesSoapBinding_getCouponDetails*)[GiftCouponServicesSoapBinding_getCouponDetails alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)getCouponDetailsAsyncUsingParameters:(GiftCouponServicesSvc_getCouponDetails *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(GiftCouponServicesSoapBinding_getCouponDetails*)[GiftCouponServicesSoapBinding_getCouponDetails alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (GiftCouponServicesSoapBindingResponse *)issueGiftCouponToCustomerUsingParameters:(GiftCouponServicesSvc_issueGiftCouponToCustomer *)aParameters 
{
    return [self performSynchronousOperation:[(GiftCouponServicesSoapBinding_issueGiftCouponToCustomer*)[GiftCouponServicesSoapBinding_issueGiftCouponToCustomer alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)issueGiftCouponToCustomerAsyncUsingParameters:(GiftCouponServicesSvc_issueGiftCouponToCustomer *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(GiftCouponServicesSoapBinding_issueGiftCouponToCustomer*)[GiftCouponServicesSoapBinding_issueGiftCouponToCustomer alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (GiftCouponServicesSoapBindingResponse *)createGiftCouponsUsingParameters:(GiftCouponServicesSvc_createGiftCoupons *)aParameters 
{
    return [self performSynchronousOperation:[(GiftCouponServicesSoapBinding_createGiftCoupons*)[GiftCouponServicesSoapBinding_createGiftCoupons alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)createGiftCouponsAsyncUsingParameters:(GiftCouponServicesSvc_createGiftCoupons *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(GiftCouponServicesSoapBinding_createGiftCoupons*)[GiftCouponServicesSoapBinding_createGiftCoupons alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(GiftCouponServicesSoapBindingOperation *)operation
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.address 
                                                                                                                 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                                                                         timeoutInterval:self.defaultTimeout];
    NSData *bodyData = [outputBody dataUsingEncoding:NSUTF8StringEncoding];
    
    if(cookies != nil) {
        request.allHTTPHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    }
    [request setValue:@"wsdl2objc" forHTTPHeaderField:@"User-Agent"];
    [request setValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%u", bodyData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:self.address.host forHTTPHeaderField:@"Host"];
    request.HTTPMethod = @"POST";
    // set version 1.1 - how?
    request.HTTPBody = bodyData;
        
    if(self.logXMLInOut) {
        NSLog(@"OutputHeaders:\n%@", request.allHTTPHeaderFields);
        NSLog(@"OutputBody:\n%@", outputBody);
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:operation];
    
    operation.urlConnection = connection;
}
@end
@implementation GiftCouponServicesSoapBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate
{
    if ((self = [super init])) {
        self.binding = aBinding;
        response = nil;
        self.delegate = aDelegate;
        self.responseData = nil;
        self.urlConnection = nil;
    }
    
    return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (challenge.previousFailureCount == 0) {
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:self.binding.authUsername
                                                 password:self.binding.authPassword
                                              persistence:NSURLCredentialPersistenceForSession];
        [challenge.sender useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
        [challenge.sender cancelAuthenticationChallenge:challenge];
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Authentication Error"};
        NSError *authError = [NSError errorWithDomain:@"Connection Authentication" code:0 userInfo:userInfo];
        [self connection:connection didFailWithError:authError];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
    NSHTTPURLResponse *httpResponse;
    if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
        httpResponse = (NSHTTPURLResponse *) urlResponse;
    } else {
        httpResponse = nil;
    }
    
    if(binding.logXMLInOut) {
        NSLog(@"ResponseStatus: %u\n", httpResponse.statusCode);
        NSLog(@"ResponseHeaders:\n%@", httpResponse.allHeaderFields);
    }
    
    NSMutableArray *cookies = [[NSHTTPCookie cookiesWithResponseHeaderFields:httpResponse.allHeaderFields forURL:binding.address] mutableCopy];
    
    binding.cookies = cookies;
  if ([urlResponse.MIMEType rangeOfString:@"text/xml"].length == 0) {
        NSError *error = nil;
        [connection cancel];
        if (httpResponse.statusCode >= 400) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]};
                
            error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseHTTP" code:httpResponse.statusCode userInfo:userInfo];
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]};
            error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseHTTP" code:1 userInfo:userInfo];
        }
                
        [self connection:connection didFailWithError:error];
  }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  if (responseData == nil) {
        responseData = [data mutableCopy];
    } else {
        [responseData appendData:data];
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (binding.logXMLInOut) {
        NSLog(@"ResponseError:\n%@", error);
    }
    response.error = error;
    [delegate operation:self completedWithResponse:response];
}
- (void)dealloc
{
    delegate = nil;
    
}
@end
@implementation GiftCouponServicesSoapBinding_getGiftCouponsMaster
@synthesize parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(GiftCouponServicesSvc_getGiftCouponsMaster *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [GiftCouponServicesSoapBindingResponse new];
    
    GiftCouponServicesSoapBinding_envelope *envelope = [GiftCouponServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getGiftCouponsMaster"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"GiftCouponServicesSvc:giftCouponDetails" withString:@"giftCouponDetails"];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"&amp;quot;" withString:@"\""];

    [binding sendHTTPCallUsingBody:operationXMLString soapAction:@"" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (responseData != nil && delegate != nil)
    {
        xmlDocPtr doc;
        xmlNodePtr cur;
        
        if (binding.logXMLInOut) {
            NSLog(@"ResponseBody:\n%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        
        doc = xmlParseMemory(responseData.bytes, responseData.length);
        
        if (doc == NULL) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Errors while parsing returned XML"};
            
            response.error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
            [delegate operation:self completedWithResponse:response];
        } else {
            cur = xmlDocGetRootElement(doc);
            cur = cur->children;
            
            for( ; cur != NULL ; cur = cur->next) {
                if(cur->type == XML_ELEMENT_NODE) {
                    
                    if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
                        NSMutableArray *responseBodyParts = [NSMutableArray array];
                        
                        xmlNodePtr bodyNode;
                        for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
                            if(cur->type == XML_ELEMENT_NODE) {
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getGiftCouponsMasterResponse")) {
                                    GiftCouponServicesSvc_getGiftCouponsMasterResponse *bodyObject = [GiftCouponServicesSvc_getGiftCouponsMasterResponse deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                                if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
                                    xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
                                    SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                            }
                        }
                        
                        response.bodyParts = responseBodyParts;
                    }
                }
            }
            
            xmlFreeDoc(doc);
        }
        
        xmlCleanupParser();
        [delegate operation:self completedWithResponse:response];
    }
}
@end
@implementation GiftCouponServicesSoapBinding_getGiftCoupons
@synthesize parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(GiftCouponServicesSvc_getGiftCoupons *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [GiftCouponServicesSoapBindingResponse new];
    
    GiftCouponServicesSoapBinding_envelope *envelope = [GiftCouponServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getGiftCoupons"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    
    [binding sendHTTPCallUsingBody:operationXMLString soapAction:@"" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (responseData != nil && delegate != nil)
    {
        xmlDocPtr doc;
        xmlNodePtr cur;
        
        if (binding.logXMLInOut) {
            NSLog(@"ResponseBody:\n%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        
        doc = xmlParseMemory(responseData.bytes, responseData.length);
        
        if (doc == NULL) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Errors while parsing returned XML"};
            
            response.error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
            [delegate operation:self completedWithResponse:response];
        } else {
            cur = xmlDocGetRootElement(doc);
            cur = cur->children;
            
            for( ; cur != NULL ; cur = cur->next) {
                if(cur->type == XML_ELEMENT_NODE) {
                    
                    if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
                        NSMutableArray *responseBodyParts = [NSMutableArray array];
                        
                        xmlNodePtr bodyNode;
                        for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
                            if(cur->type == XML_ELEMENT_NODE) {
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getGiftCouponsResponse")) {
                                    GiftCouponServicesSvc_getGiftCouponsResponse *bodyObject = [GiftCouponServicesSvc_getGiftCouponsResponse deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                                if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
                                    xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
                                    SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                            }
                        }
                        
                        response.bodyParts = responseBodyParts;
                    }
                }
            }
            
            xmlFreeDoc(doc);
        }
        
        xmlCleanupParser();
        [delegate operation:self completedWithResponse:response];
    }
}
@end
@implementation GiftCouponServicesSoapBinding_getCouponDetails
@synthesize parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(GiftCouponServicesSvc_getCouponDetails *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [GiftCouponServicesSoapBindingResponse new];
    
    GiftCouponServicesSoapBinding_envelope *envelope = [GiftCouponServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getCouponDetails"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"GiftCouponServicesSvc:couponDetails" withString:@"couponDetails"];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"&amp;quot;" withString:@"\""];

    [binding sendHTTPCallUsingBody:operationXMLString soapAction:@"" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (responseData != nil && delegate != nil)
    {
        xmlDocPtr doc;
        xmlNodePtr cur;
        
        if (binding.logXMLInOut) {
            NSLog(@"ResponseBody:\n%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        
        doc = xmlParseMemory(responseData.bytes, responseData.length);
        
        if (doc == NULL) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Errors while parsing returned XML"};
            
            response.error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
            [delegate operation:self completedWithResponse:response];
        } else {
            cur = xmlDocGetRootElement(doc);
            cur = cur->children;
            
            for( ; cur != NULL ; cur = cur->next) {
                if(cur->type == XML_ELEMENT_NODE) {
                    
                    if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
                        NSMutableArray *responseBodyParts = [NSMutableArray array];
                        
                        xmlNodePtr bodyNode;
                        for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
                            if(cur->type == XML_ELEMENT_NODE) {
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getCouponDetailsResponse")) {
                                    GiftCouponServicesSvc_getCouponDetailsResponse *bodyObject = [GiftCouponServicesSvc_getCouponDetailsResponse deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                                if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
                                    xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
                                    SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                            }
                        }
                        
                        response.bodyParts = responseBodyParts;
                    }
                }
            }
            
            xmlFreeDoc(doc);
        }
        
        xmlCleanupParser();
        [delegate operation:self completedWithResponse:response];
    }
}
@end
@implementation GiftCouponServicesSoapBinding_issueGiftCouponToCustomer
@synthesize parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(GiftCouponServicesSvc_issueGiftCouponToCustomer *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [GiftCouponServicesSoapBindingResponse new];
    
    GiftCouponServicesSoapBinding_envelope *envelope = [GiftCouponServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"issueGiftCouponToCustomer"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"GiftCouponServicesSvc:issueCoupon" withString:@"issueCoupon"];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"&amp;quot;" withString:@"\""];

    [binding sendHTTPCallUsingBody:operationXMLString soapAction:@"" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (responseData != nil && delegate != nil)
    {
        xmlDocPtr doc;
        xmlNodePtr cur;
        
        if (binding.logXMLInOut) {
            NSLog(@"ResponseBody:\n%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        
        doc = xmlParseMemory(responseData.bytes, responseData.length);
        
        if (doc == NULL) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Errors while parsing returned XML"};
            
            response.error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
            [delegate operation:self completedWithResponse:response];
        } else {
            cur = xmlDocGetRootElement(doc);
            cur = cur->children;
            
            for( ; cur != NULL ; cur = cur->next) {
                if(cur->type == XML_ELEMENT_NODE) {
                    
                    if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
                        NSMutableArray *responseBodyParts = [NSMutableArray array];
                        
                        xmlNodePtr bodyNode;
                        for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
                            if(cur->type == XML_ELEMENT_NODE) {
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "issueGiftCouponToCustomerResponse")) {
                                    GiftCouponServicesSvc_issueGiftCouponToCustomerResponse *bodyObject = [GiftCouponServicesSvc_issueGiftCouponToCustomerResponse deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                                if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
                                    xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
                                    SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                            }
                        }
                        
                        response.bodyParts = responseBodyParts;
                    }
                }
            }
            
            xmlFreeDoc(doc);
        }
        
        xmlCleanupParser();
        [delegate operation:self completedWithResponse:response];
    }
}
@end
@implementation GiftCouponServicesSoapBinding_createGiftCoupons
@synthesize parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(GiftCouponServicesSvc_createGiftCoupons *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [GiftCouponServicesSoapBindingResponse new];
    
    GiftCouponServicesSoapBinding_envelope *envelope = [GiftCouponServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createGiftCoupons"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    
    [binding sendHTTPCallUsingBody:operationXMLString soapAction:@"" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (responseData != nil && delegate != nil)
    {
        xmlDocPtr doc;
        xmlNodePtr cur;
        
        if (binding.logXMLInOut) {
            NSLog(@"ResponseBody:\n%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        
        doc = xmlParseMemory(responseData.bytes, responseData.length);
        
        if (doc == NULL) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Errors while parsing returned XML"};
            
            response.error = [NSError errorWithDomain:@"GiftCouponServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
            [delegate operation:self completedWithResponse:response];
        } else {
            cur = xmlDocGetRootElement(doc);
            cur = cur->children;
            
            for( ; cur != NULL ; cur = cur->next) {
                if(cur->type == XML_ELEMENT_NODE) {
                    
                    if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
                        NSMutableArray *responseBodyParts = [NSMutableArray array];
                        
                        xmlNodePtr bodyNode;
                        for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
                            if(cur->type == XML_ELEMENT_NODE) {
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createGiftCouponsResponse")) {
                                    GiftCouponServicesSvc_createGiftCouponsResponse *bodyObject = [GiftCouponServicesSvc_createGiftCouponsResponse deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                                if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
                                    xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
                                    SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
                                    //NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
                                    if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
                                }
                            }
                        }
                        
                        response.bodyParts = responseBodyParts;
                    }
                }
            }
            
            xmlFreeDoc(doc);
        }
        
        xmlCleanupParser();
        [delegate operation:self completedWithResponse:response];
    }
}
@end
static GiftCouponServicesSoapBinding_envelope *GiftCouponServicesSoapBindingSharedEnvelopeInstance = nil;
@implementation GiftCouponServicesSoapBinding_envelope
+ (GiftCouponServicesSoapBinding_envelope *)sharedInstance
{
    if(GiftCouponServicesSoapBindingSharedEnvelopeInstance == nil) {
        GiftCouponServicesSoapBindingSharedEnvelopeInstance = [GiftCouponServicesSoapBinding_envelope new];
    }
    
    return GiftCouponServicesSoapBindingSharedEnvelopeInstance;
}
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements
{
    xmlDocPtr doc;
    
    doc = xmlNewDoc((const xmlChar*)XML_DEFAULT_VERSION);
    if (doc == NULL) {
        NSLog(@"Error creating the xml document tree");
        return @"";
    }
    
    xmlNodePtr root = xmlNewDocNode(doc, NULL, (const xmlChar*)"Envelope", NULL);
    xmlDocSetRootElement(doc, root);
    
    xmlNsPtr soapEnvelopeNs = xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/envelope/", (const xmlChar*)"soap");
    xmlSetNs(root, soapEnvelopeNs);
    
    xmlNsPtr xslNs = xmlNewNs(root, (const xmlChar*)"http://www.w3.org/1999/XSL/Transform", (const xmlChar*)"xsl");
    xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema-instance", (const xmlChar*)"xsi");
    
    xmlNewNsProp(root, xslNs, (const xmlChar*)"version", (const xmlChar*)"1.0");
    
    xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema", (const xmlChar*)"xs");
    xmlNewNs(root, (const xmlChar*)"www.technolabssoftware.com", (const xmlChar*)"GiftCouponServicesSvc");
    
    if((headerElements != nil) && (headerElements.count > 0)) {
        xmlNodePtr headerNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Header", NULL);
        xmlAddChild(root, headerNode);
        
        for(NSString *key in headerElements.allKeys) {
            id header = headerElements[key];
            xmlAddChild(headerNode, [header xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
        }
    }
    
    if((bodyElements != nil) && (bodyElements.count > 0)) {
        xmlNodePtr bodyNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Body", NULL);
        xmlAddChild(root, bodyNode);
        
        for(NSString *key in bodyElements.allKeys) {
            id body = bodyElements[key];
            xmlAddChild(bodyNode, [body xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
        }
    }
    
    xmlChar *buf;
    int size;
    xmlDocDumpFormatMemory(doc, &buf, &size, 1);
    
    NSString *serializedForm = @((const char*)buf);
    xmlFree(buf);
    
    xmlFreeDoc(doc);    
    return serializedForm;
}
@end
@implementation GiftCouponServicesSoapBindingResponse
@synthesize headers;
@synthesize bodyParts;
@synthesize error;
- (id)init
{
    if((self = [super init])) {
        headers = nil;
        bodyParts = nil;
        error = nil;
    }
    
    return self;
}
@end

#import "DealServicesSvc.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#import "Global.h"
#import "WebServiceUtility.h"
#endif
@implementation DealServicesSvc_applyDealsAndOffers
- (id)init
{
    if((self = [super init])) {
        dealDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
    
    if(self.dealDetails != 0) {
        xmlAddChild(node, [self.dealDetails xmlNodeForDoc:node->doc elementName:@"dealDetails" elementNSPrefix:@"DealServicesSvc"]);
    }
}
/* elements */
@synthesize dealDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (DealServicesSvc_applyDealsAndOffers *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_applyDealsAndOffers *newObject = [DealServicesSvc_applyDealsAndOffers new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "dealDetails")) {
                
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
                
                self.dealDetails = newChild;
            }
        }
    }
}
@end
@implementation DealServicesSvc_applyDealsAndOffersResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"DealServicesSvc"]);
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
+ (DealServicesSvc_applyDealsAndOffersResponse *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_applyDealsAndOffersResponse *newObject = [DealServicesSvc_applyDealsAndOffersResponse new];
    
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
@implementation DealServicesSvc_createDeal
- (id)init
{
    if((self = [super init])) {
        dealDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
    
    if(self.dealDetails != 0) {
        xmlAddChild(node, [self.dealDetails xmlNodeForDoc:node->doc elementName:@"dealDetails" elementNSPrefix:@"DealServicesSvc"]);
    }
}
/* elements */
@synthesize dealDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (DealServicesSvc_createDeal *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_createDeal *newObject = [DealServicesSvc_createDeal new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "dealDetails")) {
                
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
                
                self.dealDetails = newChild;
            }
        }
    }
}
@end
@implementation DealServicesSvc_createDealResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"DealServicesSvc"]);
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
+ (DealServicesSvc_createDealResponse *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_createDealResponse *newObject = [DealServicesSvc_createDealResponse new];
    
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
@implementation DealServicesSvc_deleteDeals
- (id)init
{
    if((self = [super init])) {
        dealDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
    
    if(self.dealDetails != 0) {
        xmlAddChild(node, [self.dealDetails xmlNodeForDoc:node->doc elementName:@"dealDetails" elementNSPrefix:@"DealServicesSvc"]);
    }
}
/* elements */
@synthesize dealDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (DealServicesSvc_deleteDeals *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_deleteDeals *newObject = [DealServicesSvc_deleteDeals new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "dealDetails")) {
                
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
                
                self.dealDetails = newChild;
            }
        }
    }
}
@end
@implementation DealServicesSvc_deleteDealsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"DealServicesSvc"]);
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
+ (DealServicesSvc_deleteDealsResponse *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_deleteDealsResponse *newObject = [DealServicesSvc_deleteDealsResponse new];
    
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
@implementation DealServicesSvc_getDeals
- (id)init
{
    if((self = [super init])) {
        dealDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
    
    if(self.dealDetails != 0) {
        xmlAddChild(node, [self.dealDetails xmlNodeForDoc:node->doc elementName:@"dealDetails" elementNSPrefix:@"DealServicesSvc"]);
    }
}
/* elements */
@synthesize dealDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (DealServicesSvc_getDeals *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_getDeals *newObject = [DealServicesSvc_getDeals new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "dealDetails")) {
                
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
                
                self.dealDetails = newChild;
            }
        }
    }
}
@end
@implementation DealServicesSvc_getDealsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"DealServicesSvc"]);
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
+ (DealServicesSvc_getDealsResponse *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_getDealsResponse *newObject = [DealServicesSvc_getDealsResponse new];
    
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
@implementation DealServicesSvc_searchDeals
- (id)init
{
    if((self = [super init])) {
        searchCriteria = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
    
    if(self.searchCriteria != 0) {
        xmlAddChild(node, [self.searchCriteria xmlNodeForDoc:node->doc elementName:@"searchCriteria" elementNSPrefix:@"DealServicesSvc"]);
    }
}
/* elements */
@synthesize searchCriteria;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (DealServicesSvc_searchDeals *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_searchDeals *newObject = [DealServicesSvc_searchDeals new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "searchCriteria")) {
                
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
                
                self.searchCriteria = newChild;
            }
        }
    }
}
@end
@implementation DealServicesSvc_searchDealsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"DealServicesSvc"]);
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
+ (DealServicesSvc_searchDealsResponse *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_searchDealsResponse *newObject = [DealServicesSvc_searchDealsResponse new];
    
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
@implementation DealServicesSvc_updateDeal
- (id)init
{
    if((self = [super init])) {
        dealDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
    
    if(self.dealDetails != 0) {
        xmlAddChild(node, [self.dealDetails xmlNodeForDoc:node->doc elementName:@"dealDetails" elementNSPrefix:@"DealServicesSvc"]);
    }
}
/* elements */
@synthesize dealDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (DealServicesSvc_updateDeal *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_updateDeal *newObject = [DealServicesSvc_updateDeal new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "dealDetails")) {
                
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
                
                self.dealDetails = newChild;
            }
        }
    }
}
@end
@implementation DealServicesSvc_updateDealResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"DealServicesSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"DealServicesSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"DealServicesSvc"]);
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
+ (DealServicesSvc_updateDealResponse *)deserializeNode:(xmlNodePtr)cur
{
    DealServicesSvc_updateDealResponse *newObject = [DealServicesSvc_updateDealResponse new];
    
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
@implementation DealServicesSvc
+ (void)initialize
{
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"http://www.w3.org/2001/XMLSchema"] = @"xs";
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"www.technolabssoftware.com"] = @"DealServicesSvc";
}
+ (DealServicesSoapBinding *)DealServicesSoapBinding
{
//    return [[[DealServicesSoapBinding alloc] initWithAddress:@"http://10.10.0.17:9999/OmniRetailerServices/DealServices"] autorelease];
    NSString *url = [NSString stringWithFormat:@"%@%@",[WebServiceUtility getServiceURL],@"DealServices"];
    return [[DealServicesSoapBinding alloc] initWithAddress:url];
}
@end
@implementation DealServicesSoapBinding
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
        defaultTimeout = 10;//seconds
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
- (DealServicesSoapBindingResponse *)performSynchronousOperation:(DealServicesSoapBindingOperation *)operation
{
    synchronousOperationComplete = NO;
    [operation start];
    
    // Now wait for response
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    
    while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    return operation.response;
}
- (void)performAsynchronousOperation:(DealServicesSoapBindingOperation *)operation
{
    [operation start];
}
- (void) operation:(DealServicesSoapBindingOperation *)operation completedWithResponse:(DealServicesSoapBindingResponse *)response
{
    synchronousOperationComplete = YES;
}
- (DealServicesSoapBindingResponse *)updateDealUsingParameters:(DealServicesSvc_updateDeal *)aParameters 
{
    return [self performSynchronousOperation:[(DealServicesSoapBinding_updateDeal*)[DealServicesSoapBinding_updateDeal alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)updateDealAsyncUsingParameters:(DealServicesSvc_updateDeal *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(DealServicesSoapBinding_updateDeal*)[DealServicesSoapBinding_updateDeal alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (DealServicesSoapBindingResponse *)getDealsUsingParameters:(DealServicesSvc_getDeals *)aParameters 
{
    return [self performSynchronousOperation:[(DealServicesSoapBinding_getDeals*)[DealServicesSoapBinding_getDeals alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)getDealsAsyncUsingParameters:(DealServicesSvc_getDeals *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(DealServicesSoapBinding_getDeals*)[DealServicesSoapBinding_getDeals alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (DealServicesSoapBindingResponse *)applyDealsAndOffersUsingParameters:(DealServicesSvc_applyDealsAndOffers *)aParameters 
{
    return [self performSynchronousOperation:[(DealServicesSoapBinding_applyDealsAndOffers*)[DealServicesSoapBinding_applyDealsAndOffers alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)applyDealsAndOffersAsyncUsingParameters:(DealServicesSvc_applyDealsAndOffers *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(DealServicesSoapBinding_applyDealsAndOffers*)[DealServicesSoapBinding_applyDealsAndOffers alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (DealServicesSoapBindingResponse *)createDealUsingParameters:(DealServicesSvc_createDeal *)aParameters 
{
    return [self performSynchronousOperation:[(DealServicesSoapBinding_createDeal*)[DealServicesSoapBinding_createDeal alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)createDealAsyncUsingParameters:(DealServicesSvc_createDeal *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(DealServicesSoapBinding_createDeal*)[DealServicesSoapBinding_createDeal alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (DealServicesSoapBindingResponse *)searchDealsUsingParameters:(DealServicesSvc_searchDeals *)aParameters 
{
    return [self performSynchronousOperation:[(DealServicesSoapBinding_searchDeals*)[DealServicesSoapBinding_searchDeals alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)searchDealsAsyncUsingParameters:(DealServicesSvc_searchDeals *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(DealServicesSoapBinding_searchDeals*)[DealServicesSoapBinding_searchDeals alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (DealServicesSoapBindingResponse *)deleteDealsUsingParameters:(DealServicesSvc_deleteDeals *)aParameters 
{
    return [self performSynchronousOperation:[(DealServicesSoapBinding_deleteDeals*)[DealServicesSoapBinding_deleteDeals alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)deleteDealsAsyncUsingParameters:(DealServicesSvc_deleteDeals *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(DealServicesSoapBinding_deleteDeals*)[DealServicesSoapBinding_deleteDeals alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(DealServicesSoapBindingOperation *)operation
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
@implementation DealServicesSoapBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
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
                
            error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseHTTP" code:httpResponse.statusCode userInfo:userInfo];
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]};
            error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseHTTP" code:1 userInfo:userInfo];
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
@implementation DealServicesSoapBinding_updateDeal
@synthesize parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(DealServicesSvc_updateDeal *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [DealServicesSoapBindingResponse new];
    
    DealServicesSoapBinding_envelope *envelope = [DealServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"updateDeal"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "updateDealResponse")) {
                                    DealServicesSvc_updateDealResponse *bodyObject = [DealServicesSvc_updateDealResponse deserializeNode:bodyNode];
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
@implementation DealServicesSoapBinding_getDeals
@synthesize parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(DealServicesSvc_getDeals *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [DealServicesSoapBindingResponse new];
    
    DealServicesSoapBinding_envelope *envelope = [DealServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getDeals"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"DealServicesSvc:dealDetails" withString:@"dealDetails"];
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
            
            response.error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getDealsResponse")) {
                                    DealServicesSvc_getDealsResponse *bodyObject = [DealServicesSvc_getDealsResponse deserializeNode:bodyNode];
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
@implementation DealServicesSoapBinding_applyDealsAndOffers
@synthesize parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(DealServicesSvc_applyDealsAndOffers *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [DealServicesSoapBindingResponse new];
    
    DealServicesSoapBinding_envelope *envelope = [DealServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"applyDealsAndOffers"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"DealServicesSvc:dealDetails" withString:@"dealDetails"];
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
            
            response.error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "applyDealsAndOffersResponse")) {
                                    DealServicesSvc_applyDealsAndOffersResponse *bodyObject = [DealServicesSvc_applyDealsAndOffersResponse deserializeNode:bodyNode];
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
@implementation DealServicesSoapBinding_createDeal
@synthesize parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(DealServicesSvc_createDeal *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [DealServicesSoapBindingResponse new];
    
    DealServicesSoapBinding_envelope *envelope = [DealServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createDeal"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createDealResponse")) {
                                    DealServicesSvc_createDealResponse *bodyObject = [DealServicesSvc_createDealResponse deserializeNode:bodyNode];
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
@implementation DealServicesSoapBinding_searchDeals
@synthesize parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(DealServicesSvc_searchDeals *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [DealServicesSoapBindingResponse new];
    
    DealServicesSoapBinding_envelope *envelope = [DealServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"searchDeals"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"DealServicesSvc:searchCriteria" withString:@"searchCriteria"];
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
            
            response.error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "searchDealsResponse")) {
                                    DealServicesSvc_searchDealsResponse *bodyObject = [DealServicesSvc_searchDealsResponse deserializeNode:bodyNode];
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
@implementation DealServicesSoapBinding_deleteDeals
@synthesize parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate
parameters:(DealServicesSvc_deleteDeals *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [DealServicesSoapBindingResponse new];
    
    DealServicesSoapBinding_envelope *envelope = [DealServicesSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"deleteDeals"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"DealServicesSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "deleteDealsResponse")) {
                                    DealServicesSvc_deleteDealsResponse *bodyObject = [DealServicesSvc_deleteDealsResponse deserializeNode:bodyNode];
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
static DealServicesSoapBinding_envelope *DealServicesSoapBindingSharedEnvelopeInstance = nil;
@implementation DealServicesSoapBinding_envelope
+ (DealServicesSoapBinding_envelope *)sharedInstance
{
    if(DealServicesSoapBindingSharedEnvelopeInstance == nil) {
        DealServicesSoapBindingSharedEnvelopeInstance = [DealServicesSoapBinding_envelope new];
    }
    
    return DealServicesSoapBindingSharedEnvelopeInstance;
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
    xmlNewNs(root, (const xmlChar*)"www.technolabssoftware.com", (const xmlChar*)"DealServicesSvc");
    
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
@implementation DealServicesSoapBindingResponse
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

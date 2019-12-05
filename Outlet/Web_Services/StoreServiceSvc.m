#import "StoreServiceSvc.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif

#import "WebServiceUtility.h"

@implementation StoreServiceSvc_createLayout
- (id)init
{
    if((self = [super init])) {
        layoutDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.layoutDetails != 0) {
        xmlAddChild(node, [self.layoutDetails xmlNodeForDoc:node->doc elementName:@"layoutDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize layoutDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_createLayout *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_createLayout *newObject = [StoreServiceSvc_createLayout new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "layoutDetails")) {
                
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
                
                self.layoutDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_createLayoutResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_createLayoutResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_createLayoutResponse *newObject = [StoreServiceSvc_createLayoutResponse new];
    
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
@implementation StoreServiceSvc_createOutletSettings
- (id)init
{
    if((self = [super init])) {
        outletSettings = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.outletSettings != 0) {
        xmlAddChild(node, [self.outletSettings xmlNodeForDoc:node->doc elementName:@"outletSettings" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize outletSettings;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_createOutletSettings *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_createOutletSettings *newObject = [StoreServiceSvc_createOutletSettings new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "outletSettings")) {
                
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
                
                self.outletSettings = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_createOutletSettingsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_createOutletSettingsResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_createOutletSettingsResponse *newObject = [StoreServiceSvc_createOutletSettingsResponse new];
    
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
@implementation StoreServiceSvc_createStore
- (id)init
{
    if((self = [super init])) {
        storeDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.storeDetails != 0) {
        xmlAddChild(node, [self.storeDetails xmlNodeForDoc:node->doc elementName:@"storeDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize storeDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_createStore *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_createStore *newObject = [StoreServiceSvc_createStore new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "storeDetails")) {
                
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
                
                self.storeDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_createStoreResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_createStoreResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_createStoreResponse *newObject = [StoreServiceSvc_createStoreResponse new];
    
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
@implementation StoreServiceSvc_editLayout
- (id)init
{
    if((self = [super init])) {
        layoutDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.layoutDetails != 0) {
        xmlAddChild(node, [self.layoutDetails xmlNodeForDoc:node->doc elementName:@"layoutDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize layoutDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_editLayout *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_editLayout *newObject = [StoreServiceSvc_editLayout new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "layoutDetails")) {
                
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
                
                self.layoutDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_editLayoutResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_editLayoutResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_editLayoutResponse *newObject = [StoreServiceSvc_editLayoutResponse new];
    
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
@implementation StoreServiceSvc_getAllLayoutTables
- (id)init
{
    if((self = [super init])) {
        layoutDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.layoutDetails != 0) {
        xmlAddChild(node, [self.layoutDetails xmlNodeForDoc:node->doc elementName:@"layoutDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize layoutDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_getAllLayoutTables *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getAllLayoutTables *newObject = [StoreServiceSvc_getAllLayoutTables new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "layoutDetails")) {
                
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
                
                self.layoutDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_getAllLayoutTablesResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_getAllLayoutTablesResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getAllLayoutTablesResponse *newObject = [StoreServiceSvc_getAllLayoutTablesResponse new];
    
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
@implementation StoreServiceSvc_getAvailableLevels
- (id)init
{
    if((self = [super init])) {
        levelInfo = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.levelInfo != 0) {
        xmlAddChild(node, [self.levelInfo xmlNodeForDoc:node->doc elementName:@"levelInfo" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize levelInfo;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_getAvailableLevels *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getAvailableLevels *newObject = [StoreServiceSvc_getAvailableLevels new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "levelInfo")) {
                
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
                
                self.levelInfo = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_getAvailableLevelsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_getAvailableLevelsResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getAvailableLevelsResponse *newObject = [StoreServiceSvc_getAvailableLevelsResponse new];
    
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
@implementation StoreServiceSvc_getBillingCounters
- (id)init
{
    if((self = [super init])) {
        counterdetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.counterdetails != 0) {
        xmlAddChild(node, [self.counterdetails xmlNodeForDoc:node->doc elementName:@"counterdetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize counterdetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_getBillingCounters *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getBillingCounters *newObject = [StoreServiceSvc_getBillingCounters new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "counterdetails")) {
                
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
                
                self.counterdetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_getBillingCountersResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_getBillingCountersResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getBillingCountersResponse *newObject = [StoreServiceSvc_getBillingCountersResponse new];
    
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
@implementation StoreServiceSvc_getLayout
- (id)init
{
    if((self = [super init])) {
        layoutDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.layoutDetails != 0) {
        xmlAddChild(node, [self.layoutDetails xmlNodeForDoc:node->doc elementName:@"layoutDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize layoutDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_getLayout *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getLayout *newObject = [StoreServiceSvc_getLayout new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "layoutDetails")) {
                
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
                
                self.layoutDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_getLayoutResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_getLayoutResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getLayoutResponse *newObject = [StoreServiceSvc_getLayoutResponse new];
    
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
@implementation StoreServiceSvc_getStores
- (id)init
{
    if((self = [super init])) {
        layoutDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.layoutDetails != 0) {
        xmlAddChild(node, [self.layoutDetails xmlNodeForDoc:node->doc elementName:@"layoutDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize layoutDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_getStores *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getStores *newObject = [StoreServiceSvc_getStores new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "layoutDetails")) {
                
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
                
                self.layoutDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_getStoresResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_getStoresResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_getStoresResponse *newObject = [StoreServiceSvc_getStoresResponse new];
    
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
@implementation StoreServiceSvc_updateStore
- (id)init
{
    if((self = [super init])) {
        layoutDetails = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
    
    if(self.layoutDetails != 0) {
        xmlAddChild(node, [self.layoutDetails xmlNodeForDoc:node->doc elementName:@"layoutDetails" elementNSPrefix:@"StoreServiceSvc"]);
    }
}
/* elements */
@synthesize layoutDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StoreServiceSvc_updateStore *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_updateStore *newObject = [StoreServiceSvc_updateStore new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "layoutDetails")) {
                
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
                
                self.layoutDetails = newChild;
            }
        }
    }
}
@end
@implementation StoreServiceSvc_updateStoreResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}

- (NSString *)nsPrefix
{
    return @"StoreServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StoreServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StoreServiceSvc"]);
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
+ (StoreServiceSvc_updateStoreResponse *)deserializeNode:(xmlNodePtr)cur
{
    StoreServiceSvc_updateStoreResponse *newObject = [StoreServiceSvc_updateStoreResponse new];
    
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
@implementation StoreServiceSvc
+ (void)initialize
{
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"http://www.w3.org/2001/XMLSchema"] = @"xs";
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"www.technolabssoftware.com"] = @"StoreServiceSvc";
}
+ (StoreServiceSoapBinding *)StoreServiceSoapBinding
{
    //return [[[StoreServiceSoapBinding alloc] initWithAddress:@"http://10.10.0.90/OmniRetailerServices/storeService"] autorelease];
    NSString *url = [NSString stringWithFormat:@"%@%@", [WebServiceUtility getServiceURL],@"storeService"];
    return [[StoreServiceSoapBinding alloc] initWithAddress:url];

    
}
@end
@implementation StoreServiceSoapBinding
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
- (StoreServiceSoapBindingResponse *)performSynchronousOperation:(StoreServiceSoapBindingOperation *)operation
{
    synchronousOperationComplete = NO;
    [operation start];
    
    // Now wait for response
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    
    while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    return operation.response;
}
- (void)performAsynchronousOperation:(StoreServiceSoapBindingOperation *)operation
{
    [operation start];
}
- (void) operation:(StoreServiceSoapBindingOperation *)operation completedWithResponse:(StoreServiceSoapBindingResponse *)response
{
    synchronousOperationComplete = YES;
}
- (StoreServiceSoapBindingResponse *)createLayoutUsingParameters:(StoreServiceSvc_createLayout *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_createLayout*)[StoreServiceSoapBinding_createLayout alloc] initWithBinding:self delegate:self
                                                                                                                                       parameters:aParameters
                                              ]];
}
- (void)createLayoutAsyncUsingParameters:(StoreServiceSvc_createLayout *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_createLayout*)[StoreServiceSoapBinding_createLayout alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                  parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)createStoreUsingParameters:(StoreServiceSvc_createStore *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_createStore*)[StoreServiceSoapBinding_createStore alloc] initWithBinding:self delegate:self
                                                                                                                                     parameters:aParameters
                                              ]];
}
- (void)createStoreAsyncUsingParameters:(StoreServiceSvc_createStore *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_createStore*)[StoreServiceSoapBinding_createStore alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)getBillingCountersUsingParameters:(StoreServiceSvc_getBillingCounters *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_getBillingCounters*)[StoreServiceSoapBinding_getBillingCounters alloc] initWithBinding:self delegate:self
                                                                                                                                                   parameters:aParameters
                                              ]];
}
- (void)getBillingCountersAsyncUsingParameters:(StoreServiceSvc_getBillingCounters *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_getBillingCounters*)[StoreServiceSoapBinding_getBillingCounters alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                              parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)createOutletSettingsUsingParameters:(StoreServiceSvc_createOutletSettings *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_createOutletSettings*)[StoreServiceSoapBinding_createOutletSettings alloc] initWithBinding:self delegate:self
                                                                                                                                                       parameters:aParameters
                                              ]];
}
- (void)createOutletSettingsAsyncUsingParameters:(StoreServiceSvc_createOutletSettings *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_createOutletSettings*)[StoreServiceSoapBinding_createOutletSettings alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                                  parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)getAvailableLevelsUsingParameters:(StoreServiceSvc_getAvailableLevels *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_getAvailableLevels*)[StoreServiceSoapBinding_getAvailableLevels alloc] initWithBinding:self delegate:self
                                                                                                                                                   parameters:aParameters
                                              ]];
}
- (void)getAvailableLevelsAsyncUsingParameters:(StoreServiceSvc_getAvailableLevels *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_getAvailableLevels*)[StoreServiceSoapBinding_getAvailableLevels alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                              parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)getLayoutUsingParameters:(StoreServiceSvc_getLayout *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_getLayout*)[StoreServiceSoapBinding_getLayout alloc] initWithBinding:self delegate:self
                                                                                                                                 parameters:aParameters
                                              ]];
}
- (void)getLayoutAsyncUsingParameters:(StoreServiceSvc_getLayout *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_getLayout*)[StoreServiceSoapBinding_getLayout alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                            parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)getStoresUsingParameters:(StoreServiceSvc_getStores *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_getStores*)[StoreServiceSoapBinding_getStores alloc] initWithBinding:self delegate:self parameters:aParameters ]];
}
- (void)getStoresAsyncUsingParameters:(StoreServiceSvc_getStores *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_getStores*)[StoreServiceSoapBinding_getStores alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                            parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)updateStoreUsingParameters:(StoreServiceSvc_updateStore *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_updateStore*)[StoreServiceSoapBinding_updateStore alloc] initWithBinding:self delegate:self
                                                                                                                                     parameters:aParameters
                                              ]];
}
- (void)updateStoreAsyncUsingParameters:(StoreServiceSvc_updateStore *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_updateStore*)[StoreServiceSoapBinding_updateStore alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)getAllLayoutTablesUsingParameters:(StoreServiceSvc_getAllLayoutTables *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_getAllLayoutTables*)[StoreServiceSoapBinding_getAllLayoutTables alloc] initWithBinding:self delegate:self
                                                                                                                                                   parameters:aParameters
                                              ]];
}
- (void)getAllLayoutTablesAsyncUsingParameters:(StoreServiceSvc_getAllLayoutTables *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_getAllLayoutTables*)[StoreServiceSoapBinding_getAllLayoutTables alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                              parameters:aParameters
                                         ]];
}
- (StoreServiceSoapBindingResponse *)editLayoutUsingParameters:(StoreServiceSvc_editLayout *)aParameters 
{
    return [self performSynchronousOperation:[(StoreServiceSoapBinding_editLayout*)[StoreServiceSoapBinding_editLayout alloc] initWithBinding:self delegate:self
                                                                                                                                   parameters:aParameters
                                              ]];
}
- (void)editLayoutAsyncUsingParameters:(StoreServiceSvc_editLayout *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StoreServiceSoapBinding_editLayout*)[StoreServiceSoapBinding_editLayout alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                              parameters:aParameters
                                         ]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(StoreServiceSoapBindingOperation *)operation
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
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)bodyData.length] forHTTPHeaderField:@"Content-Length"];
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
@implementation StoreServiceSoapBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;

- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
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
        NSLog(@"ResponseStatus: %ld\n", (long)httpResponse.statusCode);
        NSLog(@"ResponseHeaders:\n%@", httpResponse.allHeaderFields);
    }
    
    NSMutableArray *cookies = [[NSHTTPCookie cookiesWithResponseHeaderFields:httpResponse.allHeaderFields forURL:binding.address] mutableCopy];
    
    binding.cookies = cookies;
 
    if ([urlResponse.MIMEType rangeOfString:@"text/xml"].length == 0) {
        NSError *error = nil;
        [connection cancel];
        if (httpResponse.statusCode >= 400) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]};
                
            error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseHTTP" code:httpResponse.statusCode userInfo:userInfo];
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]};
            error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseHTTP" code:1 userInfo:userInfo];
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

@end
@implementation StoreServiceSoapBinding_createLayout
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_createLayout *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createLayout"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createLayoutResponse")) {
                                    StoreServiceSvc_createLayoutResponse *bodyObject = [StoreServiceSvc_createLayoutResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_createStore
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_createStore *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createStore"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createStoreResponse")) {
                                    StoreServiceSvc_createStoreResponse *bodyObject = [StoreServiceSvc_createStoreResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_getBillingCounters
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_getBillingCounters *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getBillingCounters"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getBillingCountersResponse")) {
                                    StoreServiceSvc_getBillingCountersResponse *bodyObject = [StoreServiceSvc_getBillingCountersResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_createOutletSettings
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_createOutletSettings *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createOutletSettings"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createOutletSettingsResponse")) {
                                    StoreServiceSvc_createOutletSettingsResponse *bodyObject = [StoreServiceSvc_createOutletSettingsResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_getAvailableLevels
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_getAvailableLevels *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getAvailableLevels"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getAvailableLevelsResponse")) {
                                    StoreServiceSvc_getAvailableLevelsResponse *bodyObject = [StoreServiceSvc_getAvailableLevelsResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_getLayout
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_getLayout *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getLayout"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getLayoutResponse")) {
                                    StoreServiceSvc_getLayoutResponse *bodyObject = [StoreServiceSvc_getLayoutResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_getStores
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_getStores *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getStores"] = parameters;
    
    NSString * operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"StoreServiceSvc:layoutDetails" withString:@"layoutDetails"];
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getStoresResponse")) {
                                    StoreServiceSvc_getStoresResponse *bodyObject = [StoreServiceSvc_getStoresResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_updateStore
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_updateStore *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"updateStore"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "updateStoreResponse")) {
                                    StoreServiceSvc_updateStoreResponse *bodyObject = [StoreServiceSvc_updateStoreResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_getAllLayoutTables
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_getAllLayoutTables *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getAllLayoutTables"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getAllLayoutTablesResponse")) {
                                    StoreServiceSvc_getAllLayoutTablesResponse *bodyObject = [StoreServiceSvc_getAllLayoutTablesResponse deserializeNode:bodyNode];
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
@implementation StoreServiceSoapBinding_editLayout
@synthesize parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(StoreServiceSvc_editLayout *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}

- (void)main
{
    response = [StoreServiceSoapBindingResponse new];
    
    StoreServiceSoapBinding_envelope *envelope = [StoreServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"editLayout"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StoreServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "editLayoutResponse")) {
                                    StoreServiceSvc_editLayoutResponse *bodyObject = [StoreServiceSvc_editLayoutResponse deserializeNode:bodyNode];
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
static StoreServiceSoapBinding_envelope *StoreServiceSoapBindingSharedEnvelopeInstance = nil;
@implementation StoreServiceSoapBinding_envelope
+ (StoreServiceSoapBinding_envelope *)sharedInstance
{
    if(StoreServiceSoapBindingSharedEnvelopeInstance == nil) {
        StoreServiceSoapBindingSharedEnvelopeInstance = [StoreServiceSoapBinding_envelope new];
    }
    
    return StoreServiceSoapBindingSharedEnvelopeInstance;
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
    xmlNewNs(root, (const xmlChar*)"www.technolabssoftware.com", (const xmlChar*)"StoreServiceSvc");
    
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
@implementation StoreServiceSoapBindingResponse
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

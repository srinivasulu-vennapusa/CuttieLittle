#import "StockIssueServiceSvc.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation StockIssueServiceSvc_createStockIssue
- (id)init
{
    if((self = [super init])) {
        stockIssueDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
    
    if(self.stockIssueDetails != 0) {
        xmlAddChild(node, [self.stockIssueDetails xmlNodeForDoc:node->doc elementName:@"stockIssueDetails" elementNSPrefix:@"StockIssueServiceSvc"]);
    }
}
/* elements */
@synthesize stockIssueDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StockIssueServiceSvc_createStockIssue *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_createStockIssue *newObject = [StockIssueServiceSvc_createStockIssue new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "stockIssueDetails")) {
                
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
                
                self.stockIssueDetails = newChild;
            }
        }
    }
}
@end
@implementation StockIssueServiceSvc_createStockIssueResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_createStockIssueResponse *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_createStockIssueResponse *newObject = [StockIssueServiceSvc_createStockIssueResponse new];
    
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
@implementation StockIssueServiceSvc_getStockIssue
- (id)init
{
    if((self = [super init])) {
        issueID = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
    
    if(self.issueID != 0) {
        xmlAddChild(node, [self.issueID xmlNodeForDoc:node->doc elementName:@"issueID" elementNSPrefix:@"StockIssueServiceSvc"]);
    }
}
/* elements */
@synthesize issueID;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StockIssueServiceSvc_getStockIssue *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_getStockIssue *newObject = [StockIssueServiceSvc_getStockIssue new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "issueID")) {
                
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
                
                self.issueID = newChild;
            }
        }
    }
}
@end
@implementation StockIssueServiceSvc_getStockIssueIds
- (id)init
{
    if((self = [super init])) {
        searchCriteria = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.searchCriteria xmlNodeForDoc:node->doc elementName:@"searchCriteria" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_getStockIssueIds *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_getStockIssueIds *newObject = [StockIssueServiceSvc_getStockIssueIds new];
    
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
@implementation StockIssueServiceSvc_getStockIssueIdsResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_getStockIssueIdsResponse *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_getStockIssueIdsResponse *newObject = [StockIssueServiceSvc_getStockIssueIdsResponse new];
    
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
@implementation StockIssueServiceSvc_getStockIssueResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_getStockIssueResponse *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_getStockIssueResponse *newObject = [StockIssueServiceSvc_getStockIssueResponse new];
    
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
@implementation StockIssueServiceSvc_getStockIssues
- (id)init
{
    if((self = [super init])) {
        searchCriteria = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.searchCriteria xmlNodeForDoc:node->doc elementName:@"searchCriteria" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_getStockIssues *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_getStockIssues *newObject = [StockIssueServiceSvc_getStockIssues new];
    
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
@implementation StockIssueServiceSvc_getStockIssuesResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_getStockIssuesResponse *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_getStockIssuesResponse *newObject = [StockIssueServiceSvc_getStockIssuesResponse new];
    
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
@implementation StockIssueServiceSvc_helloworld
- (id)init
{
    if((self = [super init])) {
        testString = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
    
    if(self.testString != 0) {
        xmlAddChild(node, [self.testString xmlNodeForDoc:node->doc elementName:@"testString" elementNSPrefix:@"StockIssueServiceSvc"]);
    }
}
/* elements */
@synthesize testString;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StockIssueServiceSvc_helloworld *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_helloworld *newObject = [StockIssueServiceSvc_helloworld new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "testString")) {
                
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
                
                self.testString = newChild;
            }
        }
    }
}
@end
@implementation StockIssueServiceSvc_helloworldResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_helloworldResponse *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_helloworldResponse *newObject = [StockIssueServiceSvc_helloworldResponse new];
    
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
@implementation StockIssueServiceSvc_updateStockIssue
- (id)init
{
    if((self = [super init])) {
        stockIssueDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
    
    if(self.stockIssueDetails != 0) {
        xmlAddChild(node, [self.stockIssueDetails xmlNodeForDoc:node->doc elementName:@"stockIssueDetails" elementNSPrefix:@"StockIssueServiceSvc"]);
    }
}
/* elements */
@synthesize stockIssueDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (StockIssueServiceSvc_updateStockIssue *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_updateStockIssue *newObject = [StockIssueServiceSvc_updateStockIssue new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "stockIssueDetails")) {
                
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
                
                self.stockIssueDetails = newChild;
            }
        }
    }
}
@end
@implementation StockIssueServiceSvc_updateStockIssueResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"StockIssueServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"StockIssueServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"StockIssueServiceSvc"]);
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
+ (StockIssueServiceSvc_updateStockIssueResponse *)deserializeNode:(xmlNodePtr)cur
{
    StockIssueServiceSvc_updateStockIssueResponse *newObject = [StockIssueServiceSvc_updateStockIssueResponse new];
    
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
@implementation StockIssueServiceSvc
+ (void)initialize
{
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"http://www.w3.org/2001/XMLSchema"] = @"xs";
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"www.technolabssoftware.com"] = @"StockIssueServiceSvc";
}
+ (StockIssueServiceSoapBinding *)StockIssueServiceSoapBinding
{
    //    return [[[StockIssueServiceSoapBinding alloc] initWithAddress:@"http://10.10.0.2:8080/OmniRetailerServices/StockIssueServices"] autorelease];
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://",host_name,@":",port_no,@"/OmniRetailerServices/StockIssueService"];
    return [[StockIssueServiceSoapBinding alloc] initWithAddress:url];
}
@end
@implementation StockIssueServiceSoapBinding
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
- (StockIssueServiceSoapBindingResponse *)performSynchronousOperation:(StockIssueServiceSoapBindingOperation *)operation
{
    synchronousOperationComplete = NO;
    [operation start];
    
    // Now wait for response
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    
    while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    return operation.response;
}
- (void)performAsynchronousOperation:(StockIssueServiceSoapBindingOperation *)operation
{
    [operation start];
}
- (void) operation:(StockIssueServiceSoapBindingOperation *)operation completedWithResponse:(StockIssueServiceSoapBindingResponse *)response
{
    synchronousOperationComplete = YES;
}
- (StockIssueServiceSoapBindingResponse *)getStockIssueIdsUsingParameters:(StockIssueServiceSvc_getStockIssueIds *)aParameters
{
    return [self performSynchronousOperation:[(StockIssueServiceSoapBinding_getStockIssueIds*)[StockIssueServiceSoapBinding_getStockIssueIds alloc] initWithBinding:self delegate:self
                                                                                                                                                          parameters:aParameters
                                               ]];
}
- (void)getStockIssueIdsAsyncUsingParameters:(StockIssueServiceSvc_getStockIssueIds *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StockIssueServiceSoapBinding_getStockIssueIds*)[StockIssueServiceSoapBinding_getStockIssueIds alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                                     parameters:aParameters
                                          ]];
}
- (StockIssueServiceSoapBindingResponse *)getStockIssueUsingParameters:(StockIssueServiceSvc_getStockIssue *)aParameters
{
    return [self performSynchronousOperation:[(StockIssueServiceSoapBinding_getStockIssue*)[StockIssueServiceSoapBinding_getStockIssue alloc] initWithBinding:self delegate:self
                                                                                                                                                    parameters:aParameters
                                               ]];
}
- (void)getStockIssueAsyncUsingParameters:(StockIssueServiceSvc_getStockIssue *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StockIssueServiceSoapBinding_getStockIssue*)[StockIssueServiceSoapBinding_getStockIssue alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                               parameters:aParameters
                                          ]];
}
- (StockIssueServiceSoapBindingResponse *)updateStockIssueUsingParameters:(StockIssueServiceSvc_updateStockIssue *)aParameters
{
    return [self performSynchronousOperation:[(StockIssueServiceSoapBinding_updateStockIssue*)[StockIssueServiceSoapBinding_updateStockIssue alloc] initWithBinding:self delegate:self
                                                                                                                                                          parameters:aParameters
                                               ]];
}
- (void)updateStockIssueAsyncUsingParameters:(StockIssueServiceSvc_updateStockIssue *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StockIssueServiceSoapBinding_updateStockIssue*)[StockIssueServiceSoapBinding_updateStockIssue alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                                     parameters:aParameters
                                          ]];
}
- (StockIssueServiceSoapBindingResponse *)helloworldUsingParameters:(StockIssueServiceSvc_helloworld *)aParameters
{
    return [self performSynchronousOperation:[(StockIssueServiceSoapBinding_helloworld*)[StockIssueServiceSoapBinding_helloworld alloc] initWithBinding:self delegate:self
                                                                                                                                              parameters:aParameters
                                               ]];
}
- (void)helloworldAsyncUsingParameters:(StockIssueServiceSvc_helloworld *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StockIssueServiceSoapBinding_helloworld*)[StockIssueServiceSoapBinding_helloworld alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                         parameters:aParameters
                                          ]];
}
- (StockIssueServiceSoapBindingResponse *)createStockIssueUsingParameters:(StockIssueServiceSvc_createStockIssue *)aParameters
{
    return [self performSynchronousOperation:[(StockIssueServiceSoapBinding_createStockIssue*)[StockIssueServiceSoapBinding_createStockIssue alloc] initWithBinding:self delegate:self
                                                                                                                                                          parameters:aParameters
                                               ]];
}
- (void)createStockIssueAsyncUsingParameters:(StockIssueServiceSvc_createStockIssue *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StockIssueServiceSoapBinding_createStockIssue*)[StockIssueServiceSoapBinding_createStockIssue alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                                     parameters:aParameters
                                          ]];
}
- (StockIssueServiceSoapBindingResponse *)getStockIssuesUsingParameters:(StockIssueServiceSvc_getStockIssues *)aParameters
{
    return [self performSynchronousOperation:[(StockIssueServiceSoapBinding_getStockIssues*)[StockIssueServiceSoapBinding_getStockIssues alloc] initWithBinding:self delegate:self
                                                                                                                                                      parameters:aParameters
                                               ]];
}
- (void)getStockIssuesAsyncUsingParameters:(StockIssueServiceSvc_getStockIssues *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(StockIssueServiceSoapBinding_getStockIssues*)[StockIssueServiceSoapBinding_getStockIssues alloc] initWithBinding:self delegate:responseDelegate
                                                                                                                                                 parameters:aParameters
                                          ]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(StockIssueServiceSoapBindingOperation *)operation
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
@implementation StockIssueServiceSoapBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
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
            
            error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseHTTP" code:httpResponse.statusCode userInfo:userInfo];
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]};
            error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseHTTP" code:1 userInfo:userInfo];
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
@implementation StockIssueServiceSoapBinding_getStockIssueIds
@synthesize parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
           parameters:(StockIssueServiceSvc_getStockIssueIds *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StockIssueServiceSoapBindingResponse new];
    
    StockIssueServiceSoapBinding_envelope *envelope = [StockIssueServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getStockIssueIds"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"StockIssueServiceSvc:searchCriteria" withString:@"searchCriteria"];
    
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
            
            response.error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getStockIssueIdsResponse")) {
                                    StockIssueServiceSvc_getStockIssueIdsResponse *bodyObject = [StockIssueServiceSvc_getStockIssueIdsResponse deserializeNode:bodyNode];
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
@implementation StockIssueServiceSoapBinding_getStockIssue
@synthesize parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
           parameters:(StockIssueServiceSvc_getStockIssue *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StockIssueServiceSoapBindingResponse new];
    
    StockIssueServiceSoapBinding_envelope *envelope = [StockIssueServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getStockIssue"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"StockIssueServiceSvc:issueID" withString:@"issueID"];
    
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
            
            response.error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getStockIssueResponse")) {
                                    StockIssueServiceSvc_getStockIssueResponse *bodyObject = [StockIssueServiceSvc_getStockIssueResponse deserializeNode:bodyNode];
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
@implementation StockIssueServiceSoapBinding_updateStockIssue
@synthesize parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
           parameters:(StockIssueServiceSvc_updateStockIssue *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StockIssueServiceSoapBindingResponse new];
    
    StockIssueServiceSoapBinding_envelope *envelope = [StockIssueServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"updateStockIssue"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"StockIssueServiceSvc:stockIssueDetails" withString:@"stockIssueDetails"];
    
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
            
            response.error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "updateStockIssueResponse")) {
                                    StockIssueServiceSvc_updateStockIssueResponse *bodyObject = [StockIssueServiceSvc_updateStockIssueResponse deserializeNode:bodyNode];
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
@implementation StockIssueServiceSoapBinding_helloworld
@synthesize parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
           parameters:(StockIssueServiceSvc_helloworld *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StockIssueServiceSoapBindingResponse new];
    
    StockIssueServiceSoapBinding_envelope *envelope = [StockIssueServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"helloworld"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "helloworldResponse")) {
                                    StockIssueServiceSvc_helloworldResponse *bodyObject = [StockIssueServiceSvc_helloworldResponse deserializeNode:bodyNode];
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
@implementation StockIssueServiceSoapBinding_createStockIssue
@synthesize parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
           parameters:(StockIssueServiceSvc_createStockIssue *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StockIssueServiceSoapBindingResponse new];
    
    StockIssueServiceSoapBinding_envelope *envelope = [StockIssueServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createStockIssue"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"StockIssueServiceSvc:stockIssueDetails" withString:@"stockIssueDetails"];
    
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
            
            response.error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createStockIssueResponse")) {
                                    StockIssueServiceSvc_createStockIssueResponse *bodyObject = [StockIssueServiceSvc_createStockIssueResponse deserializeNode:bodyNode];
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
@implementation StockIssueServiceSoapBinding_getStockIssues
@synthesize parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate
           parameters:(StockIssueServiceSvc_getStockIssues *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [StockIssueServiceSoapBindingResponse new];
    
    StockIssueServiceSoapBinding_envelope *envelope = [StockIssueServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"getStockIssues"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"StockIssueServiceSvc:searchCriteria" withString:@"searchCriteria"];
    
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
            
            response.error = [NSError errorWithDomain:@"StockIssueServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getStockIssuesResponse")) {
                                    StockIssueServiceSvc_getStockIssuesResponse *bodyObject = [StockIssueServiceSvc_getStockIssuesResponse deserializeNode:bodyNode];
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
static StockIssueServiceSoapBinding_envelope *StockIssueServiceSoapBindingSharedEnvelopeInstance = nil;
@implementation StockIssueServiceSoapBinding_envelope
+ (StockIssueServiceSoapBinding_envelope *)sharedInstance
{
    if(StockIssueServiceSoapBindingSharedEnvelopeInstance == nil) {
        StockIssueServiceSoapBindingSharedEnvelopeInstance = [StockIssueServiceSoapBinding_envelope new];
    }
    
    return StockIssueServiceSoapBindingSharedEnvelopeInstance;
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
    xmlNewNs(root, (const xmlChar*)"www.technolabssoftware.com", (const xmlChar*)"StockIssueServiceSvc");
    
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
@implementation StockIssueServiceSoapBindingResponse
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

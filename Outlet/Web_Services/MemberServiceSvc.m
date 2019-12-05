#import "MemberServiceSvc.h"
#import <libxml/xmlstring.h>
#import <sqlite3.h>
#import "LoginServiceSvc.h"
#import "Global.h"
#import "WebServiceUtility.h"
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif

//added by Srinivasulu on 20/10/2017....

#import "WebServiceConstants.h"

//upto here on 10/10/2017....

@implementation MemberServiceSvc_authenticateUser
- (id)init
{
    if((self = [super init])) {
        loginDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"MemberServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"MemberServiceSvc", elName];
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
    
    if(self.loginDetails != 0) {
        xmlAddChild(node, [self.loginDetails xmlNodeForDoc:node->doc elementName:@"loginDetails" elementNSPrefix:@"MemberServiceSvc"]);
    }
}
/* elements */
@synthesize loginDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (MemberServiceSvc_authenticateUser *)deserializeNode:(xmlNodePtr)cur
{
    MemberServiceSvc_authenticateUser *newObject = [MemberServiceSvc_authenticateUser new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "loginDetails")) {
                
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
                
                self.loginDetails = newChild;
            }
        }
    }
}
@end
@implementation MemberServiceSvc_authenticateUserResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"MemberServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"MemberServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"MemberServiceSvc"]);
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
+ (MemberServiceSvc_authenticateUserResponse *)deserializeNode:(xmlNodePtr)cur
{
    MemberServiceSvc_authenticateUserResponse *newObject = [MemberServiceSvc_authenticateUserResponse new];
    
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
@implementation MemberServiceSvc_changePassword
- (id)init
{
    if((self = [super init])) {
        arg0 = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"MemberServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"MemberServiceSvc", elName];
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
    
    if(self.arg0 != 0) {
        xmlAddChild(node, [self.arg0 xmlNodeForDoc:node->doc elementName:@"arg0" elementNSPrefix:@"MemberServiceSvc"]);
    }
}
/* elements */
@synthesize arg0;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (MemberServiceSvc_changePassword *)deserializeNode:(xmlNodePtr)cur
{
    MemberServiceSvc_changePassword *newObject = [MemberServiceSvc_changePassword new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "arg0")) {
                
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
                
                self.arg0 = newChild;
            }
        }
    }
}
@end
@implementation MemberServiceSvc_changePasswordResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"MemberServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"MemberServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"MemberServiceSvc"]);
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
+ (MemberServiceSvc_changePasswordResponse *)deserializeNode:(xmlNodePtr)cur
{
    MemberServiceSvc_changePasswordResponse *newObject = [MemberServiceSvc_changePasswordResponse new];
    
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
@implementation MemberServiceSvc_createMember
- (id)init
{
    if((self = [super init])) {
        memberDetails = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"MemberServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"MemberServiceSvc", elName];
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
    
    if(self.memberDetails != 0) {
        xmlAddChild(node, [self.memberDetails xmlNodeForDoc:node->doc elementName:@"memberDetails" elementNSPrefix:@"MemberServiceSvc"]);
    }
}
/* elements */
@synthesize memberDetails;
/* attributes */
- (NSDictionary *)attributes
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    return attributes;
}
+ (MemberServiceSvc_createMember *)deserializeNode:(xmlNodePtr)cur
{
    MemberServiceSvc_createMember *newObject = [MemberServiceSvc_createMember new];
    
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
            if(xmlStrEqual(cur->name, (const xmlChar *) "memberDetails")) {
                
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
                
                self.memberDetails = newChild;
            }
        }
    }
}
@end
@implementation MemberServiceSvc_createMemberResponse
- (id)init
{
    if((self = [super init])) {
        return_ = 0;
    }
    
    return self;
}
- (NSString *)nsPrefix
{
    return @"MemberServiceSvc";
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
        nodeName = [NSString stringWithFormat:@"%@:%@", @"MemberServiceSvc", elName];
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
        xmlAddChild(node, [self.return_ xmlNodeForDoc:node->doc elementName:@"return" elementNSPrefix:@"MemberServiceSvc"]);
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
+ (MemberServiceSvc_createMemberResponse *)deserializeNode:(xmlNodePtr)cur
{
    MemberServiceSvc_createMemberResponse *newObject = [MemberServiceSvc_createMemberResponse new];
    
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
@implementation MemberServiceSvc

static sqlite3 *database = nil;
static sqlite3_stmt *selectStmt = nil;

+ (void)initialize
{
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"http://www.w3.org/2001/XMLSchema"] = @"xs";
    ([USGlobals sharedInstance].wsdlStandardNamespaces)[@"www.technolabssoftware.com"] = @"MemberServiceSvc";
}

- (NSString *) getDBPath {
    
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSString* databaseName = @"RetailerConfigDataBase.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = documentPaths[0];
    NSString* databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    return databasePath;
    
}

- (void) loadDbpath {
    
    NSString *domainText = NULL;
    NSString *portNumber = NULL;
    
    //Get data from database
    // getting the present value's from database ..
    
    NSString* dbPath = [self getDBPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *databasePathFromApp = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"RetailerConfigDataBase.sqlite"];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
    
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        const char *sqlStatement = "select * from ServiceCredentials";
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                
                domainText = @((char *)sqlite3_column_text(selectStmt, 0));
                portNumber = @((char *)sqlite3_column_text(selectStmt, 1));
            }
            sqlite3_finalize(selectStmt);
        }
    }
    
    selectStmt = nil;
    sqlite3_close(database);
    // setting the gloable variables for domain and port number
    // changed by saradhi on 5-12-12 ..
    host_name = [domainText copy];
    port_no   = [portNumber copy];
    
}


+ (MemberServiceSoapBinding *)MemberServiceSoapBinding
{
    //return [[[MemberServiceSoapBinding alloc] initWithAddress:@"http://10.10.0.79:8080/OmniRetailerServices/memberServices"] autorelease];
    MemberServiceSvc *login = [[MemberServiceSvc alloc] init];
    [login loadDbpath];
    if(host_name != NULL && port_no!= NULL )
    {
        NSString *url = [NSString stringWithFormat:@"%@%@", [WebServiceUtility getServiceURL],@"memberServices"];
        return [[MemberServiceSoapBinding alloc] initWithAddress:url];
    }
    else{
      
        //changed by Srinivasulu on 20/10/2017....
        
        host_name = IP_ADDRESS;
        port_no = IP_PORT_NUMBER;
        
        //upto here on 10/10/2017....
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[WebServiceUtility getServiceURL],@"memberServices"];
    return [[MemberServiceSoapBinding alloc] initWithAddress:url];
    }
    
}
@end
@implementation MemberServiceSoapBinding
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
- (MemberServiceSoapBindingResponse *)performSynchronousOperation:(MemberServiceSoapBindingOperation *)operation
{
    synchronousOperationComplete = NO;
    [operation start];
    
    // Now wait for response
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    
    while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    return operation.response;
}
- (void)performAsynchronousOperation:(MemberServiceSoapBindingOperation *)operation
{
    [operation start];
}
- (void) operation:(MemberServiceSoapBindingOperation *)operation completedWithResponse:(MemberServiceSoapBindingResponse *)response
{
    synchronousOperationComplete = YES;
}
- (MemberServiceSoapBindingResponse *)createMemberUsingParameters:(MemberServiceSvc_createMember *)aParameters 
{
    return [self performSynchronousOperation:[(MemberServiceSoapBinding_createMember*)[MemberServiceSoapBinding_createMember alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)createMemberAsyncUsingParameters:(MemberServiceSvc_createMember *)aParameters  delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(MemberServiceSoapBinding_createMember*)[MemberServiceSoapBinding_createMember alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (MemberServiceSoapBindingResponse *)authenticateUserUsingParameters:(MemberServiceSvc_authenticateUser *)aParameters 
{
    return [self performSynchronousOperation:[(MemberServiceSoapBinding_authenticateUser*)[MemberServiceSoapBinding_authenticateUser alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)authenticateUserAsyncUsingParameters:(MemberServiceSvc_authenticateUser *)aParameters  delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(MemberServiceSoapBinding_authenticateUser*)[MemberServiceSoapBinding_authenticateUser alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (MemberServiceSoapBindingResponse *)changePasswordUsingParameters:(MemberServiceSvc_changePassword *)aParameters 
{
    return [self performSynchronousOperation:[(MemberServiceSoapBinding_changePassword*)[MemberServiceSoapBinding_changePassword alloc] initWithBinding:self delegate:self
                                                                                            parameters:aParameters
                                                                                            ]];
}
- (void)changePasswordAsyncUsingParameters:(MemberServiceSvc_changePassword *)aParameters  delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate
{
    [self performAsynchronousOperation: [(MemberServiceSoapBinding_changePassword*)[MemberServiceSoapBinding_changePassword alloc] initWithBinding:self delegate:responseDelegate
                                                                                             parameters:aParameters
                                                                                             ]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(MemberServiceSoapBindingOperation *)operation
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:self.address  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                                                                         timeoutInterval:self.defaultTimeout];
    
    NSURLConnection * connection1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSData *bodyData = [outputBody dataUsingEncoding:NSUTF8StringEncoding];
    
    if(cookies != nil) {
        request.allHTTPHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    }
    [request setValue:@"wsdl2objc" forHTTPHeaderField:@"User-Agent"];
    [request setValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", bodyData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:self.address.host forHTTPHeaderField:@"Host"];
    request.HTTPMethod = @"POST";
    // set version 1.1 - how?
    request.HTTPBody = bodyData;
        
    if(self.logXMLInOut) {
        NSLog(@"OutputHeaders:\n%@", request.allHTTPHeaderFields);
        NSLog(@"OutputBody:\n%@", outputBody);
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:operation];
//    NSURLConnection * connection1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    operation.urlConnection = connection;
}

//added by Srinivasulu on 30/08/2018.. reason inorder to access the https service call also....
-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {

    if ([[challenge protectionSpace] authenticationMethod] == NSURLAuthenticationMethodServerTrust) {

        [[challenge sender] useCredential:[NSURLCredential credentialForTrust:[[challenge protectionSpace] serverTrust]] forAuthenticationChallenge:challenge];
    }
}

@end
@implementation MemberServiceSoapBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)aDelegate
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
                
            error = [NSError errorWithDomain:@"MemberServiceSoapBindingResponseHTTP" code:httpResponse.statusCode userInfo:userInfo];
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType]};
            error = [NSError errorWithDomain:@"MemberServiceSoapBindingResponseHTTP" code:1 userInfo:userInfo];
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
@implementation MemberServiceSoapBinding_createMember
@synthesize parameters;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(MemberServiceSvc_createMember *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [MemberServiceSoapBindingResponse new];
    
    MemberServiceSoapBinding_envelope *envelope = [MemberServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"createMember"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"MemberServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "createMemberResponse")) {
                                    MemberServiceSvc_createMemberResponse *bodyObject = [MemberServiceSvc_createMemberResponse deserializeNode:bodyNode];
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
@implementation MemberServiceSoapBinding_authenticateUser
@synthesize parameters;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(MemberServiceSvc_authenticateUser *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [MemberServiceSoapBindingResponse new];
    
    MemberServiceSoapBinding_envelope *envelope = [MemberServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"authenticateUser"] = parameters;
    
    NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
    operationXMLString = [operationXMLString stringByReplacingOccurrencesOfString:@"MemberServiceSvc:loginDetails" withString:@"loginDetails"];
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
            
            response.error = [NSError errorWithDomain:@"MemberServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "authenticateUserResponse")) {
                                    MemberServiceSvc_authenticateUserResponse *bodyObject = [MemberServiceSvc_authenticateUserResponse deserializeNode:bodyNode];
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
@implementation MemberServiceSoapBinding_changePassword
@synthesize parameters;
- (id)initWithBinding:(MemberServiceSoapBinding *)aBinding delegate:(id<MemberServiceSoapBindingResponseDelegate>)responseDelegate
parameters:(MemberServiceSvc_changePassword *)aParameters
{
    if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
        self.parameters = aParameters;
    }
    
    return self;
}
- (void)main
{
    response = [MemberServiceSoapBindingResponse new];
    
    MemberServiceSoapBinding_envelope *envelope = [MemberServiceSoapBinding_envelope sharedInstance];
    
    NSMutableDictionary *headerElements = nil;
    headerElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *bodyElements = nil;
    bodyElements = [NSMutableDictionary dictionary];
    if(parameters != nil) bodyElements[@"changePassword"] = parameters;
    
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
            
            response.error = [NSError errorWithDomain:@"MemberServiceSoapBindingResponseXML" code:1 userInfo:userInfo];
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
                                if(xmlStrEqual(bodyNode->name, (const xmlChar *) "changePasswordResponse")) {
                                    MemberServiceSvc_changePasswordResponse *bodyObject = [MemberServiceSvc_changePasswordResponse deserializeNode:bodyNode];
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
static MemberServiceSoapBinding_envelope *MemberServiceSoapBindingSharedEnvelopeInstance = nil;
@implementation MemberServiceSoapBinding_envelope
+ (MemberServiceSoapBinding_envelope *)sharedInstance
{
    if(MemberServiceSoapBindingSharedEnvelopeInstance == nil) {
        MemberServiceSoapBindingSharedEnvelopeInstance = [MemberServiceSoapBinding_envelope new];
    }
    
    return MemberServiceSoapBindingSharedEnvelopeInstance;
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
    xmlNewNs(root, (const xmlChar*)"www.technolabssoftware.com", (const xmlChar*)"MemberServiceSvc");
    
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
@implementation MemberServiceSoapBindingResponse
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

#import "NRAbstractParser.h"
#import "AppDelegate.h"

@implementation NRAbstractParser
{
    AppDelegate* App;
    NSMutableString* m_ElementValue;
}

- (void)Initialize{}

#pragma mark - Init

-(id)init
{
    self = [super init];
    
    if (self)
    {
        //[self Initialize];
        
    }
    return self;
}


#pragma mark - Parse data

//- (void)ParseData:(NSData *)Data Manager:(IMAbstractManager*) ObjectManagerInstance
- (void) ParseData:(NSData*) Data Feed:(NRFeed*)Feed
{
    App = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    ExistingFeed = Feed;
    if (Data && !Parser && !Error)
    {
        ReceivedData = Data;
        Parser = [[NSXMLParser alloc] initWithData:Data];
        Items = [NSMutableArray new];
        
        [Parser setDelegate:self];
        [Parser setShouldProcessNamespaces:NO];
        [Parser setShouldReportNamespacePrefixes:NO];
        [Parser setShouldResolveExternalEntities:NO];
        
        
        //[ObjectManager ClearAll];
        [Parser parse];

    }
    else
    {
        Error = [NSError errorWithDomain:@"No data" code:0 userInfo:nil];
    }
}

#pragma mark - NSXMLParserDelegate


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)String
{
    if (String != nil)
    {
        [m_ElementValue appendString:String];
    }
    else
    {
        Error = [NSError errorWithDomain:@"Parsing error! Appending nil value." code:-1 userInfo:nil];
        NSLog(@"Parsing error! Appending nil value.");
        [App ErrorInvalidData];
        [parser abortParsing];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    Error = parseError;
    [App ErrorInvalidData];
    NSLog(@"%@", [NSString stringWithFormat:@"Parsing error code %i, %@, at line: %i, column: %i", [parseError code], [[parser parserError] localizedDescription], [parser lineNumber], [parser columnNumber]]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    m_ElementValue = [[NSMutableString alloc] init];
    //m_ElementValue = nil;
    ElementName = [NSString stringWithString:elementName];
    AttributesDict = attributeDict;
    
    [self DidStartElement];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    ElementName = [NSString stringWithString:elementName];
    ElementValue = [[NSString stringWithString:m_ElementValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   // ElementValue = m_ElementValue;
    [self DidEndElement];
}


- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    m_ElementValue = [[NSMutableString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self performSelectorOnMainThread:@selector(NotifyDelegate) withObject:nil waitUntilDone:YES];
    [self DidEndDocument];
    
}

- (void) NotifyDelegate
{
    [self.ParserResponderDelegate ParserSucceded];
}


#pragma mark - Methods to override in subclass



- (void)DidStartElement{}

- (void)DidEndElement{}

- (void)DidEndDocument{}

#pragma mark - Setters


- (void)SetUserInfo:(id)userInfo
{
    UserInfo = userInfo;
}

#pragma mark - Getters


- (NSString *)GetDateFormat
{
    return @"yyyy-MM-dd";
}


- (NSString *)GetDateTimeFormat
{
    return @"yyyy-MM-dd hh:mm:ss Z";
}


- (NSArray *)GetItemsArray
{
    return [NSArray arrayWithArray:Items];
}


- (NSError *)GetError
{
    return Error;
}

#pragma mark - abort


- (void)AbortParsing
{
    [Parser setDelegate:nil];
    [Parser abortParsing];
    Parser = nil;
    Error = [NSError errorWithDomain:@"Parsing aborted." code:299 userInfo:nil];
}


@end
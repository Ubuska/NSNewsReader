// This parser is meant to be subclassed.
// It handles logic for NSXMLParser so we don't have to mess with
// it all the time.
// Also we have here some handy defines.

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "NRFeed.h"

#define IfElement(str)    if ([ElementName isEqualToString:str])
#define ElseIfElement(str)  else if ([ElementName isEqualToString:str])
#define BindStr(obj)      obj = ElementValue
#define BindNumber(obj)       obj = [NSNumber numberWithDouble:[ElementValue doubleValue]]
#define BindDate(obj)     obj = [DateFormatter dateFromString:ElementValue]
#define BindDateTime(obj) obj = [DateTimeFormatter dateFromString:ElementValue]
#define BindNumberAsInt(obj)    obj = [NSNumber numberWithInteger:[ElementValue integerValue]]
#define BindNumberAsBool(obj)   obj = [NSNumber numberWithBool:[ElementValue boolValue]]
#define BindInt(obj)      obj = [ElementValue intValue]
#define BindFloat(obj)    obj = [ElementValue floatValue]
#define BindDouble(obj)   obj = [ElementValue doubleValue]


@interface NRAbstractParser : NSObject <NSXMLParserDelegate>
{
    NSDictionary *AttributesDict;
    NSString *ElementValue;
    NSString *ElementName;
    NSXMLParser *Parser;
    NSMutableArray *Items;
    NSError *Error;
    NSDateFormatter *DateTimeFormatter;
    NSDateFormatter *DateFormatter;
    NSData* ReceivedData;
    
    NRFeed* ExistingFeed;
    id UserInfo;
}
@property id<ParserResponder> ParserResponderDelegate;

@end

#pragma mark - Protected

@interface NRAbstractParser ()
- (void) ParseData:(NSData*) Data Feed:(NRFeed*)Feed;
- (void)AbortParsing;

- (void)Initialize;

- (void)DidStartElement;
- (void)DidEndElement;
- (void)DidEndDocument;

- (NSString *)GetDateTimeFormat;
- (NSString *)GetDateFormat;


@end

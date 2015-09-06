//
// This class holdes NRFeedItem objects and some Feed info.
//
#import <Foundation/Foundation.h>
#import "NRFeedItem.h"

@interface NRFeed : NSObject <NSCoding>
{
    NSMutableArray* FeedItems;
    NSString* Identifier;
}

@property (getter=GetTitle, setter=SetTitle:) NSString* Title;
@property (getter=GetLink, setter=SetLink:) NSString* Link;
@property (getter=GetSummary, setter=SetSummary:) NSString* Summary;
@property (getter=GetType, setter=SetType:) NSString* Type;

// Mutators
- (void) AddFeedItem:(NRFeedItem*)FeedItem;
- (void) ClearAll;

// Accessors
- (NSUInteger) GetItemsNumber;
- (NRFeedItem*) GetFeedItemByIndex:(NSUInteger)Index;

@end

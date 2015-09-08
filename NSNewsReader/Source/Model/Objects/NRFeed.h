//
// This class holdes NRFeedItem objects and some Feed info.
//
#import <Foundation/Foundation.h>
#import "NRFeedItem.h"


typedef enum
{
    EST_Ascending,
    EST_Descending
} ESortingType;

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

// Public function for sorting by publication date.
- (void) SortItemsByDate;

// Accessors
- (NSUInteger) GetItemsNumber;
- (NRFeedItem*) GetFeedItemByIndex:(NSUInteger)Index;

@end

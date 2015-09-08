
// Main class in Model. Singleton.
// Handles all NRFeed and NRFeedItem objects.
// All classes accesses NRFeed or NRFeedItem object only through this Manager.

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "NRFeed.h"


// Handy macro for accesing singleton.
#define FeedManager [NRFeedManager SharedInstance]

@interface NRFeedManager : NSObject <ValidatorResponder, ParserResponder, NSURLSessionDownloadDelegate, NSURLSessionDelegate, NSCoding>
{
    NSMutableArray* Feeds;
    NSMutableArray* FavoriteFeeds;
}

@property id<UpdateView> UpdateViewDelegate;
@property id<DownloadProgressHandler> ProgressHandlerDelegate;
@property(getter=IsFavoritesOnly, setter=SetFavoritesOnly:) BOOL bShowFavoriteOnly;

+ (NRFeedManager *) SharedInstance;

// For testing purposes
- (void) AddFeedTest;
// Mutators

- (void) AddFeed:(NSString*) URL;
- (void) AddFeedObject:(NRFeed*) Feed;
- (void) AddFavoriteFeedByIndex:(NSUInteger)Index;
- (void) DeleteFeed:(NSUInteger)Index;
- (void) DeleteFeedFromFavorites:(NSUInteger)Index;
- (void) UpdateFeed:(NRFeed*) Feed;
- (void) UpdateFeeds;
- (void) ClearAll;
- (void) ClearCache;

// Accessors
- (NRFeed*) GetFeedFromAllByIndex:(NSUInteger)Index;
- (NRFeed*) GetFeedByIndex:(NSUInteger)Index;
- (NRFeed*) GetFavoriteFeedByIndex:(NSUInteger)Index;
- (NRFeed*) GetFeedById;
- (NSUInteger) GetAllFeedCount;
- (NSUInteger) GetFeedCount;
- (NSUInteger) GetFavoriteFeedCount;
- (BOOL) IsFeedInFavorites:(NRFeed*)FeedToCheck;
@end

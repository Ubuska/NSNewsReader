#import "AppDelegate.h"
#import "NRFeedManager.h"
#import "NRFormatValidator.h"
#import "NRParserRSS.h"


@implementation NRFeedManager
{
    AppDelegate* App;
}
+ (id)SharedInstance
{
    static NRFeedManager *SharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *Data =[[NSUserDefaults standardUserDefaults] objectForKey:@"FeedManager"];
        if ( Data )
        {
            SharedManager = [NSKeyedUnarchiver unarchiveObjectWithData:Data];
        }
        else SharedManager = [[self alloc] init];
    });
    return SharedManager;
}

- (id)init
{
    if (self = [super init])
    {
        App = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        Feeds = [NSMutableArray arrayWithCapacity:0];
        FavoriteFeeds = [NSMutableArray arrayWithCapacity:0];
        
    }
    return self;
}

// This method iterates through all Feed objects and updates it's content.
- (void) UpdateFeeds
{
    for (NRFeed* Feed in Feeds)
    {
        [self UpdateFeed:Feed];
    }
}
- (void) ClearAll
{
    [Feeds removeAllObjects];
    [FavoriteFeeds removeAllObjects];
    [self Save];
}

// Here we store our date in temporary arrays, clear original and save them.
// Then original arrays are restored with content of temporary arrays.

- (void) ClearCache
{
    NSMutableArray* TempFeeds = [[NSMutableArray alloc] init];
    NSMutableArray* TempFavoriteFeeds = [[NSMutableArray alloc] init];
    
    TempFeeds = Feeds;
    TempFavoriteFeeds = FavoriteFeeds;
    
    Feeds = [[NSMutableArray alloc] init];
    FavoriteFeeds = [[NSMutableArray alloc] init];
    [self Save];
    
    Feeds = TempFeeds;
    FavoriteFeeds = TempFavoriteFeeds;
}

#pragma mark - NSCoder Delegate methods

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[Feeds copy] forKey:@"SavedFeeds"];
    [encoder encodeObject:[FavoriteFeeds copy] forKey:@"FavoriteFeeds"];
   // [encoder encodeFloat:_rating forKey:kRatingKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
        App = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        Feeds = [[decoder decodeObjectForKey:@"SavedFeeds"] mutableCopy];
        FavoriteFeeds = [[decoder decodeObjectForKey:@"FavoriteFeeds"] mutableCopy];
        
        if (Feeds == NULL) Feeds = [[NSMutableArray alloc] init];
        if (FavoriteFeeds == NULL) FavoriteFeeds = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - NRFeed methods

// This methods gets URL passed in, convert it and verify XML content.
// Then it decides what type of content that is and use concret parser to get that data.
// Result of this method is new created Feed with filled Feed Items.

- (void) AddFeed:(NSString*) URL
{
    // We need to check if we have this URL in Feeds already.
    for (NRFeed *Feed in Feeds)
    {
        if ([URL isEqual:[Feed GetLink]])
        {
            // Give user feedback says we already have this URL added.
            [App ErrorAlreadyHaveURL];
            return;
        }
    }
    
    // Check internet connection.
    if (![App IsInternetConnectionAvaliable]) return;
    NSURLSessionConfiguration* SessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *Session = [NSURLSession sessionWithConfiguration:SessionConfig delegate:self delegateQueue:nil];
    
    NSURL* DownloadTaskURL = [NSURL URLWithString:URL];
   
    [[Session downloadTaskWithURL:DownloadTaskURL] resume];
}

// We don't need to validate the type of Feed (it was validated when created before).
// Since we just need to update feed without destroying Feed object (just clean Feed Items)
// we can directly call Parse, so it will not create new Feed and just attach new Feed Items to it.
// NOTE: We can remove code duplication in the future.

- (void) UpdateFeed:(NRFeed*) Feed
{
    // Check internet connection.
    if (![App IsInternetConnectionAvaliable]) return;
    
    // Firstly, we download data.
    
    NSURLSessionConfiguration* SessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *Session = [NSURLSession sessionWithConfiguration:SessionConfig delegate:self delegateQueue:nil];
    
    NSURL* DownloadTaskURL = [NSURL URLWithString:[Feed GetLink]];
    NSURLSessionDownloadTask *DownloadDataTask = [[NSURLSession sharedSession] downloadTaskWithURL:DownloadTaskURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        
        // If download data obtained, we notify ProgressHandler delegate
        // gather NSData and pass it in concrete Parser object.
        [self.ProgressHandlerDelegate DownloadFinished];
        NSFileManager *FileManager = [NSFileManager defaultManager];
        
        NSArray *URLs = [FileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *DocumentsDirectory = [URLs objectAtIndex:0];
        
        NSString* FileName = [[NSURL URLWithString:[Feed GetLink]] lastPathComponent];
        NSURL *DestinationURL = [DocumentsDirectory URLByAppendingPathComponent:FileName];
        NSError *FileManagerError;
        
        [FileManager removeItemAtURL:DestinationURL error:NULL];
        [FileManager copyItemAtURL:location toURL:DestinationURL error:&FileManagerError];
        
        // Actual data.
        NSData* ContentData = [FileManager contentsAtPath:location];
        
        NRAbstractParser* Parser;
        
        if ([[Feed GetType] containsString:@"RSS"])
        {
            Parser = [[NRParserRSS alloc] init];
        }
        
        // Atom support can be added with new Parser concrete class.
        // We will just return for now.
        if ([[Feed GetType] containsString: @"Atom"]) return;
        
        if (Parser)
        {
            // Only clear old items if we have data to parse.
            [Feed ClearAll];
            
            // We want to get notified by Parser.
            Parser.ParserResponderDelegate = self;
            [Parser ParseData:ContentData Feed:Feed];
        }
    }];
    
    [DownloadDataTask resume];
}

// Validation ended
// XMLDataType is NSString representing feed type
// Feed object receives XMLDataType to store it for future use.
- (void) ValidationCompleted:(NSString *)XMLDataType Data:(NSData*)Data Feed:(NRFeed*)Feed
{
    NRAbstractParser* Parser;
    [Feed SetType:XMLDataType];
    if ([XMLDataType containsString:@"RSS"])
    {
        Parser = [[NRParserRSS alloc] init];
    }
    // Atom support can be added with new Parser concrete class.
    // We will just return for now.
    if ([XMLDataType containsString: @"Atom"]) return;
    
    if (Parser)
    {
        Parser.ParserResponderDelegate = self;
        [Parser ParseData:Data Feed:Feed];
    }
}

- (void) Save
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:FeedManager] forKey:@"FeedManager"];
}

- (void) AddFeedTest
{
    NRFeed* NewFeed = [[NRFeed alloc]init];
    [NewFeed SetTitle:@"Feed"];
    [Feeds addObject:NewFeed];
    
    for (int i = 0; i< 7; ++i)
    {
        NRFeedItem* NewFeedItem = [[NRFeedItem alloc] init];
        [NewFeedItem SetTitle:@"Feed Item"];
        [NewFeed AddFeedItem:NewFeedItem];
    }
}

// This method must be called only by Parser.
// For adding Feed objects, use AddFeed method.
// It also calling sorting algorithm in Feed (can potentially be an option].

- (void) AddFeedObject:(NRFeed*) Feed
{
    if (![Feeds containsObject:Feed]) [Feeds addObject:Feed];
    [Feed SortItemsByDate];
    [self Save];
}

- (void) AddFavoriteFeedByIndex:(NSUInteger)Index
{
    NRFeed* Feed = [self GetFeedFromAllByIndex:Index];
    if (![FavoriteFeeds containsObject:Feed])
    {
        [FavoriteFeeds addObject:Feed];
    }
    [self Save];
}

// Method deletes Feed objects from Feeds array
// It also insures FavoriteFeeds array also delete Feed object.
- (void) DeleteFeed:(NSUInteger)Index
{
    NRFeed* Feed = [Feeds objectAtIndex:Index];
    [FavoriteFeeds removeObject:Feed];
    [Feeds removeObject:Feed];
    [self Save];
}

// Feed object just being removed from FavoriteFeeds array while it
// still avaliable in Feeds array.
- (void) DeleteFeedFromFavorites:(NSUInteger)Index
{
    [FavoriteFeeds removeObjectAtIndex:Index];
    [self Save];
}


// Accessors

- (NRFeed*) GetFeedFromAllByIndex:(NSUInteger)Index
{
    return Feeds[Index];
}

- (NRFeed*) GetFeedByIndex:(NSUInteger)Index
{
    NRFeed* Feed;
    if ([self IsFavoritesOnly]) Feed = FavoriteFeeds[Index];
    else Feed = Feeds[Index];
    return Feed;
}

- (NRFeed*) GetFavoriteFeedByIndex:(NSUInteger)Index
{
    return FavoriteFeeds[Index];
}

// Placeholder
- (NRFeed*) GetFeedById
{
    return NULL;
}

- (NSUInteger) GetAllFeedCount
{
    return [Feeds count];
}

- (NSUInteger) GetFeedCount
{
    NSUInteger FeedCount;
    if ([self IsFavoritesOnly]) FeedCount = [FavoriteFeeds count];
    else FeedCount = [Feeds count];
    return FeedCount;
}

- (NSUInteger) GetFavoriteFeedCount
{
    return [FavoriteFeeds count];
}

- (BOOL) IsFeedInFavorites:(NRFeed*)FeedToCheck
{
    if ([FavoriteFeeds containsObject:FeedToCheck]) return YES;
    return NO;
}

#pragma mark - Parser Responder delegate methods

- (void) ParserSucceded
{
    // Parsing complete, all objects we need were constructed, we can safely serialize them now.
    [self Save];
    
    // And update delegate view.
    [self.UpdateViewDelegate UpdateView];
}
- (void) ParserFailed
{
    // Error handling here.
}

#pragma mark - NSURLSession Delegate methods

// We obtained data from internet, now we need to validate it's type.
// For that we call Parser until it finds explicit tags in XML content.
// If it finds something, it immediatly quits parsing and we can create concrete Parser to get actual data.

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
        [self.ProgressHandlerDelegate DownloadFinished];
        NSFileManager *FileManager = [NSFileManager defaultManager];
    
        NSArray *URLs = [FileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *DocumentsDirectory = [URLs objectAtIndex:0];

        NSString* FileName = [downloadTask.originalRequest.URL lastPathComponent];
        NSURL *DestinationURL = [DocumentsDirectory URLByAppendingPathComponent:FileName];
        NSError *FileManagerError;
    
        [FileManager removeItemAtURL:DestinationURL error:NULL];
        [FileManager copyItemAtURL:location toURL:DestinationURL error:&FileManagerError];
    
        NSData* ContentData = [FileManager contentsAtPath:location];
    
        dispatch_async(dispatch_get_main_queue(), ^{
        NRFormatValidator* Validator = [[NRFormatValidator alloc] init];
        Validator.ValidatorResponderDelegate = self;
            
        // Feed created here because we need to store original URL in it.
        NRFeed* NewFeed = [[NRFeed alloc] init];
        [NewFeed SetLink:[downloadTask.originalRequest.URL absoluteString]];
        
        [Validator ParseData:ContentData Feed:NewFeed];
    });
    
    
    }

// Here we notify view about our downloading progress.

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double Progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.ProgressHandlerDelegate DownloadProgress:Progress];
    });
}

@end

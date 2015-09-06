
#import "NRParserRSS.h"
#import "NRFeedManager.h"

@implementation NRParserRSS
{
    NRFeed* CurrentFeed;
    NRFeedItem* CurrentItem;
}

- (void)Initialize
{
}

- (void)DidStartElement
{
    IfElement(@"channel")
    {
        if (ExistingFeed) CurrentFeed = ExistingFeed;
        else CurrentFeed = [[NRFeed alloc] init];
        
    }
}

- (void)DidEndElement
{
    IfElement(@"channel")
    {
        if (CurrentItem) [CurrentItem SetTitle:ElementValue];
        [FeedManager AddFeedObject:CurrentFeed];
    }
    IfElement(@"item")
    {
        CurrentItem = [[NRFeedItem alloc] init];
        [CurrentFeed AddFeedItem:CurrentItem];
    }
    IfElement(@"title")
    {
        if (CurrentItem) [CurrentItem SetTitle:ElementValue];
        else [CurrentFeed SetTitle:ElementValue];
    }
    IfElement(@"pubDate")
    {
        DateFormatter = [[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZ"];
        NSDate *Date = [DateFormatter dateFromString:ElementValue];
        [CurrentItem SetDate:Date];
    }
    IfElement(@"url") [CurrentItem SetImageURL:ElementValue];
    
    IfElement(@"description")
    {

        if (CurrentItem)
        {
            NSString* ShortSummary = [ElementValue substringToIndex:30];
            [CurrentItem SetSummary:ShortSummary];
            [CurrentItem SetContent:ElementValue];
        }
        else [CurrentFeed SetSummary:ElementValue];
    }

    
}

- (void)DidEndDocument
{
}

@end


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
    IfElement(@"enclosure")
    {
        NSString* ImageURL = [AttributesDict valueForKey:@"url"];
        [CurrentItem SetImageURL:ImageURL];
    }
    IfElement(@"link")
    {
        if (CurrentItem) [CurrentItem SetLink:ElementValue];
    }
    
    IfElement(@"description")
    {

        if (CurrentItem)
        {
            NSString* ShortSummary = [ElementValue substringToIndex:120];
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

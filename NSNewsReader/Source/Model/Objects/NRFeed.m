//
//  NRFeed.m
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "NRFeed.h"

@implementation NRFeed

#pragma mark - NRFeed Methods

- (instancetype)init
{
    if (self = [super init])
    {
        FeedItems = [NSMutableArray arrayWithCapacity:0];
    }
    return self;  
}

// Mutators
- (void) ClearAll
{
    [FeedItems removeAllObjects];
}
- (void) AddFeedItem:(NRFeedItem*)FeedItem
{
    [FeedItems addObject:FeedItem];
}

// Accessors

- (NSUInteger) GetItemsNumber
{
    return [FeedItems count];
}

- (NRFeedItem*) GetFeedItemByIndex:(NSUInteger)Index
{
    return FeedItems[Index];
}

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        Identifier = [aDecoder decodeObjectForKey:@"Identifier"];
        self.Title = [aDecoder decodeObjectForKey:@"FeedTitle"];
        self.Link = [aDecoder decodeObjectForKey:@"FeedLink"];
        self.Summary = [aDecoder decodeObjectForKey:@"FeedSummary"];
        self.Type = [aDecoder decodeObjectForKey:@"FeedType"];
        FeedItems = [[aDecoder decodeObjectForKey:@"FeedItems"] mutableCopy];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    if (Identifier) [aCoder encodeObject:Identifier forKey:@"Identifier"];
    if (self.Title) [aCoder encodeObject:self.Title forKey:@"FeedTitle"];
    if (self.Link) [aCoder encodeObject:self.Link forKey:@"FeedLink"];
    if (self.Summary) [aCoder encodeObject:self.Summary forKey:@"FeedSummary"];
    if (self.Type) [aCoder encodeObject:self.Type forKey:@"FeedType"];
    
    // Here we check if FeedItem is dates 24 hours before now.
    // If it is, it goes to MutableArray created for this.
    NSMutableArray* LatestFeedItems = [[NSMutableArray alloc] init];
    for (NRFeedItem* FeedItem in FeedItems)
    {
        NSDate* ItemDate = [FeedItem GetDate];
        NSDate* CurrentDate = [NSDate date];
        NSTimeInterval TimeBetweenDates = [CurrentDate timeIntervalSinceDate:ItemDate];
        double SecondsInDay = 86400;
        if (TimeBetweenDates <= SecondsInDay)
        {
            [LatestFeedItems addObject:FeedItem];
        }
    }
    
    if (FeedItems) [aCoder encodeObject:[LatestFeedItems copy] forKey:@"FeedItems"];
}

@end

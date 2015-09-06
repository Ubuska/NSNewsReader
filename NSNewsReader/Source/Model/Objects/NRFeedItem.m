//
//  NRFeedItem.m
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "NRFeedItem.h"

@implementation NRFeedItem

#pragma mark - NSCoding delegate methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.Title = [aDecoder decodeObjectForKey:@"FeedTitle"];
        self.Link = [aDecoder decodeObjectForKey:@"FeedLink"];
        self.Date = [aDecoder decodeObjectForKey:@"FeedDate"];
        self.Updated = [aDecoder decodeObjectForKey:@"FeedUpdated"];
        self.Summary = [aDecoder decodeObjectForKey:@"FeedSummary"];
        self.Content = [aDecoder decodeObjectForKey:@"FeedContent"];
        self.Author = [aDecoder decodeObjectForKey:@"FeedAuthor"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    if (self.Title) [aCoder encodeObject:self.Title forKey:@"FeedTitle"];
    if (self.Link) [aCoder encodeObject:self.Link forKey:@"FeedLink"];
    if (self.Date) [aCoder encodeObject:self.Date forKey:@"FeedDate"];
    if (self.Updated) [aCoder encodeObject:self.Updated forKey:@"FeedUpdated"];
    if (self.Summary) [aCoder encodeObject:self.Summary forKey:@"FeedSummary"];
    if (self.Content) [aCoder encodeObject:self.Content forKey:@"FeedContent"];
    if (self.Author) [aCoder encodeObject:self.Author forKey:@"FeedAuthor"];

}

@end

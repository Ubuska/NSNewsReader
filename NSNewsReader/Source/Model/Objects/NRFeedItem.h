//
// Handles single item in feed.

#import <Foundation/Foundation.h>

@interface NRFeedItem : NSObject <NSCoding>

@property (getter=GetTitle, setter=SetTitle:) NSString* Title;
@property (getter=GetLink, setter=SetLink:) NSString* Link;
@property (getter=GetDate, setter=SetDate:) NSDate* Date;
@property (getter=GetUpdated, setter=SetUpdated:) NSDate* Updated;
@property (getter=GetSummary, setter=SetSummary:) NSString* Summary;
@property (getter=GetContent, setter=SetContent:) NSString* Content;
@property (getter=GetAuthor, setter=SetAuthor:) NSString* Author;
@property (getter=GetImageURL, setter=SetImageURL:) NSString* ImageURL;
@end

//
//  NRFeedDetail-ViewModel.m
//  NSNewsReader
//
//  Created by Peter Gubin on 16/09/15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "NRFeedDetail-ViewModel.h"

#import "NRFeedItem.h"

@interface NRFeedDetail_ViewModel()
@property (nonatomic, readwrite) NRFeedItem *object;

@end

@implementation NRFeedDetail_ViewModel
@synthesize object = _object;

- (NSString *)titleText
{
    return self.object.Title;
}

- (NSString *)contentText
{
    return self.object.Content;
}

//+ (NSSet *)keyPathsForValuesAffectingTitleText
//{
//    return [NSSet setWithObject:@"object"];
//}
//
//+ (NSSet *)keyPathsForValuesAffectingContentText
//{
//    return [NSSet setWithObject:@"object"];
//}
//
//+ (NSSet *)keyPathsForValuesAffectingDateText
//{
//    return [NSSet setWithObject:@"object"];
//}

@end

//
//  NRFeedItemCell-ViewModel.h
//  NSNewsReader
//
//  Created by Peter Gubin on 16/09/15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "BaseViewModel.h"

@interface NRFeedItemCell_ViewModel : BaseViewModel

@property (nonatomic, readonly) NSURL* image;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* summary;
@property (nonatomic, readonly) NSString* publicationDate;

@end

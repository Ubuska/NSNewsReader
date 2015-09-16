//
//  NRFeedDetail-ViewModel.h
//  NSNewsReader
//
//  Created by Peter Gubin on 16/09/15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseViewModel.h"

@interface NRFeedDetail_ViewModel : BaseViewModel
@property(readonly) NSString* titleText;
@property(readonly) NSString* contentText;
@property(readonly) NSString* dateText;

@end

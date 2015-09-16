//
//  BaseViewModel.h
//  NSNewsReader
//
//  Created by Peter Gubin on 16/09/15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject
@property (nonatomic, readonly) id object;

- (instancetype)initWithObject:(id)object;
@end

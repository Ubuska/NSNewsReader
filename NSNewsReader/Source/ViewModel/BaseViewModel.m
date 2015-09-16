//
//  BaseViewModel.m
//  NSNewsReader
//
//  Created by Peter Gubin on 16/09/15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel()
@property (nonatomic, readwrite) id object;

@end

@implementation BaseViewModel

- (instancetype)init
{
    return [self initWithObject:nil];
}

- (instancetype)initWithObject:(id)object
{
    self = [super init];
    if(self) {
        self.object = object;
    }
    return self;
}
@end

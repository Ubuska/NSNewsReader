//
//  NRFormatValidator.m
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "NRFormatValidator.h"

@implementation NRFormatValidator
{
    NSString* DataType;
}

- (void)DidStartElement
{
    IfElement(@"feed")
    {
        NSLog(@"We have Atom here");
        [self AbortParsing];
        DataType = @"Atom";
        [self.ValidatorResponderDelegate ValidationCompleted:@"Atom" Data:ReceivedData Feed:ExistingFeed];
    }
    IfElement(@"rss")
    {
        NSLog(@"We have RSS here");
        [self AbortParsing];
        DataType = @"RSS";
        [self performSelectorOnMainThread:@selector(CallDelegate) withObject:nil waitUntilDone:NO];
        
    }
    
    
}
- (void) CallDelegate
{
    [self.ValidatorResponderDelegate ValidationCompleted:DataType Data:ReceivedData Feed:ExistingFeed];
}
@end

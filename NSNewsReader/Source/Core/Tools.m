//
//  Tools.m
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "Tools.h"
#import <SystemConfiguration/SCNetworkReachability.h>

@implementation Tools

// Very convinient method to accessing main application color.
+ (UIColor*) GetMainColor
{
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
    NSString *ColorString = [Dictionary objectForKey:@"MainColor"];

    return [Tools ColorWithHexString:ColorString];
}

// HEX String to UIColor converter function.
+ (UIColor*) ColorWithHexString:(NSString*)Color
{
    // Remove #
    NSString *NoHashString = [Color stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *Scanner = [NSScanner scannerWithString:NoHashString];
    // Remove + and $
    [Scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]];
        
    unsigned Hex;
    if (![Scanner scanHexInt:&Hex]) return nil;
    int r = (Hex >> 16) & 0xFF;
    int g = (Hex >> 8) & 0xFF;
    int b = (Hex) & 0xFF;
        
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

// This is just placeholder for URL validation.
// We can have alot more complicated algorithm here.
+ (BOOL) IsURLCorrect:(NSString*)URL
{
    if ([NSURL URLWithString:URL]) return YES;
    return NO;
}

// Internet connection check.
+ (BOOL) IsInternetConnectionAvaliable
{
    SCNetworkReachabilityFlags Flags;
    SCNetworkReachabilityRef Address;
    Address = SCNetworkReachabilityCreateWithName(NULL, "www.apple.com" );
    Boolean Success = SCNetworkReachabilityGetFlags(Address, &Flags);
    CFRelease(Address);
    
    bool CanReach = Success
    && !(Flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (Flags & kSCNetworkReachabilityFlagsReachable);
    
    return CanReach;
}

// Just handy function to handle Date to NSString convertion
+ (NSString*) ConvertDateToString:(NSDate*)Date
{

    NSDateFormatter *Formatter = [[NSDateFormatter alloc] init];
    [Formatter setDateFormat:@"dd.MM.yyyy HH:mm"];

    NSString *StringFromDate = [Formatter stringFromDate:Date];
    return StringFromDate;
}
@end

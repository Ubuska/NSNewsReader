
// Class with static convinient static functions.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Tools : NSObject

//+ (CGFloat)preferredHeightForAdapter:(SFSTableViewCellAdapter *)adapter andWidth:(CGFloat)width;

+ (UIColor*) GetMainColor;
+ (UIColor*) ColorWithHexString:(NSString*)Color;
+ (BOOL) IsURLCorrect:(NSString*)URL;
+ (BOOL) IsInternetConnectionAvaliable;
@end

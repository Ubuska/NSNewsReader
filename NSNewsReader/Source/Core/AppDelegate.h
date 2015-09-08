
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (BOOL) IsInternetConnectionAvaliable;
- (void) ErrorAlreadyHaveURL;
- (void) ErrorInvalidData;
@end



#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface NRFeedBrowserController : UITabBarController <UITabBarControllerDelegate, DownloadProgressHandler>
{
    UIProgressView *ProgressView;
}

// Delegate that will be called when we press tab item.
// UIController under UITabController is expected.
@property id<FeedBrowserTabController> TabControllerDelegate;

@end

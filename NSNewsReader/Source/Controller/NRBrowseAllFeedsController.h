
#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface NRBrowseAllFeedsController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, UpdateView, FeedBrowserTabController>
{
    UIProgressView *Progress;
}

@property IBOutlet UITableView* TableView;

@end

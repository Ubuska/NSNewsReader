
#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface NRBrowseFavoritesController : UIViewController <UITableViewDataSource, UITableViewDelegate, FeedBrowserTabController, UpdateView>

@property IBOutlet UITableView* TableView;

@end

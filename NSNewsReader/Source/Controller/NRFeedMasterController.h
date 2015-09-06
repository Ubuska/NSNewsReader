
#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface NRFeedMasterController : UIViewController < UITableViewDataSource, UITableViewDelegate, UpdateView>

@property IBOutlet UITableView* TableView;
@end


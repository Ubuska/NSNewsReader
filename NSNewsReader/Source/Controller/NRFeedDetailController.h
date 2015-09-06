
#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface NRFeedDetailController : UIViewController <UpdateView>

@property NSIndexPath* IndexPath;

@property IBOutlet UILabel* Title;
@property IBOutlet UILabel* Content;
@end

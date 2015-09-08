
#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "AsyncImageView.h"

@interface NRFeedDetailController : UIViewController <UpdateView>

@property NSIndexPath* IndexPath;

@property IBOutlet UILabel* Title;
@property IBOutlet UILabel* Content;
@property IBOutlet UILabel* Date;
@property IBOutlet AsyncImageView* Image;
@end


#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "AsyncImageView.h"
#import "NRFeedDetail-ViewModel.h"

@interface NRFeedDetailController : UIViewController

@property NSIndexPath* IndexPath;

@property IBOutlet UILabel* Title;
@property IBOutlet UILabel* Content;
@property IBOutlet UILabel* Date;
@property IBOutlet AsyncImageView* Image;

@property NRFeedDetail_ViewModel* viewModel;

@end

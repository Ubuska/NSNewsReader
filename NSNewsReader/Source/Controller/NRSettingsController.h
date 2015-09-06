
#import <UIKit/UIKit.h>

@interface NRSettingsController : UIViewController <UIAlertViewDelegate>

@property IBOutlet UILabel* OnlyFavorite;
@property IBOutlet UIButton* ButtonDeleteAllFeeds;
@property IBOutlet UIButton* ButtonClearCache;

@property IBOutlet UISwitch* Switch;

@end

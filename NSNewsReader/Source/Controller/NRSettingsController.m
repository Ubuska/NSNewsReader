
#import "NRSettingsController.h"
#import "NRFeedManager.h"

@interface NRSettingsController ()

@end

@implementation NRSettingsController

- (void)viewDidLoad
{
    // Get strings from plist.
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
    NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
    NSString *DisplayOnlyFavorites = [Dictionary objectForKey:@"OnlyFavorites"];
    NSString *DeleteAllFeeds = [Dictionary objectForKey:@"DeleteAll"];
    NSString *ClearCache = [Dictionary objectForKey:@"ClearCache"];
    
    // Strings bindings.
    [self.ButtonClearCache setTitle:ClearCache forState:UIControlStateNormal];
    [self.ButtonDeleteAllFeeds setTitle:DeleteAllFeeds forState:UIControlStateNormal];
    self.OnlyFavorite.text = DisplayOnlyFavorites;
    
    [super viewDidLoad];
    [self.Switch setOn:[FeedManager IsFavoritesOnly]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FavoritesSwitchChanged:(id)sender
{
    UISwitch* Switch = (UISwitch*) sender;
    if (Switch)
    {
        [FeedManager SetFavoritesOnly:Switch.isOn];
    }
}

- (IBAction)DeleteAll:(id)sender
{
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
    NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
    NSString *AlertTitle = [Dictionary objectForKey:@"DeleteAllTitle"];
    NSString *AlertMessage = [Dictionary objectForKey:@"DeleteAllMessage"];
    NSString *AlertConfirm = [Dictionary objectForKey:@"AlertConfirm"];
    NSString *AlertCancel = [Dictionary objectForKey:@"AlertCancel"];
    
    UIAlertView * Alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:AlertCancel otherButtonTitles:AlertConfirm, nil];
    [Alert show];
    
    
}

- (IBAction)ClearCache:(id)sender
{
    [FeedManager ClearCache];
}

#pragma mark - UIAlertDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [FeedManager ClearAll];
    }
}
@end

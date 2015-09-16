#import "NRBrowseAllFeedsController.h"
#import "NRFeedManager.h"
#import "NRFeedBrowserController.h"
#import "NRFavoriteFeedCell.h"
#import "Tools.h"
#import "AppDelegate.h"



@interface NRBrowseAllFeedsController ()
{
    BOOL bIsEditModeActivated;
    AppDelegate* App;
}
@end

@implementation NRBrowseAllFeedsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self UpdateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertViewDelegate methods

- (IBAction)AddFeed:(id)sender
{
    // Check internet connection.
    App = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if (![App IsInternetConnectionAvaliable]) return;
    
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
    NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
    NSString *AlertTitle = [Dictionary objectForKey:@"AddFeedTitle"];
    NSString *AlertMessage = [Dictionary objectForKey:@"AddFeedMessage"];
    NSString *AlertConfirm = [Dictionary objectForKey:@"AlertConfirm"];
    NSString *AlertCancel = [Dictionary objectForKey:@"AlertCancel"];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:AlertCancel otherButtonTitles:AlertConfirm, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)AddFeedToFavorites:(id)sender
{
    UIButton *SenderButton = (UIButton *)sender;
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:SenderButton.tag inSection:0];
    
    if (SenderButton.selected == NO)
    {
        [FeedManager AddFavoriteFeedByIndex:IndexPath.row];
    }
    else
    {
        [FeedManager DeleteFeedFromFavorites:IndexPath.row];
    }
    
    SenderButton.selected = !SenderButton.selected;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
        
        NSString* TypedText = [[alertView textFieldAtIndex:0] text];
        
        // Validate URL here and add if all is correct.
        if ([Tools IsURLCorrect:TypedText])
        {
            [FeedManager AddFeed:TypedText];
        }
        else
        {
            NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
            NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
            NSString *AlertTitle = [Dictionary objectForKey:@"InvalidURLTitle"];
            NSString *AlertMessage = [Dictionary objectForKey:@"InvalidURLMessage"];
            NSString *AlertConfirm = [Dictionary objectForKey:@"AlertConfirm"];
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:AlertConfirm otherButtonTitles: nil];
            [alert show];
        }
        
        
    }
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger FeedsCount = [FeedManager GetAllFeedCount];
    return FeedsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedCell";
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    return Cell;
}

// This method is displayed right before Cell is become visible inside TableView bounds.

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NRFavoriteFeedCell* Cell = (NRFavoriteFeedCell*) cell;
    if (Cell)
    {
        // Styling
        Cell.Title.textColor = [Tools GetMainColor];
        
        // Data binding
        NRFeed* Feed = [FeedManager GetFeedFromAllByIndex:indexPath.row];
        Cell.Title.text = [Feed GetTitle];
        Cell.Summary.text = [Feed GetSummary];
        Cell.FavoriteButton.tag = indexPath.row;
        Cell.FavoriteButton.selected = [FeedManager IsFeedInFavorites:Feed];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [FeedManager DeleteFeed:indexPath.row];
        NSArray *DeleteIndexPaths = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:0], nil];
        [self.TableView beginUpdates];
        [self.TableView deleteRowsAtIndexPaths:DeleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.TableView endUpdates];
    }
}



#pragma mark - FeedBrowserTabController Delegate methods

- (void) EditPressed
{
    bIsEditModeActivated = !bIsEditModeActivated;
    [self.TableView setEditing:bIsEditModeActivated animated:YES];
}

- (void) TabItemPressed
{
    bIsEditModeActivated = NO;
    [self.TableView setEditing:NO animated:NO];
    [self UpdateView];
}

#pragma mark - UpdateView Delegate methods

- (void) UpdateView
{
    FeedManager.UpdateViewDelegate = self;
    NRFeedBrowserController* TabController = (NRFeedBrowserController*) self.tabBarController;
    TabController.TabControllerDelegate = self;
    [self.TableView reloadData];
}

@end

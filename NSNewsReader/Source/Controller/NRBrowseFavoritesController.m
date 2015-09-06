
#import "NRBrowseFavoritesController.h"
#import "NRFeedManager.h"
#import "NRFeedBrowserController.h"

@interface NRBrowseFavoritesController ()
{
    BOOL bIsEditModeActivated;
}
@end

@implementation NRBrowseFavoritesController

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

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger FeedsCount = [FeedManager GetFavoriteFeedCount];
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
    if (cell)
    {
        NRFeed* Feed = [FeedManager GetFavoriteFeedByIndex:indexPath.row];
        cell.textLabel.text = [Feed GetTitle];
        cell.detailTextLabel.text = [Feed GetSummary];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [FeedManager DeleteFeedFromFavorites:indexPath.row];
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

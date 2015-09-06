#import "NRFeedMasterController.h"
#import "NRFeedManager.h"
#import "NRFeedItemCell.h"
#import "NRFeedDetailController.h"
#import "AppDelegate.h"

@interface NRFeedMasterController ()
{
    NSIndexPath* IP;
    AppDelegate* App;
}

@end

@implementation NRFeedMasterController

#pragma mark - NRFeedMasterController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Creating refresh button.
    UIBarButtonItem *Button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(OnRefreshPress:)];
    self.navigationItem.rightBarButtonItem = Button;
    
    // Check internet connection.
    App = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [App IsInternetConnectionAvaliable];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"FeedDetailSegue"])
    {
        NRFeedDetailController* DetailController = (NRFeedDetailController*) segue.destinationViewController;
        if (DetailController) DetailController.IndexPath = IP;
    }
}

- (IBAction)OnRefreshPress:(id)sender
{
    FeedManager.UpdateViewDelegate = self;
    [FeedManager UpdateFeeds];
}

- (IBAction)OnMenuPress:(id)sender
{
    [self performSegueWithIdentifier:@"FeedsScreenSegue" sender:self];
}

#pragma mark - UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger FeedsCount = [FeedManager GetFeedCount];
    return FeedsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NRFeed* Feed = [FeedManager GetFeedByIndex:section];
    NSInteger FeedItemsCount = [Feed GetItemsNumber];
    return FeedItemsCount;
}

// Return reused cells here.

// Optimization notes:
// We don't actually bind any data here, because this method is called
// before Cell is actually visible, so it need to work as fast as possible.
// For binding we use WillDisplayCell instead.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedItemCell";
    UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    return Cell;
}

// This method is displayed right before Cell is become visible inside TableView bounds.

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NRFeedItemCell* Cell = (NRFeedItemCell*) cell;
    if (Cell)
    {
        NRFeed* Feed = [FeedManager GetFeedByIndex:indexPath.section];
        NRFeedItem* FeedItem = [Feed GetFeedItemByIndex:indexPath.row];
        Cell.Image.imageURL = [NSURL URLWithString:[FeedItem GetImageURL]];
        Cell.Title.text = [FeedItem GetTitle];
        Cell.Summary.text = [FeedItem GetSummary];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    NRFeed* Feed = [FeedManager GetFeedByIndex:section];
    return [Feed GetTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IP = indexPath;
    [self performSegueWithIdentifier:@"FeedDetailSegue" sender:self];
}

#pragma mark - Update View Delegate method

- (void) UpdateView
{
    [self.TableView reloadData];
}



@end

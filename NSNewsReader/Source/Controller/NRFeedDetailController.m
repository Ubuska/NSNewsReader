
#import "NRFeedDetailController.h"
#import "NRFeedManager.h"

@interface NRFeedDetailController ()

@end

@implementation NRFeedDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self UpdateView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) UpdateView
{
    NRFeed* Feed = [FeedManager GetFeedByIndex:self.IndexPath.section];
    NRFeedItem* FeedItem = [Feed GetFeedItemByIndex:self.IndexPath.row];
    self.Title.text = [FeedItem GetTitle];
    self.Content.text = [FeedItem GetContent];
}


@end

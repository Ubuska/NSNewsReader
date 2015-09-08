
#import "NRFeedDetailController.h"
#import "NRFeedManager.h"

@interface NRFeedDetailController ()
{
    NRFeedItem* FeedItem;
}
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

- (IBAction)OpenInBrowser:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[FeedItem GetLink]]];
}

- (void) UpdateView
{
    NRFeed* Feed = [FeedManager GetFeedByIndex:self.IndexPath.section];
    FeedItem = [Feed GetFeedItemByIndex:self.IndexPath.row];
    self.Title.text = [FeedItem GetTitle];
    self.Content.text = [FeedItem GetContent];
    self.Image.imageURL = [NSURL URLWithString:[FeedItem GetImageURL]];
}


@end

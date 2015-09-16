
#import "NRFeedDetailController.h"
#import "NRFeedDetail-ViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NRFeedDetailController ()
@property RACSignal* titleSignal;
@end

@implementation NRFeedDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bindViewModel];
}

- (IBAction)OpenInBrowser:(id)sender
{
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.viewModel ]]];
}

-(void)bindViewModel
{
    RAC(self, Title.text) = [RACObserve(self, viewModel.titleText) ignore:nil];
    RAC(self, Content.text) = [RACObserve(self, viewModel.contentText) ignore:nil];
    RAC(self, Date.text) = [RACObserve(self, viewModel.dateText) ignore:nil];
}

@end

//
//  NRTFeedBrowserController.m
//  NSNewsReader
//
//  Created by Peter Gubin on 06.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "NRFeedBrowserController.h"
#import "NRFeedManager.h"

@interface NRFeedBrowserController ()

@end

@implementation NRFeedBrowserController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    
    // Progress view setup.
    ProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];;
    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    [NavBar addSubview:ProgressView];
    [ProgressView setTranslatesAutoresizingMaskIntoConstraints:NO];
    FeedManager.ProgressHandlerDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController conformsToProtocol:@protocol(FeedBrowserTabController)])
        {
            id<FeedBrowserTabController> ViewController = (id<FeedBrowserTabController>) viewController;
            [ViewController TabItemPressed];
        }
    
}

- (IBAction)CloseBrowser:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Edit:(id)sender
{
    [self.TabControllerDelegate EditPressed];
}


#pragma mark - DownloadProgressHandler Delegate methods

- (void) DownloadProgress:(float)Progress
{
    if (ProgressView.hidden == YES) ProgressView.hidden = NO;
    [ProgressView setProgress:Progress animated:YES];
}

- (void) DownloadFinished
{
    [ProgressView setProgress:1.0f animated:YES];
    ProgressView.hidden = YES;
}
@end

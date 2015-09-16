#import "Tools.h"
#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL) IsInternetConnectionAvaliable
{
    
    if (![Tools IsInternetConnectionAvaliable])
    {
        NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
        NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
        NSString *AlertTitle = [Dictionary objectForKey:@"NoInternetTitle"];
        NSString *AlertMessage = [Dictionary objectForKey:@"NoInternetMessage"];
        NSString *AlertConfirm = [Dictionary objectForKey:@"AlertConfirm"];
        
        UIAlertView * Alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:AlertConfirm otherButtonTitles:nil];
        [Alert show];
        
        return NO;
    }
    return YES;
}

- (void) ErrorAlreadyHaveURL
{
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
    NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
    NSString *AlertTitle = [Dictionary objectForKey:@"AlreadyAddedURLTitle"];
    NSString *AlertMessage = [Dictionary objectForKey:@"AlreadyAddedMessage"];
    NSString *AlertConfirm = [Dictionary objectForKey:@"AlertConfirm"];
    
    UIAlertView * Alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:AlertConfirm otherButtonTitles:nil];
    [Alert show];
}

- (void) ErrorInvalidData
{
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"plist"];
    NSDictionary *Dictionary = [[NSDictionary alloc] initWithContentsOfFile:Path];
    NSString *AlertTitle = [Dictionary objectForKey:@"InvalidDataTitle"];
    NSString *AlertMessage = [Dictionary objectForKey:@"InvalidDataMessage"];
    NSString *AlertConfirm = [Dictionary objectForKey:@"AlertConfirm"];
    
    UIAlertView * Alert = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertMessage delegate:self cancelButtonTitle:AlertConfirm otherButtonTitles:nil];
    [Alert show];
}


@end

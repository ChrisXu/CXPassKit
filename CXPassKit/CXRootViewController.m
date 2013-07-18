//
//  CXRootViewController.m
//  CXPassKit
//
//  Created by ChrisXu on 13/7/2.
//  Copyright (c) 2013年 ChrisXu. All rights reserved.
//

#import "CXRootViewController.h"
#import "CXPassKit.h"
@interface CXRootViewController ()
<PKAddPassesViewControllerDelegate>
{
    IBOutlet UITextField *passURLTextField;
}
- (IBAction)downloadAction:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)openAction:(id)sender;
@end

@implementation CXRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"passesInPassBook:%@",[CXPassKit passesInPassBook]);
    
    NSLog(@"passesInDocument:%@",[CXPassKit passesInDocument]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)downloadAction:(id)sender
{
    [CXPassKit downloadWithPassTypeIdentifier:@"pass.appshot.net.ios6" fromURL:[NSURL URLWithString:passURLTextField.text] completionBlock:^(BOOL success, NSString *msg) {
        NSLog(@"%@",msg);
    }];
}

- (IBAction)removeAction:(id)sender
{
    [CXPassKit removePassWithPassTypeIdentifier:@"pass.appshot.net.ios6"];
}

- (IBAction)openAction:(id)sender
{
    [CXPassKit presentPassWithPassTypeIdentifier:@"pass.appshot.net.ios6" delegateViewController:self completionBlock:^(BOOL success, NSString *msg, NSError *error) {
        
    }];
}

#pragma mark - PKAddPassesViewControllerDelegate
-(void)addPassesViewControllerDidFinish:(PKAddPassesViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([CXPassKit hasPassInPassbookWithPassTypeIdentifier:@"pass.appshot.net.ios6"])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Store to Pass" message:nil delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Cancel storing pass to passbook" message:nil delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil];
        [alertView show];
    }
}
@end

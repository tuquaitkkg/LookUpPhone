//
//  CallAndMessageViewController.m
//  PhoneNumber
//
//  Created by DucLT on 5/6/18.
//  Copyright © 2018 Nextop Asia. All rights reserved.
//

#import "CallAndMessageViewController.h"

@interface CallAndMessageViewController ()

@end

@implementation CallAndMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view layoutIfNeeded];
    [self setBoderView:_lblTitle withCornerRadius:_lblTitle.frame.size.height/2];
    [self setBoderView:_viewParent1 withCornerRadius:20.0f];
    [self setBoderView:_viewParent2 withCornerRadius:20.0f];
    [self setBoderView:_viewCall withCornerRadius:10.0f];
    [self setBoderView:_viewMessage withCornerRadius:10.0f];
    [self setBoderView:_viewCall withBorderWidth:5];
    [self setBoderView:_viewMessage withBorderWidth:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCall:(id)sender {
    NSString *phNo = _phoneNumber;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (IBAction)actionMessage:(id)sender {
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor],
                                                          NSForegroundColorAttributeName,
                                                          nil]];
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
        messageController.messageComposeDelegate = self; // Set delegate to current instance

        NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
        [recipients addObject:_phoneNumber]; // Append example phone number to array
        messageController.recipients = recipients; // Set the recipients of the message to the created array
        
        [self presentViewController:messageController animated:YES completion:^{
            
        }];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],
                                                          NSForegroundColorAttributeName,
                                                          nil]];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setBoderView:(UIView *)view withCornerRadius:(CGFloat)radius {
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
}

- (void)setBoderView:(UIView *)view withBorderWidth:(CGFloat)width {
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = width;
    view.layer.borderColor = [UIColor colorWithRed:217.0/255.0 green:188.0/255.0 blue:240.0/255.0 alpha:1].CGColor;
}

@end

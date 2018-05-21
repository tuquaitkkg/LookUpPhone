//
//  CallAndMessageViewController.h
//  PhoneNumber
//
//  Created by DucLT on 5/6/18.
//  Copyright © 2018 Nextop Asia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AppConfig.h"

@interface CallAndMessageViewController : UIViewController <MFMessageComposeViewControllerDelegate>
- (IBAction)actionCall:(id)sender;
@property (strong, nonatomic) NSString *phoneNumber;
- (IBAction)actionMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *viewParent1;
@property (weak, nonatomic) IBOutlet UIView *viewCall;
@property (weak, nonatomic) IBOutlet UIView *viewParent2;
@property (weak, nonatomic) IBOutlet UIView *viewMessage;

@end

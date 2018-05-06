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

@end

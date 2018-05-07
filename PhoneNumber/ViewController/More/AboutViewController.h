//
//  AboutViewController.h
//  Manga
//
//  Created by NhuomTV on 2/27/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfig.h"
#import "PrivacyViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnPrivacy;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;
- (IBAction)clickPrivacy:(id)sender;
- (IBAction)clickSupport:(id)sender;

@end

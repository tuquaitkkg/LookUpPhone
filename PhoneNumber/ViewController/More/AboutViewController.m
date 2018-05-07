//
//  AboutViewController.m
//  Manga
//
//  Created by NhuomTV on 2/27/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "AboutViewController.h"
#import "iRate.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelVersion;
@property (weak, nonatomic) IBOutlet UIButton *btnShareApp;
@property (weak, nonatomic) IBOutlet UIButton *btnReview;

@end

@implementation AboutViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
        self.title = @"About";
    }
    
    return self;
}
- (NSString *)appNameAndVersionNumberDisplayString {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];    
    return [NSString stringWithFormat:@"Version %@", majorVersion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelVersion.text = [self appNameAndVersionNumberDisplayString];
    [self.btnReview setBackgroundColor:appThemColor];
    [self.btnShareApp setBackgroundColor:appThemColor];
    [self.btnPrivacy setBackgroundColor:appThemColor];
    [self.btnSupport setBackgroundColor:appThemColor];
    self.btnReview.layer.cornerRadius = 3;
    self.btnShareApp.layer.cornerRadius = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
- (IBAction)onShare:(id)sender {
  
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    [sharingItems addObject:[NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",APPLE_APP_ID]];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    activityController.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popController = [activityController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceRect = self.btnShareApp.bounds;
    popController.sourceView = self.btnShareApp;
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)onReview:(id)sender {
    [[iRate sharedInstance] promptForRating];
}

- (IBAction)clickPrivacy:(id)sender {
    PrivacyViewController *privacyVC = [[PrivacyViewController alloc] initWithNibName:@"PrivacyViewController" bundle:nil];
    [self.navigationController pushViewController:privacyVC animated:YES];
}

- (IBAction)clickSupport:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.navigationBar.tintColor = [UIColor whiteColor];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:@[@"hivonghuongdicuatoi90@gmail.com"]];
        [self presentViewController:mailCont animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your device cannot send email. Check your email settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end

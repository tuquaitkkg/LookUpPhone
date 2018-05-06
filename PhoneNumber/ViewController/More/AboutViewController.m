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

@end

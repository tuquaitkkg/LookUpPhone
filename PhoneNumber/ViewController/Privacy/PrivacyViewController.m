//
//  PrivacyViewController.m
//  PhoneNumber
//
//  Created by DucLT on 5/7/18.
//  Copyright © 2018 Nextop Asia. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Privacy";
    // Do any additional setup after loading the view from its nib.
    NSString* path = [[NSBundle mainBundle] pathForResource:@"policy_file"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    self.lblTitle.text = content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  TabBarViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "TabBarViewController.h"
#import "HistoryViewController.h"
#import "SearchViewController.h"
#import "ContactViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        UINavigationController *searchNV = [[UINavigationController alloc] initWithRootViewController:[[SearchViewController alloc] initWithNibName:NSStringFromClass([SearchViewController class]) bundle:nil]];
        
        UINavigationController *historyNV = [[UINavigationController alloc] initWithRootViewController:[[HistoryViewController alloc] initWithNibName:NSStringFromClass([HistoryViewController class]) bundle:nil]];
        
        UINavigationController *contactNV = [[UINavigationController alloc] initWithRootViewController:[[ContactViewController alloc] initWithNibName:NSStringFromClass([ContactViewController class]) bundle:nil]];
        
        UINavigationController *settingNV = [[UINavigationController alloc] initWithRootViewController:[[AboutViewController alloc] initWithNibName:NSStringFromClass([AboutViewController class]) bundle:nil]];

        self.viewControllers = @[searchNV,historyNV,contactNV,settingNV];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setTranslucent:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

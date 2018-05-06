//
//  AppDelegate.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "AppConfig.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "iRate.h"

@interface AppDelegate ()<iRateDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    TabBarViewController *tabBarVC = [[TabBarViewController alloc] init] ;
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.window setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:appThemColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           }];
    [[UITabBar appearance] setBarTintColor:appThemColor];
    
    [GADMobileAds configureWithApplicationID:GOOGLE_ADMOD_APP_ID];
    [self initIrate];

    return YES;
}

- (void)initIrate {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    [iRate sharedInstance].applicationBundleID = bundleID;
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    //set events count (default is 10)
    [iRate sharedInstance].eventsUntilPrompt = 1;
    
    //disable minimum day limit and reminder periods
    [iRate sharedInstance].daysUntilPrompt = 2;
    [iRate sharedInstance].remindPeriod = 1;
    [iRate sharedInstance].delegate = self;
    
}

#pragma mark -
#pragma mark iRate delegate methods

- (void)iRateUserDidRequestReminderToRateApp {
    //reset event count after every 5 (for demo purposes)
    [iRate sharedInstance].eventCount = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)didInitialize:(BOOL)status {
    NSLog(@"didInitialize");
    // chartboost is ready
}


@end

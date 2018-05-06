//
//  BaseViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "BaseViewController.h"
#import "PhoneDetailViewController.h"
#import <KSToastView/KSToastView.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "HttpClient.h"
#import <GoogleMobileAds/GADRequest.h>

@interface BaseViewController ()<GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;
@property (strong, nonatomic) GADBannerView  *bannerViewAd;
@property (assign, nonatomic) NSInteger currentClick;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:138.0/255.0 green:110.0/255.0 blue:203.0/255.0 alpha:1.0];
    
    NSString *check = [[NSUserDefaults standardUserDefaults] stringForKey:@"InAppPurchase"];
    if (check.integerValue != 1) {
        
        self.interstitial = [self createAndLoadInterstitial];
        
        if ([self isKindOfClass:[PhoneDetailViewController class]]) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                self.bannerViewAd = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:CGPointMake(0, HEGHT_SCREEN - 50  - 64)];
                
            } else {
                self.bannerViewAd = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:CGPointMake(0, HEGHT_SCREEN - 90  - 64)];
            }
            [self.view addSubview:self.bannerViewAd];
            
            self.bannerViewAd.adUnitID = GOOGLE_ADMOD_KEY_BANNER;
            
            self.bannerViewAd.rootViewController = self;
            
            GADRequest *request = [GADRequest request];
            
            //request.testDevices = @[ kGADSimulatorID ];
            
            [self.bannerViewAd loadRequest:request];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyInAppSuccess:) name:@"BuyInAppSuccess" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buyInAppSuccess:(NSNotification*)notification{
    if (self.bannerViewAd) {
        [self.bannerViewAd removeFromSuperview];
    }
    
}

-(void)searchWithPhone:(NSString*)phone{
    [self logEventToShowFullAd];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [API searchPhone:phone
             calBack:^(BOOL success, NSString *message, NSInteger code, id result) {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 if (success) {
                     PhoneModel *phone = (PhoneModel*)result;
                     
                     RLMResults *phones = [PhoneModel allObjects];
                     for (PhoneModel *phoneModel in phones) {
                         if ([phoneModel.phoneID isEqualToString:phone.phoneID]
                             || [phoneModel.phone_number isEqualToString:phone.phone_number]) {
                             RLMRealm *realm = [RLMRealm defaultRealm];
                             [realm transactionWithBlock:^{
                                 [realm deleteObject:phoneModel];
                             }];
                         }
                     }
                     
                     RLMRealm *realm = [RLMRealm defaultRealm];
                     [realm transactionWithBlock:^{
                         [realm addObjects:@[phone]];
                     }];
                     
                     PhoneDetailViewController *detailVC = [[PhoneDetailViewController alloc] initWithNibName:NSStringFromClass([PhoneDetailViewController class]) bundle:nil];
                     detailVC.phoneModel = phone;
                     detailVC.hidesBottomBarWhenPushed = YES;
                     [self.navigationController pushViewController:detailVC animated:YES];
                     
                 }else{
                     [KSToastView ks_showToast:@"Can not find this phone number."];
                 }
             }];
}


- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:GOOGLE_ADMOD_KEY];
    interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    //request.testDevices = @[ kGADSimulatorID ];
    [interstitial loadRequest:request];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
}
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"%@",error.description);
}

-(void)logEventToShowFullAd{
    NSString *check = [[NSUserDefaults standardUserDefaults] stringForKey:@"InAppPurchase"];
    if (check.integerValue == 1) {
        return;
    }
    self.currentClick =  self.currentClick +1;
    if (self.currentClick >= kNumberClickToShowAd) {
        self.currentClick = 0;
        
        if ([self.interstitial isReady]) {
            [self.interstitial presentFromRootViewController:self];
        }else{
            self.interstitial = [self createAndLoadInterstitial];
        }
    }
}
-(void)forceEventToShowFullAd{
    NSString *check = [[NSUserDefaults standardUserDefaults] stringForKey:@"InAppPurchase"];
    if (check.integerValue == 1) {
        return;
    }
    if ([self.interstitial isReady]) {
        self.currentClick = 0;
        [self.interstitial presentFromRootViewController:self];
    }else{
        self.interstitial = [self createAndLoadInterstitial];
    }
}

@end

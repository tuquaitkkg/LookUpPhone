//
//  BaseViewController.h
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppEnum.h"
#import "AppConfig.h"


@interface BaseViewController : UIViewController

-(void)searchWithPhone:(NSString*)phone;

-(void)logEventToShowFullAd;
-(void)forceEventToShowFullAd;

@end

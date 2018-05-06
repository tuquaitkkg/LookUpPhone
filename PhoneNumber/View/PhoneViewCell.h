//
//  PhoneViewCell.h
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RETableViewManager/RETableViewManager.h>

@interface PhoneViewCell : RETableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (copy, nonatomic) void(^clickGoToCallView)();
- (IBAction)goToCallView:(id)sender;

@end

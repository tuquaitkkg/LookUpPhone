//
//  HistoryViewCell.h
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneModel.h"

@interface HistoryViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

-(void)configCell:(PhoneModel*)model;

@end

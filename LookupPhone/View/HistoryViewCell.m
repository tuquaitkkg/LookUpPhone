//
//  HistoryViewCell.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "HistoryViewCell.h"

@implementation HistoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configCell:(PhoneModel*)model{

    self.nameLabel.text = model.name;
    self.phoneLabel.text = [model phoneString];
    self.addressLabel.text = model.address;
    
}
@end

//
//  HistoryViewCell.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "ContactViewCell.h"

@implementation ContactViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)clickToPhone:(id)sender {
    if (self.clickGoToCallView) {
        self.clickGoToCallView(_indexPath);
    }
}

-(void)configCell:(CKContact*)contact{

    NSString *str = @"";
    
    if (contact.firstName.length) {
        str = [str stringByAppendingString:contact.firstName];
    }
    
    if (contact.lastName.length) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@" %@", contact.lastName]];
    }
    self.nameLabel.text = str;
    if (contact.phones.count) {
        CKPhone *phone = contact.phones[0];
        self.phoneLabel.text = phone.number;

    }else{
        self.phoneLabel.text = @"";
    }

    
}
@end

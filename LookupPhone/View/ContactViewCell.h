//
//  HistoryViewCell.h
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContactsKit.h>

@interface ContactViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

-(void)configCell:(CKContact*)contact;

@end

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
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (copy, nonatomic) void(^clickGoToCallView)(NSIndexPath *indexPath);
- (IBAction)clickToPhone:(id)sender;

-(void)configCell:(CKContact*)contact;

@end

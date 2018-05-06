//
//  PhoneViewCell.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "PhoneViewCell.h"
#import "AppConfig.h"

@implementation PhoneViewCell

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Handle state


#pragma mark -
#pragma mark Public methods

+(CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager{

    return 60;
}
- (void)cellDidLoad {
    [super cellDidLoad];
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.backgroundColor           = [UIColor clearColor];
    
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.text = @"";
    self.labelTitle.text = self.item.title;
   
    self.labelSubTitle.text = self.item.detailLabelText;
    self.btnCall.hidden = YES;
    if (self.rowIndex == 2) {
        self.btnCall.hidden = NO;
    }
}

#pragma mark -
#pragma mark Private methods

#pragma mark -
#pragma mark Delegate methods

#pragma mark -
#pragma mark Text field events

- (IBAction)goToCallView:(id)sender {
    if (self.clickGoToCallView) {
        self.clickGoToCallView();
    }
}
@end

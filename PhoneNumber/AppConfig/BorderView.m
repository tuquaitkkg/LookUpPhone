//
//  BorderView.m
//  PhoneNumber
//
//  Created by DucLT on 5/6/18.
//  Copyright © 2018 Nextop Asia. All rights reserved.
//

#import "BorderView.h"

@implementation BorderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width/2;
}

@end

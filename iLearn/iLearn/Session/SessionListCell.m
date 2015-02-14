//
//  SessionListCell.m
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "SessionListCell.h"

@implementation TableButton
@end

@implementation SessionListCell

- (void)awakeFromNib {
    // Initialization code
    
    CGFloat radius = 5.0;
    CGFloat borderWidth = 1.0;
    CGColorRef color = [UIColor lightGrayColor].CGColor;
    
    [[self.btnAddAttendees layer] setBorderColor:color];
    [[self.btnAddAttendees layer] setBorderWidth:borderWidth];
    [[self.btnAddAttendees layer] setCornerRadius:radius];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

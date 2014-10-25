//
//  RoundThumbCell.m
//  iLearn
//
//  Created by Zeeshan Khan on 25/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "RoundThumbCell.h"

@implementation RoundThumbCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imgThumb.layer.cornerRadius = self.imgThumb.frame.size.width / 2.0;
//    self.imgThumb.layer.borderWidth = 3.0;
//    self.imgThumb.layer.borderColor = [UIColor clearColor].CGColor;
    self.imgThumb.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SessionListCell.h
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableButton : UIButton
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@interface SessionListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblBy;
@property (weak, nonatomic) IBOutlet TableButton *btnAddAttendees;

@end

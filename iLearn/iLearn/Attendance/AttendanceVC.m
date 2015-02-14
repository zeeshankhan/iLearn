//
//  AttendanceVC.m
//  iLearn
//
//  Created by Zeeshan Khan on 19/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "AttendanceVC.h"
#import "User_DM.h"
#import "User.h"
#import "Session.h"
#import "Attendee.h"
#import "Attendance_DM.h"
#import "RoundThumbCell.h"

@interface AttendanceVC ()
@property (nonatomic, strong) NSMutableArray *arrUsers;
@property (nonatomic, strong) NSMutableArray *arrAttendees;
@property (weak, nonatomic) IBOutlet UIView *vName;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITableView *tUsers;
@property (weak, nonatomic) IBOutlet UITableView *tAttendees;
@property (weak, nonatomic) IBOutlet UILabel *lblSessionName;
@end

@implementation AttendanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Attendance";
    self.lblSessionName.text = self.session.name;
    self.arrAttendees = [[[Attendance_DM sharedInstance] getAttendeesForSession:self.session.sessionId] mutableCopy];
//    self.tAttendees.allowsMultipleSelectionDuringEditing = NO;

    NSArray *arrUsrs = [[User_DM sharedInstance] getUsers];
    self.arrUsers = [arrUsrs mutableCopy];
    for (Attendee *attendee in self.arrAttendees) {
        for (User *usr in arrUsrs) {
            if ([attendee.userId isEqualToString:usr.userId] && [self.arrUsers containsObject:usr]) {
                [self.arrUsers removeObject:usr];
            }
        }
    }
    [self formatView];
}

- (void)formatView {
    
    CGFloat radius = 5.0;
    CGFloat borderWidth = 1.0;
    CGColorRef color = [UIColor whiteColor].CGColor;
    
    [[self.vName layer] setBorderColor:color];
    [[self.vName layer] setBorderWidth:borderWidth];
    [[self.vName layer] setCornerRadius:radius];
    
    [[self.tUsers layer] setBorderColor:color];
    [[self.tUsers layer] setBorderWidth:borderWidth];
    [[self.tUsers layer] setCornerRadius:radius];
    
    [[self.tAttendees layer] setBorderColor:color];
    [[self.tAttendees layer] setBorderWidth:borderWidth];
    [[self.tAttendees layer] setCornerRadius:radius];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tUsers])
        return self.arrUsers.count;
    return self.arrAttendees.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenity = @"RoundThumbCell";
    RoundThumbCell *cell = (RoundThumbCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenity];
    if (cell == nil) {
        UIViewController *controller = [[UIViewController alloc] initWithNibName:cellIdenity bundle:nil];
        cell = (RoundThumbCell*)controller.view;
    }

    if ([tableView isEqual:self.tUsers]) {
        User *usr = (User*)[self.arrUsers objectAtIndex:indexPath.row];
        cell.lblTitle.text = [NSString stringWithFormat:@"%@ %@", usr.fname, usr.lname];
        cell.imgThumb.image = [Utility imageMFor:usr.userId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        Attendee *attendee = (Attendee*)[self.arrAttendees objectAtIndex:indexPath.row];
        cell.lblTitle.text = [NSString stringWithFormat:@"%@", attendee.name];
        cell.imgThumb.image = [Utility imageMFor:attendee.userId];
        if (attendee.userId.length > 0)
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([tableView isEqual:self.tUsers]) {
        User *usr = (User*)[self.arrUsers objectAtIndex:indexPath.row];
        NSDictionary *dicAttendee = @{kAttendeeName: [NSString stringWithFormat:@"%@ %@", usr.fname, usr.lname]
                                      , kAttendeeUserId: usr.userId
                                      , kAttendeeSession: self.session};
        Attendee *attendee = [[Attendance_DM sharedInstance] addAttendee:dicAttendee];
        [self.arrAttendees addObject:attendee];
        [self.arrUsers removeObject:usr];
        [self.tUsers reloadData];
        [self.tAttendees reloadData];

    }
}

#pragma mark - Table Editing

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tUsers])
        return NO;
    else
        return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // No editing style if not editing or the index path is nil.
    //    if (self.editing == NO || !indexPath)
    //        return UITableViewCellEditingStyleNone;
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeFromReviewWithIndexPath:indexPath];
    }
}

- (void)removeFromReviewWithIndexPath:(NSIndexPath*)indexPath {
    
    Attendee *attendee = (Attendee*)[self.arrAttendees objectAtIndex:indexPath.row];
    NSString *usrId = [Utility validString:attendee.userId];
    if ([usrId isEqualToString:@""] == NO) {
        User *usr = [[User_DM sharedInstance] userWithId:usrId];
        [self.arrUsers addObject:usr];
    }
    [[Attendance_DM sharedInstance] deleteAttendee:attendee];
    [self.arrAttendees removeObject:attendee];
    
    [self.tUsers reloadData];
    [self.tAttendees reloadData];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];

    if (textField.text.length > 3) {
        
        NSDictionary *dicAttendee = @{kAttendeeName: textField.text
                                      , kAttendeeUserId: @""
                                      , kAttendeeSession: self.session};
        Attendee *attendee = [[Attendance_DM sharedInstance] addAttendee:dicAttendee];
        [self.arrAttendees addObject:attendee];
        [self.tAttendees reloadData];
        textField.text = @"";
//        [textField becomeFirstResponder];
    }

    return YES;
}

@end

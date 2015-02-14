//
//  SessionVC.m
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "SessionVC.h"
#import "Session_DM.h"
#import "FeedbackVC.h"
#import "Session.h"
#import "SessionListCell.h"
#import "User.h"
#import "User_DM.h"
#import "AttendanceVC.h"

@interface SessionVC () <UIPopoverControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *txtSName;
@property (weak, nonatomic) IBOutlet UITextField *txtSType;
@property (weak, nonatomic) IBOutlet UITextField *txtSDateTime;
@property (weak, nonatomic) IBOutlet UITextField *txtSVenue;
@property (weak, nonatomic) IBOutlet UITextField *txtSBy;

@property (strong, nonatomic) NSArray *arrUsers;
@property (strong, nonatomic) NSMutableArray *arrSessions;
@property (strong, nonatomic) NSMutableArray *arrTableSessions;

@property (weak, nonatomic) IBOutlet UIView *vName;
@property (weak, nonatomic) IBOutlet UIView *vType;
@property (weak, nonatomic) IBOutlet UIView *vDT;
@property (weak, nonatomic) IBOutlet UIView *vVenue;
@property (weak, nonatomic) IBOutlet UIView *vBy;

@property (weak, nonatomic) IBOutlet UIButton *bAddSess;
@property (weak, nonatomic) IBOutlet UITableView *tSessions;
@property (weak, nonatomic) IBOutlet UILabel *lblAddSession;

@property (strong, nonatomic) UIPopoverController *pcDatePicker;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) UIPopoverController *pcUserPicker;
@property (strong, nonatomic) UIPickerView *userPicker;

@property (strong, nonatomic) Session *selectedRequestedSession;

@end

@implementation SessionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sessions";
    
    self.arrUsers = [[User_DM sharedInstance] getUsers];

    NSArray *sessions = [[Session_DM sharedInstance] getSessions];
    self.arrSessions = (sessions != nil) ? [sessions mutableCopy] : [@[] mutableCopy];
    [self groupSessions];
    [self.tSessions reloadData];

    User *usr = [[User_DM sharedInstance] loggedInUser];
    if ([usr.isAdmin boolValue] == YES) {
        self.lblAddSession.text = @"Add New Session";
        [self.bAddSess setTitle:@"Add Session" forState:UIControlStateNormal];
        self.vBy.hidden = NO;
        self.bAddSess.frame = CGRectMake(155, 518, self.bAddSess.frame.size.width, self.bAddSess.frame.size.height);
    }
    else {
        self.lblAddSession.text = @"Request for New Session";
        [self.bAddSess setTitle:@"Request Session" forState:UIControlStateNormal];
        self.vBy.hidden = YES;
        self.bAddSess.frame = CGRectMake(155, 443, self.bAddSess.frame.size.width, self.bAddSess.frame.size.height);
    }
    
    [self formatView];
}

- (void)formatView {
    
    CGFloat radius = 5.0;
    CGFloat borderWidth = 1.0;
    CGColorRef color = [UIColor lightGrayColor].CGColor;
    
    [[self.vName layer] setBorderColor:color];
    [[self.vName layer] setBorderWidth:borderWidth];
    [[self.vName layer] setCornerRadius:radius];
    
    [[self.vType layer] setBorderColor:color];
    [[self.vType layer] setBorderWidth:borderWidth];
    [[self.vType layer] setCornerRadius:radius];
    
    [[self.vDT layer] setBorderColor:color];
    [[self.vDT layer] setBorderWidth:borderWidth];
    [[self.vDT layer] setCornerRadius:radius];

    [[self.vVenue layer] setBorderColor:color];
    [[self.vVenue layer] setBorderWidth:borderWidth];
    [[self.vVenue layer] setCornerRadius:radius];

    [[self.vBy layer] setBorderColor:color];
    [[self.vBy layer] setBorderWidth:borderWidth];
    [[self.vBy layer] setCornerRadius:radius];
    
    [[self.bAddSess layer] setBorderColor:color];
    [[self.bAddSess layer] setBorderWidth:borderWidth];
    [[self.bAddSess layer] setCornerRadius:radius];

    [[self.tSessions layer] setBorderColor:color];
    [[self.tSessions layer] setBorderWidth:borderWidth];
    [[self.tSessions layer] setCornerRadius:radius];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dateChanged:(UIDatePicker*)dp {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:kSessionDateFormat];
    self.txtSDateTime.text = [NSString stringWithFormat:@"%@", [df stringFromDate:dp.date]];
}

- (IBAction)showUserPicker {

    [self dismissKeyboard];
    
    // dismiss existing popover
    if (self.pcUserPicker == nil) {
        
        UIView *v = [[UIView alloc] init];
        if (self.userPicker == nil) {
            CGRect pickerFrame = CGRectMake(0, 0, 320, 216);
            UIPickerView *pView = [[UIPickerView alloc] initWithFrame:pickerFrame];
            pView.delegate = self;
            pView.dataSource = self;
            self.userPicker = pView;
        }
        [v addSubview:self.userPicker];
        
        UIViewController *popoverContent = [[UIViewController alloc] init];
        popoverContent.view = v;
        popoverContent.preferredContentSize = CGSizeMake(320, 216);
        
        UIPopoverController *popoverControllerForUser = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        popoverControllerForUser.delegate = self;
        self.pcUserPicker = popoverControllerForUser;
    }

    if (![self.pcUserPicker isPopoverVisible]) {
        [self.pcUserPicker presentPopoverFromRect:self.vBy.frame
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    }

}

- (IBAction)showDatePicker {

    [self dismissKeyboard];

    // dismiss existing popover
    if (self.pcDatePicker == nil) {
        
        UIView *v = [[UIView alloc] init];
        if (self.datePicker == nil) {
            CGRect pickerFrame = CGRectMake(0, 0, 320, 216);
            UIDatePicker *pView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
            pView.datePickerMode = UIDatePickerModeDateAndTime;
            [pView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            self.datePicker = pView;
        }
        [v addSubview:self.datePicker];
        
        
        UIViewController *popoverContent = [[UIViewController alloc]init];
        popoverContent.view = v;
        popoverContent.preferredContentSize = CGSizeMake(320, 216);
        
        
        UIPopoverController *popoverControllerForDate = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        popoverControllerForDate.delegate = self;
        self.pcDatePicker = popoverControllerForDate;
    }

//    if (self.datePicker && ![self.txtSDateTime.text isEqualToString:@""]) {
//        NSDateFormatter *df = [NSDateFormatter new];
//        [df setDateFormat:kSessionDateFormat];
//        [self.datePicker setDate:[df dateFromString:self.txtSDateTime.text] animated:YES];
//    }
    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setYear:-1];
//    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//    [comps setYear:1];
//    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//    [self.datePicker setMaximumDate:maxDate];
    [self.datePicker setMinimumDate:[NSDate date]];
    
    if (![self.pcDatePicker isPopoverVisible]) {
        [self.pcDatePicker presentPopoverFromRect:self.vDT.frame
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    }
}

- (void)dismissKeyboard {
    if ([self.txtSName isFirstResponder])
        [self.txtSName resignFirstResponder];
    if ([self.txtSType isFirstResponder])
        [self.txtSType resignFirstResponder];
    if ([self.txtSDateTime isFirstResponder])
        [self.txtSDateTime resignFirstResponder];
    if ([self.txtSVenue isFirstResponder])
        [self.txtSVenue resignFirstResponder];
    if ([self.txtSBy isFirstResponder])
        [self.txtSBy resignFirstResponder];
}

- (IBAction)addSessionAction {

    [self dismissKeyboard];

    User *usr = [[User_DM sharedInstance] loggedInUser];

    if ([self.txtSName.text isEqualToString:@""])
        return;
    if ([self.txtSType.text isEqualToString:@""])
        return;
    if ([self.txtSDateTime.text isEqualToString:@""])
        return;
//    if ([self.txtSVenue isFirstResponder])
//        return;

    if ([self.txtSBy.text isEqualToString:@""] && self.selectedRequestedSession != nil && [usr.isAdmin boolValue])
        return;
    
    
    
    User *by = nil;
    if ([usr.isAdmin boolValue] && self.userPicker) {
        by = [self.arrUsers objectAtIndex:[self.userPicker selectedRowInComponent:0]];
    }
    
    NSDictionary *dicSession = @{
                                 kSessionUser: (by) ? by : [NSNull null]
                                 , kSessionRequestedUser: (self.selectedRequestedSession) ? [NSNull null] : usr
                                 , kSessionName: [Utility validString:self.txtSName.text]
                                 , kSessionType: [Utility validString:self.txtSType.text]
                                 , kSessionDateTime: [Utility validString:self.txtSDateTime.text]
                                 , kSessionVenue: [Utility validString:self.txtSVenue.text]
                                 , kSessionStatus: ([usr.isAdmin boolValue] == YES) ? [NSNumber numberWithInteger:SessionStatusUpcoming] : [NSNumber numberWithInteger:SessionStatusRequested]
                                 };
    
    if (self.selectedRequestedSession) {

        Session* sess = [[Session_DM sharedInstance] updateSession:dicSession withId:self.selectedRequestedSession.sessionId];
        if (sess) {
            [self.arrSessions removeObject:self.selectedRequestedSession];
            [self.arrSessions addObject:sess];
            self.selectedRequestedSession = nil;
        }
    }
    else {

        Session* sess = [[Session_DM sharedInstance] addSession:dicSession];
        if (sess) {
            [self.arrSessions addObject:sess];
        }
    }
    
    self.txtSName.text = @"";
    self.txtSType.text = @"";
    self.txtSDateTime.text = @"";
    self.txtSBy.text = @"";
    self.txtSVenue.text = @"";
    
    [self groupSessions];
    [self.tSessions reloadData];
    
    //        NSArray *sortedArray;
    //        sortedArray = [self.arrSessions sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    //            NSNumber *first = [(Session*)a status];
    //            NSNumber *second = [(Session*)b status];
    //            return [first compare:second];
    //        }];
    //        self.arrSessions = nil;
    //        self.arrSessions = [sortedArray mutableCopy];
}

- (void)groupSessions {

    NSMutableArray *arrH = [@[] mutableCopy];
    NSMutableArray *arrU = [@[] mutableCopy];
    NSMutableArray *arrR = [@[] mutableCopy];
    for (Session *s in self.arrSessions) {
        switch ([s.status integerValue]) {
            case SessionStatusHappend: [arrH addObject:s]; break;
            case SessionStatusUpcoming: [arrU addObject:s]; break;
            case SessionStatusRequested: [arrR addObject:s]; break;
        }
    }
    self.arrTableSessions = nil;
    self.arrTableSessions = [@[arrH, arrU, arrR] mutableCopy];
    arrH = arrU = arrR = nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrTableSessions.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SessionStatusHappend:
            return @"Happened (Select for Feedback)";
            break;
        case SessionStatusUpcoming:
            return @"Upcoming / Happening (Select for Feedback)";
            break;
        case SessionStatusRequested:
            return @"Requested (Select for Edit)";
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arrRows = [self.arrTableSessions objectAtIndex:section];
    if (arrRows) return arrRows.count;
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenity = @"SessionListCell";
    SessionListCell *cell = (SessionListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdenity];
    if (cell == nil) {
        UIViewController *controller = [[UIViewController alloc] initWithNibName:cellIdenity bundle:nil];
        cell = (SessionListCell*)controller.view;

        [cell.btnAddAttendees addTarget:self action:@selector(addAttendees:) forControlEvents:UIControlEventTouchUpInside];
    }
    Session *session = (Session*)[[self.arrTableSessions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.lblName.text = session.name;
    cell.lblType.text = session.type;
    cell.lblDateTime.text = [NSString stringWithFormat:@"%@", session.dateTime];
    if ([session.status integerValue]== SessionStatusUpcoming) {
        cell.btnAddAttendees.indexPath = indexPath;
        cell.btnAddAttendees.hidden = NO;
        cell.lblBy.text = [NSString stringWithFormat:@"by %@", session.user.fname];
    }
    else {
        cell.btnAddAttendees.hidden = YES;
        cell.lblBy.text = [NSString stringWithFormat:@"by %@", session.requestedUser.fname];
    }
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.selectedRequestedSession = nil;

    Session *ses = (Session*)[[self.arrTableSessions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([ses.status integerValue] == SessionStatusUpcoming) {
        FeedbackVC *fbvcObj = [[FeedbackVC alloc] initWithNibName:NSStringFromClass([FeedbackVC class]) bundle:nil];
        [fbvcObj setSession:ses];
        [self.navigationController pushViewController:fbvcObj animated:YES];
    }
    else if ([ses.status integerValue] == SessionStatusRequested) {

        self.selectedRequestedSession = ses;
        self.txtSName.text = ses.name;
        self.txtSType.text = ses.type;
        self.txtSDateTime.text = ses.dateTime;
        self.txtSVenue.text = ses.venue;
    }
}

#pragma mark - Table Editing

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    Session *ses = (Session*)[[self.arrTableSessions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([ses.status integerValue] == SessionStatusRequested && [ses.requestedUser.userId isEqualToString:[[User_DM sharedInstance] loggedInUserId]])
        return YES;
    
    return NO;
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
        [self deleteSessionWithIndexPath:indexPath];
    }
}

- (void)deleteSessionWithIndexPath:(NSIndexPath*)indexPath {
    
    NSMutableArray *arrSec = [self.arrTableSessions objectAtIndex:indexPath.section];
    Session *ses = (Session*)[arrSec objectAtIndex:indexPath.row];
    if ([ses.status integerValue] == SessionStatusRequested) {
    
        if (self.selectedRequestedSession && [ses.sessionId isEqualToString:self.selectedRequestedSession.sessionId]) {
            self.txtSName.text = @"";
            self.txtSType.text = @"";
            self.txtSDateTime.text = @"";
            self.txtSVenue.text = @"";
            self.txtSBy.text = @"";
        }
        
        [[Session_DM sharedInstance] deleteSessionWithId:ses.sessionId];

        [self.arrSessions removeObject:ses];
        [arrSec removeObject:ses];
        
//        NSLog(@"%p - %p", ses, self.selectedRequestedSession);
    }

    [self.tSessions deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    // [self.tSessions reloadData]; causing crash.
}


- (void)addAttendees:(TableButton*)btn {
    
    Session *ses = (Session*)[[self.arrTableSessions objectAtIndex:btn.indexPath.section] objectAtIndex:btn.indexPath.row];
    if ([ses.status integerValue] == SessionStatusUpcoming) {
        AttendanceVC *attObj = [[AttendanceVC alloc] initWithNibName:NSStringFromClass([AttendanceVC class]) bundle:nil];
        [attObj setSession:ses];
        [self.navigationController pushViewController:attObj animated:YES];
    }
}

#pragma mark - Picker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arrUsers.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    User *u = [self.arrUsers objectAtIndex:row];
    return [NSString stringWithFormat:@"%@ %@", u.fname, u.lname];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    User *u = [self.arrUsers objectAtIndex:row];
    self.txtSBy.text = [NSString stringWithFormat:@"%@ %@", u.fname, u.lname];

}

@end

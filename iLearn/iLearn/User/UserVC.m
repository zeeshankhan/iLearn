//
//  UserVC.m
//  iLearn
//
//  Created by Zeeshan Khan on 08/02/15.
//  Copyright (c) 2015 Zeeshan. All rights reserved.
//

#import "UserVC.h"
#import "User_DM.h"
#import "Session_DM.h"
#import "SessionListCell.h"
#import "Session.h"

@interface UserVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassowrd;

@property (weak, nonatomic) IBOutlet UIView *vFName;
@property (weak, nonatomic) IBOutlet UIView *vLName;
@property (weak, nonatomic) IBOutlet UIView *vPassword;

@property (weak, nonatomic) IBOutlet UIButton *bUpdate;
@property (weak, nonatomic) IBOutlet UITableView *tSessions;

@property (strong, nonatomic) NSMutableArray *arrSessions;
@property (strong, nonatomic) NSMutableArray *arrTableSessions;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"User Info";
    
    //NSArray *sessions = [[Session_DM sharedInstance] getSessions];
//    self.arrSessions = (sessions != nil) ? [sessions mutableCopy] : [@[] mutableCopy];
//    [self groupSessions];
//    [self.tSessions reloadData];
    
    User *usr = [[User_DM sharedInstance] loggedInUser];
    NSLog(@"usr sessions: %@", usr.session);
    if ([usr.isAdmin boolValue] == YES) {
    }
    
    [self formatView];
}

- (void)formatView {
    
    CGFloat radius = 5.0;
    CGFloat borderWidth = 1.0;
    CGColorRef color = [UIColor lightGrayColor].CGColor;
    
    [[self.vFName layer] setBorderColor:color];
    [[self.vFName layer] setBorderWidth:borderWidth];
    [[self.vFName layer] setCornerRadius:radius];
    
    [[self.vLName layer] setBorderColor:color];
    [[self.vLName layer] setBorderWidth:borderWidth];
    [[self.vLName layer] setCornerRadius:radius];
    
    [[self.vPassword layer] setBorderColor:color];
    [[self.vPassword layer] setBorderWidth:borderWidth];
    [[self.vPassword layer] setCornerRadius:radius];
    
    [[self.bUpdate layer] setBorderColor:color];
    [[self.bUpdate layer] setBorderWidth:borderWidth];
    [[self.bUpdate layer] setCornerRadius:radius];
    
    [[self.tSessions layer] setBorderColor:color];
    [[self.tSessions layer] setBorderWidth:borderWidth];
    [[self.tSessions layer] setCornerRadius:radius];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)groupSessions {
    
//    NSMutableArray *arrH = [@[] mutableCopy];
//    NSMutableArray *arrU = [@[] mutableCopy];
//    NSMutableArray *arrR = [@[] mutableCopy];
//    for (Session *s in self.arrSessions) {
//        switch ([s.status integerValue]) {
//            case SessionStatusHappend: [arrH addObject:s]; break;
//            case SessionStatusUpcoming: [arrU addObject:s]; break;
//            case SessionStatusRequested: [arrR addObject:s]; break;
//        }
//    }
//    self.arrTableSessions = nil;
//    self.arrTableSessions = [@[arrH, arrU, arrR] mutableCopy];
//    arrH = arrU = arrR = nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrTableSessions.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SessionStatusHappend:
            return @"Happened";
            break;
        case SessionStatusUpcoming:
            return @"Upcoming / Happening...";
            break;
        case SessionStatusRequested:
            return @"Requested";
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arrTableSessions objectAtIndex:section] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenity = @"SessionListCell";
    SessionListCell *cell = (SessionListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdenity];
    if (cell == nil) {
        UIViewController *controller = [[UIViewController alloc] initWithNibName:cellIdenity bundle:nil];
        cell = (SessionListCell*)controller.view;
        cell.btnAddAttendees.hidden = YES;
    }
    Session *session = (Session*)[[self.arrTableSessions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.lblName.text = session.name;
    cell.lblType.text = session.type;
    cell.lblDateTime.text = [NSString stringWithFormat:@"%@", session.dateTime];
    cell.lblBy.text = [NSString stringWithFormat:@"by %@", session.user.fname];
//    if ([session.status integerValue]== SessionStatusUpcoming) {
//        cell.btnAddAttendees.indexPath = indexPath;
//        cell.btnAddAttendees.hidden = NO;
//    }
//    else {
//        cell.btnAddAttendees.hidden = YES;
//    }
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

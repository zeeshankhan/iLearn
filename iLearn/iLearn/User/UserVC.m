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

@interface UserVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassowrd;

@property (weak, nonatomic) IBOutlet UIView *vFName;
@property (weak, nonatomic) IBOutlet UIView *vLName;
@property (weak, nonatomic) IBOutlet UIView *vPassword;

@property (weak, nonatomic) IBOutlet UIButton *bPhoto;
@property (strong, nonatomic) UIPopoverController *imgPopover;

@property (weak, nonatomic) IBOutlet UIButton *bUpdate;
@property (weak, nonatomic) IBOutlet UITableView *tSessions;

@property (strong, nonatomic) NSMutableArray *arrSessions;
@property (strong, nonatomic) NSMutableArray *arrTableSessions;
@property (strong, nonatomic) NSDictionary *dicThumb;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"User Info";
    
    User *usr = [[User_DM sharedInstance] loggedInUser];
    
    self.txtFName.text = usr.fname;
    self.txtLName.text = usr.lname;
    self.txtPassowrd.text = usr.password;
    [self.bPhoto setImage:[Utility imageMFor:usr.userId] forState:UIControlStateNormal];
    
    NSArray *sessions = [usr.sessions allObjects];
    for (Session *s in sessions) {
        NSLog(@"Session %@", s.name);
    }

    self.arrSessions = (sessions != nil) ? [sessions mutableCopy] : [@[] mutableCopy];

    sessions = [usr.requestedSessions allObjects];
    for (Session *s in sessions) {
        NSLog(@"Req Session %@", s.name);
    }
    
    if (sessions.count>0) {
        [self.arrSessions addObjectsFromArray:sessions];
    }
    
    [self groupSessions];
    [self.tSessions reloadData];
    
    for (UIView *v in self.navigationController.navigationBar.subviews) {
        if (v.tag == kNavItemTag) {
            v.hidden = YES;
        }
    }
    
    [self formatView];
}

- (void)viewWillDisappear:(BOOL)animated {
    for (UIView *v in self.navigationController.navigationBar.subviews) {
        if (v.tag == kNavItemTag) {
            v.hidden = NO;
        }
    }
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
    
    [[self.bPhoto layer] setBorderColor:color];
    //    [[self.bPhoto layer] setBorderWidth:2];
    //    [[self.bPhoto layer] setCornerRadius:self.bPhoto.frame.size.width / 2];
    [[self.bPhoto layer] setBorderWidth:borderWidth];
    [[self.bPhoto layer] setCornerRadius:radius];
    self.bPhoto.clipsToBounds = YES;
    
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
            return @"Given Session";
            break;
        case SessionStatusUpcoming:
            return @"Upcoming Sessions";
            break;
        case SessionStatusRequested:
            return @"Requested Session";
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

- (IBAction)updateAction {

    [self dismissKeyboard];
    
    NSString *fname = [Utility validString:self.txtFName.text];
    if ([fname isEqualToString:@""]) {
        NSLog(@"First name is a mandatory field.");
        return;
    }
    
    NSString *lname = [Utility validString:self.txtLName.text];
    if ([lname isEqualToString:@""]) {
        NSLog(@"Last name is a mandatory field.");
        return;
    }

    NSString *pw = [Utility validString:self.txtPassowrd.text];
    if ([pw isEqualToString:@""]) {
        NSLog(@"Password name is a mandatory field.");
        return;
    }

    User *usr = [[User_DM sharedInstance] loggedInUser];
    if (self.dicThumb) {
        UIImage *image = [self.dicThumb objectForKey:@"UIImagePickerControllerOriginalImage"];
        [Utility saveThumb:image withName:usr.userId];
    }
    
    for (UIView *v in self.navigationController.navigationBar.subviews) {
        if (v.tag == kNavItemTag && [v isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)v;
            [btn setImage:[Utility imageSFor:usr.userId] forState:UIControlStateNormal];
            break;
        }
    }
    
    NSDictionary *dicUser = @{kUserId: usr.userId
                              , kUserPassword: pw
                              , kUserFirstName: fname
                              , kUserLastName: lname
                              };
    
    usr = [[User_DM sharedInstance] updateUser:dicUser];
    [[User_DM sharedInstance] setLoggedInUser:usr];
    
    NSLog(@"User updated into database.");
}

- (void)dismissKeyboard {
    
    if ([self.txtFName isFirstResponder])
        [self.txtFName resignFirstResponder];
    if ([self.txtLName isFirstResponder])
        [self.txtLName resignFirstResponder];
    if ([self.txtPassowrd isFirstResponder])
        [self.txtPassowrd resignFirstResponder];
}

- (IBAction)addPhotoAction {
    
    [self dismissKeyboard];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
#if TARGET_IPHONE_SIMULATOR
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        imagePicker.sourceType =  sourceType;
        imagePicker.delegate = self;
        //        imagePicker.wantsFullScreenLayout = YES;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        
#if TARGET_IPHONE_SIMULATOR
        if (self.imgPopover == nil)
            self.imgPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [self.imgPopover presentPopoverFromRect:CGRectMake(10, 10, 10, 10) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#else
        [self presentViewController:imagePicker animated:YES completion:NULL];
#endif
        
    }
    else {
        NSLog(@"Camera Required");
    }
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
#if TARGET_IPHONE_SIMULATOR
    if (self.imgPopover != nil && [self.imgPopover isPopoverVisible])
        [self.imgPopover dismissPopoverAnimated:YES];
#else
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
#endif
    
    self.dicThumb = info;
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (image != nil) {
        [self.bPhoto setImage:[image scaleImageProportionallyToSize:ThumbSizeL] forState:UIControlStateNormal];
        [self.bPhoto setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        NSLog(@"Image from picker is nil.");
    }
}


@end

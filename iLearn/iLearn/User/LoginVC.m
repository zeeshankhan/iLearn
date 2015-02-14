//
//  LoginVC.m
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "LoginVC.h"
#import "User.h"
#import "User_DM.h"
#import "SessionVC.h"
#import "Feedback.h"
#import "UserVC.h"

@interface LoginVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUserid;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UIView *vLogin;
@property (weak, nonatomic) IBOutlet UIView *vRegister;
@property (weak, nonatomic) IBOutlet UIButton *bLogin;
@property (weak, nonatomic) IBOutlet UIButton *bRegister;

@property (strong, nonatomic) UIImageView *navThumb;
@property (strong, nonatomic) UIButton *navBtn;
@property (strong, nonatomic) UILabel *navName;
@property (weak, nonatomic) IBOutlet UIButton *bPhoto;

@property (strong, nonatomic) UIPopoverController *imgPopover;
@property (weak, nonatomic) IBOutlet UISwitch *switchMember;
@property (weak, nonatomic) IBOutlet UILabel *lblWarning;
@property (strong, nonatomic) NSDictionary *dicThumb;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self notAMemberAction:self.switchMember];
    
    [self.txtUserid becomeFirstResponder];
//    self.txtUserid.text = @"E20043650";
//    self.txtPassword.text = @"123456";

    self.txtUserid.text = @"111";
    self.txtPassword.text = @"111";

//    [[User_DM sharedInstance] populateUsersFromList];
    
    [self formatView];
}

- (void)formatView {
    
    CGFloat radius = 5.0;
    CGFloat borderWidth = 1.0;
    CGColorRef color = [UIColor whiteColor].CGColor;
    
    [[self.vLogin layer] setBorderColor:color];
    [[self.vLogin layer] setBorderWidth:borderWidth];
    [[self.vLogin layer] setCornerRadius:radius];

    [[self.vRegister layer] setBorderColor:color];
    [[self.vRegister layer] setBorderWidth:borderWidth];
    [[self.vRegister layer] setCornerRadius:radius];

    [[self.bLogin layer] setBorderColor:color];
    [[self.bLogin layer] setBorderWidth:borderWidth];
    [[self.bLogin layer] setCornerRadius:radius];

    [[self.bRegister layer] setBorderColor:color];
    [[self.bRegister layer] setBorderWidth:borderWidth];
    [[self.bRegister layer] setCornerRadius:radius];

    [[self.bPhoto layer] setBorderColor:color];
//    [[self.bPhoto layer] setBorderWidth:2];
//    [[self.bPhoto layer] setCornerRadius:self.bPhoto.frame.size.width / 2];
    [[self.bPhoto layer] setBorderWidth:borderWidth];
    [[self.bPhoto layer] setCornerRadius:radius];
    self.bPhoto.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Login";
    if (self.navName) self.navName.hidden = YES;
    if (self.navThumb) self.navThumb.hidden = YES;
    if (self.navBtn) self.navBtn.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.title = @"Sign Out";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dismissKeyboard {

    if ([self.txtUserid isFirstResponder])
        [self.txtUserid resignFirstResponder];
    if ([self.txtPassword isFirstResponder])
        [self.txtPassword resignFirstResponder];
    if ([self.txtFirstName isFirstResponder])
        [self.txtFirstName resignFirstResponder];
    if ([self.txtLastName isFirstResponder])
        [self.txtLastName resignFirstResponder];

}

- (IBAction)loginAction {

    [self dismissKeyboard];
    
    NSString *strUserId = [[Utility validString:self.txtUserid.text] lowercaseString];
    NSString *strPassword = [Utility validString:self.txtPassword.text];
    if ([strUserId isEqualToString:@""] || [strPassword isEqualToString:@""]) {
        NSLog(@"User id and password are mandatory field.");
        return;
    }

    User *usr = [[User_DM sharedInstance] userWithId:strUserId];
    if (usr == nil) {
        NSLog(@"User Does not exist.");
    }
    else {
        
        if ([strPassword isEqualToString:usr.password]) {
            NSLog(@"User Exist %@ %@", usr.fname, usr.lname);
            [[User_DM sharedInstance] setLoggedInUser:usr];
            [self showLoginDetails];
            [self gotoSessions];
        }
        
    }
}

- (IBAction)notAMemberAction:(UISwitch *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{

        self.bLogin.alpha = !sender.isOn;
        self.vRegister.alpha = sender.isOn;
        self.bRegister.alpha = sender.isOn;
        self.bPhoto.alpha = sender.isOn;
        
        self.title = (sender.isOn) ? @"Register" : @"Login";
        
    }];
}

- (IBAction)registerAction {

    [self dismissKeyboard];

    NSString *strUserId = [[Utility validString:self.txtUserid.text] lowercaseString];
    NSString *strPassword = [Utility validString:self.txtPassword.text];
    if ([strUserId isEqualToString:@""] || [strPassword isEqualToString:@""]) {
        NSLog(@"User id and password are mandatory field.");
        return;
    }
    
    User *usr = [[User_DM sharedInstance] userWithId:strUserId];
    if (usr == nil) {

        if (self.dicThumb) {
            UIImage *image = [self.dicThumb objectForKey:@"UIImagePickerControllerOriginalImage"];
            [Utility saveThumb:image withName:self.txtUserid.text];
        }

        NSDictionary *dicUser = @{kUserId: strUserId
                                  , kUserPassword: [Utility validString:self.txtPassword.text]
                                  , kUserFirstName: [Utility validString:self.txtFirstName.text]
                                  , kUserLastName: [Utility validString:self.txtLastName.text]
                                  , kUserPicPath: @""
                                  , kUserIsAdmin: ([strUserId isEqualToString:@"e20043650"]) ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO]
                                  };
        
        usr = [[User_DM sharedInstance] addUser:dicUser];
        [[User_DM sharedInstance] setLoggedInUser:usr];

        NSLog(@"User added into database.");
        
        self.txtFirstName.text = @"";
        self.txtLastName.text = @"";
        [self.bPhoto setImage:nil forState:UIControlStateNormal];
        [self.switchMember setOn:NO];
        [self notAMemberAction:self.switchMember];
        
        [self showLoginDetails];
        [self gotoSessions];
    }
    else {
        NSLog(@"User Exist.");
    }
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

- (void)editUser {
    
    UserVC *obj = [[UserVC alloc] initWithNibName:@"UserVC" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)showLoginDetails {
    
//    if (self.navThumb == nil) {
//        CGSize s = ThumbSizeM;
//        UIImageView *imgThumb = [[UIImageView alloc] initWithFrame:CGRectMake(980, 4, s.width, s.height)];
//        [self.navigationController.navigationBar addSubview:imgThumb];
//        self.navThumb = imgThumb;
//        [[self.navThumb layer] setBorderColor:[UIColor whiteColor].CGColor];
//        [[self.navThumb layer] setBorderWidth:0.8];
//        [[self.navThumb layer] setCornerRadius:4];
//        [[self.navThumb layer] setMasksToBounds:YES];
//        
//    }

    if (self.navBtn == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = kNavItemTag;
//        [btn setBackgroundColor:[UIColor clearColor]];
        CGSize s = ThumbSizeM;
        [btn setFrame:CGRectMake(980, 4, s.width, s.height)];
        [btn addTarget:self action:@selector(editUser) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:btn];
        
        self.navBtn = btn;
        [[self.navBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
        [[self.navBtn layer] setBorderWidth:0.8];
        [[self.navBtn layer] setCornerRadius:4];
        [[self.navBtn layer] setMasksToBounds:YES];
    }
    
    User *usr = [[User_DM sharedInstance] loggedInUser];
//    self.navThumb.image = [Utility imageSFor:usr.userId];
//    self.navThumb.frame = CGRectMake(self.navThumb.frame.origin.x, self.navThumb.frame.origin.y, ThumbSizeS.width, ThumbSizeS.height);
//    self.navThumb.hidden = NO;

    [self.navBtn setImage:[Utility imageSFor:usr.userId] forState:UIControlStateNormal];
    self.navBtn.frame = CGRectMake(self.navBtn.frame.origin.x, self.navBtn.frame.origin.y, ThumbSizeS.width, ThumbSizeS.height);
    self.navBtn.hidden = NO;

    
    if (self.navName == nil) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(655, 10, 320, 25)];
        lbl.tag = kNavItemTag;
        lbl.textAlignment = NSTextAlignmentRight;
        lbl.font = [UIFont fontWithName:@"Futura" size:15];
        [self.navigationController.navigationBar addSubview:lbl];
        self.navName = lbl;
    }
    self.navName.text = [NSString stringWithFormat:@"Hi, %@", [[[User_DM sharedInstance] loggedInUser] fname]];
    self.navName.hidden = NO;
}

- (void)gotoSessions {
    
//    [self editUser];
//    return;
//
    SessionVC *sessvcObj = [[SessionVC alloc] initWithNibName:NSStringFromClass([SessionVC class]) bundle:nil];
    [self.navigationController pushViewController:sessvcObj animated:YES];
}


@end

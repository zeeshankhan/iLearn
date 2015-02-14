//
//  FeedbackVC.m
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "FeedbackVC.h"
#import "Feedback_DM.h"
#import "Feedback.h"
#import "SessionListCell.h"
#import "User.h"
#import "Session.h"

@interface FeedbackVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segOverallRating;
@property (weak, nonatomic) IBOutlet UITextView *txtViewCommSkills;
@property (weak, nonatomic) IBOutlet UITextView *txtViewTopicKnow;
@property (weak, nonatomic) IBOutlet UITextView *txtViewBestThing;
@property (weak, nonatomic) IBOutlet UITextView *txtViewBadThings;
@property (strong, nonatomic) NSMutableArray *arrFeedbacks;

@property (weak, nonatomic) IBOutlet UIButton *bAddFB;
@property (weak, nonatomic) IBOutlet UITableView *tFeedbacks;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewFeedback;
@property (weak, nonatomic) IBOutlet UISwitch *anonymousSwitch;

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feedback";
    NSArray *feedbacks = [[Feedback_DM sharedInstance] getFeedbacksForSessionId:self.session.sessionId];
    self.arrFeedbacks = (feedbacks != nil) ? [feedbacks mutableCopy] : [@[] mutableCopy];
    
    self.lblTitle.text = self.session.name;
    [self formatView];
    
    self.scrollViewFeedback.contentSize = CGSizeMake(500, 610);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    
    CGRect keyboardEndFrame;
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame fromView:nil];
    
    float newScrollViewHeight;
    float viewHeight = self.scrollViewFeedback.frame.size.height;
    
    //NSLog(@"view Height: %.1f",viewHeight);
    if (CGRectIntersectsRect(keyboardFrame, self.view.frame)) { // Keyboard is visible
        
        //NSLog(@"visible: %@",NSStringFromCGRect(keyboardFrame));
        
        int keyboardHeight = keyboardFrame.size.height;
        int keyboardY = keyboardFrame.origin.y;
        switch (keyboardHeight)
        {
            case 216: //NSLog(@"Split");
                newScrollViewHeight = viewHeight;
                break;
                
            case 264: //NSLog(@"Portrait"); //(viewHeight - keyboardHeight + 44); //
                newScrollViewHeight = keyboardY - self.scrollViewFeedback.frame.origin.y - 10;
                break;
                
            case 352: //NSLog(@"Landscape");
                newScrollViewHeight = keyboardY - self.scrollViewFeedback.frame.origin.y - 10;
                break;
                
            default: NSLog(@"Unknown");
                break;
        }
    }
    else { // Keyboard is hidden
        //NSLog(@"hidden: %@",NSStringFromCGRect(keyboardFrame));
        newScrollViewHeight = 565.0;
    }
    
    CGRect svFrame = self.scrollViewFeedback.frame;
    svFrame.size.height = newScrollViewHeight;
    [self.scrollViewFeedback setFrame:svFrame];
    NSLog(@"%@",NSStringFromCGRect(svFrame));
    
    if ([self.txtViewCommSkills isFirstResponder])
        [self.scrollViewFeedback scrollRectToVisible:self.txtViewCommSkills.frame animated:YES];
    if ([self.txtViewTopicKnow isFirstResponder])
        [self.scrollViewFeedback scrollRectToVisible:self.txtViewTopicKnow.frame animated:YES];
    if ([self.txtViewBestThing isFirstResponder])
        [self.scrollViewFeedback scrollRectToVisible:self.txtViewBestThing.frame animated:YES];
    if ([self.txtViewBadThings isFirstResponder])
        [self.scrollViewFeedback scrollRectToVisible:self.txtViewBadThings.frame animated:YES];
    
}


- (void)formatView {
    
    CGFloat radius = 5.0;
    CGFloat borderWidth = 1.0;
    CGColorRef color = [UIColor lightGrayColor].CGColor;
    
    [[self.txtViewCommSkills layer] setBorderColor:color];
    [[self.txtViewCommSkills layer] setBorderWidth:borderWidth];
    [[self.txtViewCommSkills layer] setCornerRadius:radius];
    
    [[self.txtViewTopicKnow layer] setBorderColor:color];
    [[self.txtViewTopicKnow layer] setBorderWidth:borderWidth];
    [[self.txtViewTopicKnow layer] setCornerRadius:radius];
    
    [[self.txtViewBestThing layer] setBorderColor:color];
    [[self.txtViewBestThing layer] setBorderWidth:borderWidth];
    [[self.txtViewBestThing layer] setCornerRadius:radius];
    
    [[self.txtViewBadThings layer] setBorderColor:color];
    [[self.txtViewBadThings layer] setBorderWidth:borderWidth];
    [[self.txtViewBadThings layer] setCornerRadius:radius];
    
    [[self.bAddFB layer] setBorderColor:color];
    [[self.bAddFB layer] setBorderWidth:borderWidth];
    [[self.bAddFB layer] setCornerRadius:radius];
    
    [[self.tFeedbacks layer] setBorderColor:color];
    [[self.tFeedbacks layer] setBorderWidth:borderWidth];
    [[self.tFeedbacks layer] setCornerRadius:radius];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissKeyboard {

    if ([self.txtViewCommSkills isFirstResponder])
        [self.txtViewCommSkills resignFirstResponder];
    if ([self.txtViewTopicKnow isFirstResponder])
        [self.txtViewTopicKnow resignFirstResponder];
    if ([self.txtViewBestThing isFirstResponder])
        [self.txtViewBestThing resignFirstResponder];
    if ([self.txtViewBadThings isFirstResponder])
        [self.txtViewBadThings resignFirstResponder];

}

- (IBAction)submitFeedbackAction {

    if ([self.txtViewCommSkills.text isEqualToString:@""])
        return;
    if ([self.txtViewTopicKnow.text isEqualToString:@""])
        return;
    if ([self.txtViewBestThing.text isEqualToString:@""])
        return;
    if ([self.txtViewBadThings.text isEqualToString:@""])
        return;

    
    [self dismissKeyboard];
    
    NSDictionary *dicFeedback = @{
                                  kFeedbackOverallRating: [NSNumber numberWithInteger:self.segOverallRating.selectedSegmentIndex]
                                  , kFeedbackCommuSkills: [Utility validString:self.txtViewCommSkills.text]
                                  , kFeedbackTopicKnow: [Utility validString:self.txtViewTopicKnow.text]
                                  , kFeedbackBestThings: [Utility validString:self.txtViewBestThing.text]
                                  , kFeedbackBadThings: [Utility validString:self.txtViewBadThings.text]
                                  , kFeedbackSession : self.session
                                  , kFeedbackAnonymous : [NSNumber numberWithBool:self.anonymousSwitch.isOn]
                                  };

    Feedback *fb = [[Feedback_DM sharedInstance] addFeedback:dicFeedback];
    
    if (fb) {
        [self.arrFeedbacks addObject:fb];

        NSArray *sortedArray;
        sortedArray = [self.arrFeedbacks sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber *first = [(Feedback*)a overallRating];
            NSNumber *second = [(Feedback*)b overallRating];
            return [first compare:second];
        }];
        self.arrFeedbacks = nil;
        self.arrFeedbacks = [sortedArray mutableCopy];
        [self.tFeedbacks reloadData];
        
        self.txtViewCommSkills.text = @"";
        self.txtViewTopicKnow.text = @"";
        self.txtViewBestThing.text = @"";
        self.txtViewBadThings.text = @"";
    }

}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrFeedbacks.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenity = @"SessionListCell";
    SessionListCell *cell = (SessionListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdenity];
    if (cell == nil) {
        UIViewController *controller = [[UIViewController alloc] initWithNibName:cellIdenity bundle:nil];
        cell = (SessionListCell*)controller.view;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    Feedback *feedback = (Feedback*)[self.arrFeedbacks objectAtIndex:indexPath.row];
    cell.lblName.text = [Feedback_DM getRatingFromEnum:[feedback.overallRating integerValue]];
    cell.lblType.text = feedback.bestThings;
    cell.lblDateTime.text = feedback.badThings;
    if ([feedback.isAnonymous boolValue] == YES)
        cell.lblBy.text = @"by Anonymous";
    else
        cell.lblBy.text = [NSString stringWithFormat:@"by %@", feedback.user.fname];
    cell.btnAddAttendees.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    FeedbackVC *fbvcObj = [[FeedbackVC alloc] initWithNibName:NSStringFromClass([FeedbackVC class]) bundle:nil];
//    [fbvcObj setSession:(Session*)[self.arrFeedbacks objectAtIndex:indexPath.row]];
//    [self.navigationController pushViewController:fbvcObj animated:YES];
}


@end

//
//  Feedback_DM.m
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "Feedback_DM.h"
#import "Feedback.h"
#import "User_DM.h"
#import "Session.h"

@implementation Feedback_DM

+ (instancetype)sharedInstance {
    static Feedback_DM *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Feedback_DM new];
    });
    return instance;
}

- (NSArray*)getFeedbacks {

    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Feedback class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    //    [fetchRequest setResultType:resultType];
    //    [fetchRequest setReturnsDistinctResults:YES];
    //    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"__ATTRIBUTE_NAME__"]];
    
    //    NSPredicate *predicate = [self predicateWithAction:action andActivityID:activityId];
    //    if (predicate != nil)
    //        [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *arrResult = [[[DBManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"GET Users Error: %@", error.debugDescription);
    }
    
    return arrResult;

}

- (NSArray*)getFeedbacksForSessionId:(NSString*)sessionId {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Feedback class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    [fetchRequest setResultType:NSManagedObjectResultType];
    //    [fetchRequest setReturnsDistinctResults:YES];
    //    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"__ATTRIBUTE_NAME__"]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session.sessionId == %@", sessionId ];
    if (predicate != nil)
        [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *arrResult = [[[DBManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"GET Users Error: %@", error.debugDescription);
    }
    
    return arrResult;
}

- (Feedback*)addFeedback:(NSDictionary*)dicFeedback {
    
    if (dicFeedback == nil) {
        NSLog(@"Feedback dictionary is nil.");
    }
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([Feedback class]) inManagedObjectContext:context];
    
    Feedback *row = (Feedback*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    if (row) {
        row.user = [[User_DM sharedInstance] loggedInUser];
        Session *sess = (Session*)[dicFeedback objectForKey:kFeedbackSession];
        row.session = sess;
        row.feedbackId = [NSString stringWithFormat:@"Feedback_%@_%@", sess.sessionId, row.user.userId];
        row.overallRating = dicFeedback[kFeedbackOverallRating];
        row.communicationSkills = dicFeedback[kFeedbackCommuSkills];
        row.topicKnowledge = dicFeedback[kFeedbackTopicKnow];
        row.bestThings = dicFeedback[kFeedbackBestThings];
        row.badThings = dicFeedback[kFeedbackBadThings];
        row.isAnonymous = dicFeedback[kFeedbackAnonymous];
        
    }
    else {
        NSLog(@"CoreData Error: Unable to insert row, Feedback row is nil.");
    }
    
    [[DBManager sharedInstance] saveContext];
    NSLog(@"Feedback Added into data base.");
    return row;
}

+ (NSString*)getRatingFromEnum:(Rating)rating {
    NSString *strRating;
    switch (rating) {
        case Excellent: strRating = @"Excellent"; break;
        case Good: strRating = @"Good"; break;
        case Average: strRating = @"Average"; break;
        case Bad: strRating = @"Bad"; break;
        case Worst: strRating = @"Worst"; break;
        default: strRating = @"Good"; break;
    }
    return strRating;
}

- (void)updateFeedback:(NSDictionary*)dicFeedback {

}

@end

//
//  Feedback.h
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Feedback : NSManagedObject

@property (nonatomic, retain) NSString * feedbackId;
@property (nonatomic, retain) NSNumber * overallRating;
@property (nonatomic, retain) NSNumber * isAnonymous;
@property (nonatomic, retain) NSString * communicationSkills;
@property (nonatomic, retain) NSString * topicKnowledge;
@property (nonatomic, retain) NSString * bestThings;
@property (nonatomic, retain) NSString * badThings;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSManagedObject *session;

@end

//
//  Session.h
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Feedback, User, Attendee;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * dateTime;
@property (nonatomic, retain) NSString * venue;
@property (nonatomic, retain) NSNumber *status;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *feedbacks;
@property (nonatomic, retain) NSSet *attendees;

@end

@interface Session (CoreDataGeneratedAccessors)

- (void)addFeedbacksObject:(Feedback *)value;
- (void)removeFeedbacksObject:(Feedback *)value;
- (void)addFeedbacks:(NSSet *)values;
- (void)removeFeedbacks:(NSSet *)values;

@end

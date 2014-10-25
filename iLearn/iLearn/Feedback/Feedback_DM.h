//
//  Feedback_DM.h
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFeedbackId                                 @"FeedbackId"
#define kFeedbackOverallRating                 @"OverallRating"
#define kFeedbackCommuSkills                  @"CommunicationSkills"
#define kFeedbackTopicKnow                      @"TopicKnowledge"
#define kFeedbackBestThings                     @"BestThings"
#define kFeedbackBadThings                      @"BadThings"
#define kFeedbackUser                               @"User"
#define kFeedbackSession                          @"Session"
#define kFeedbackAnonymous                          @"Anonymous"

typedef NS_ENUM(NSUInteger, Rating) {
    Worst,
    Bad,
    Average,
    Good,
    Excellent
};

@class Feedback;
@interface Feedback_DM : NSObject

+ (instancetype)sharedInstance;

- (NSArray*)getFeedbacks;
- (NSArray*)getFeedbacksForSessionId:(NSString*)sessionId;
- (Feedback*)addFeedback:(NSDictionary*)dicFeedback;
- (void)updateFeedback:(NSDictionary*)dicFeedback;
+ (NSString*)getRatingFromEnum:(Rating)rating;

@end

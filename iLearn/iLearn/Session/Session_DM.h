//
//  Session_DM.h
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSessionId                          @"SessionId"
#define kSessionName                     @"SessionName"
#define kSessionType                       @"SessionType"
#define kSessionDateTime                @"SessionDateTime"
#define kSessionVenue                     @"SessionVenue"
#define kSessionUser                       @"SessionUser"
#define kSessionRequestedUser        @"SessionRequestedUser"
#define kSessionFeedbacks               @"SessionFeedbacks"
#define kSessionStatus                     @"SessionStatus"

#define kSessionDateFormat @"EEEE hh:mm a MMM dd"

typedef NS_ENUM(NSUInteger, SessionStatus) {
    SessionStatusHappend = 0,
    SessionStatusUpcoming,
    SessionStatusRequested,
};

@class Session;
@interface Session_DM : NSObject

+ (instancetype)sharedInstance;

- (NSArray*)getSessions;
- (NSArray*)getSessionsForUserId:(NSString*)userId;
- (Session*)addSession:(NSDictionary*)dicSession;
- (Session*)updateSession:(NSDictionary*)dicSession withId:(NSString*)sessionId;
- (void)deleteSessionWithId:(NSString*)sessId;

@end


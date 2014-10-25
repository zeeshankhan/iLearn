//
//  Attendance_DM.h
//  iLearn
//
//  Created by Zeeshan Khan on 25/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAttendeeName @"AttendeeName"
#define kAttendeeId @"AttendeeId"
#define kAttendeeUserId @"AttendeeUserId"
#define kAttendeeSession @"AttendeeSession"

@class Attendee;
@interface Attendance_DM : NSObject

+ (instancetype)sharedInstance;
- (NSArray*)getAttendees;
- (Attendee*)addAttendee:(NSDictionary*)dicAttendee;
- (NSArray*)getAttendeesForSession:(NSString*)sessionId;

@end

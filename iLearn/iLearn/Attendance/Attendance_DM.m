//
//  Attendance_DM.m
//  iLearn
//
//  Created by Zeeshan Khan on 25/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "Attendance_DM.h"
#import "Attendee.h"
#import "Session.h"

@implementation Attendance_DM

+ (instancetype)sharedInstance {
    
    static Attendance_DM *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Attendance_DM new];
    });
    return instance;
    
}

- (NSArray*)getAttendees {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Attendee class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
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
        NSLog(@"GET Attendees Error: %@", error.debugDescription);
    }
    
    return arrResult;
}

- (NSArray*)getAttendeesForSession:(NSString*)sessionId {

    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Attendee class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    //    [fetchRequest setResultType:resultType];
    //    [fetchRequest setReturnsDistinctResults:YES];
    //    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"__ATTRIBUTE_NAME__"]];
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session.sessionId == %@", sessionId ];
        if (predicate != nil)
            [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *arrResult = [[[DBManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"GET Attendees Error: %@", error.debugDescription);
    }
    
    return arrResult;

}

- (Attendee*)addAttendee:(NSDictionary*)dicAttendee {
    
    if (dicAttendee == nil) {
        NSLog(@"Attendee dictionary is nil.");
    }
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([Attendee class]) inManagedObjectContext:context];
    
    Attendee *row = (Attendee*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    if (row) {
        row.session = [dicAttendee objectForKey:kAttendeeSession];
        row.userId = [Utility validString:[dicAttendee objectForKey:kAttendeeUserId]];
        row.name = [Utility validString:[dicAttendee objectForKey:kAttendeeName]];
        row.attendeeId = [NSString stringWithFormat:@"%@_%@", row.session.name, row.name];
    }
    else {
        NSLog(@"CoreData Error: Unable to insert row, Attendee row is nil.");
    }
    
    [[DBManager sharedInstance] saveContext];
    NSLog(@"Attendee Added into data base.");
    return row;
}

@end
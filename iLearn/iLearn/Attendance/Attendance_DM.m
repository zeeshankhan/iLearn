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
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session.sessionId CONTAINS %@", sessionId ];
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
        Session *ses = [dicAttendee objectForKey:kAttendeeSession];
        row.session = [NSSet setWithObject:ses];
        row.userId = [Utility validString:[dicAttendee objectForKey:kAttendeeUserId]];
        NSString *n = [Utility validString:[dicAttendee objectForKey:kAttendeeName]];
        row.name = n;

        NSString *idx = [NSString stringWithFormat:@"%@_%@", ses.name, row.name];
        row.attendeeId = idx;
        
        if ([row.userId isEqualToString:@""]) {
            [self saveAttendeeImageWithName:n forId:idx];
        }
    }
    else {
        NSLog(@"CoreData Error: Unable to insert row, Attendee row is nil.");
    }
    
    [[DBManager sharedInstance] saveContext];
    NSLog(@"Attendee Added into data base.");
    return row;
}

- (void)saveAttendeeImageWithName:(NSString*)name forId:(NSString*)strId {

    UIImage *imgUsr = [UIImage imageNamed:strId];
    if (imgUsr == nil) {
        NSArray *arrN = [name componentsSeparatedByString:@" "];
        NSString *fn = @"";
        int x=0;
        for (NSString* n in arrN) {
            fn = [NSString stringWithFormat:@"%@%@", fn, (n.length>1)?[n substringToIndex:1]:n];
            if (++x == 3) break;
        }
        imgUsr = [Utility imageWithText:fn];
    }
    
    [Utility saveThumb:imgUsr withName:strId];
}

- (void)deleteAttendee:(Attendee*)attendee {
    
    if (attendee == nil) {
        NSLog(@"Attendee Object is nil.");
    }
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    [context deleteObject:attendee];
    
    [[DBManager sharedInstance] saveContext];
    NSLog(@"Attendee deleted from data base.");
}


@end

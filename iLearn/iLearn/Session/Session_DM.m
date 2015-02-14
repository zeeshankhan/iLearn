//
//  Session_DM.m
//  iLearn
//
//  Created by Zeeshan Khan on 18/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "Session_DM.h"
#import "User_DM.h"
#import "Session.h"

@implementation Session_DM

+ (instancetype)sharedInstance {

    static Session_DM *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Session_DM new];
    });
    return instance;

}

- (NSArray*)getSessions {
    return [self getSessionsWithId:nil];
}

- (NSArray*)getSessionsWithId:(NSString*)sessId {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Session class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    //    [fetchRequest setResultType:resultType];
    //    [fetchRequest setReturnsDistinctResults:YES];
    //    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"__ATTRIBUTE_NAME__"]];

    if (sessId != nil && ![sessId isEqualToString:@""]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sessionId = %@", sessId];
        if (predicate != nil)
            [fetchRequest setPredicate:predicate];
    }
    
    NSError *error = nil;
    NSArray *arrResult = [[[DBManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"GET Sessions Error: %@", error.debugDescription);
    }
    
    return arrResult;
}

- (Session*)sessionWithId:(NSString*)sessId {
    return [[self getSessionsWithId:sessId] lastObject];
}

- (NSArray*)getSessionsForUserId:(NSString*)userId {
    return nil;
}

- (void)deleteSessionWithId:(NSString*)sessId {
    Session *sess = [self sessionWithId:sessId];
    [[[DBManager sharedInstance] managedObjectContext] deleteObject:sess];
    [[DBManager sharedInstance] saveContext];
}

- (Session*)addSession:(NSDictionary*)dicSession {

    if (dicSession == nil) {
        NSLog(@"Session dictionary is nil.");
    }
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([Session class]) inManagedObjectContext:context];
    
    Session *row = (Session*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    if (row) {
        
        User *u = [dicSession objectForKey:kSessionRequestedUser];
        row.requestedUser = u;
        row.sessionId = [self generateSessionIdForUser:u.userId];

        if ([u.isAdmin boolValue] == YES) row.user = u;
        else if (![[dicSession objectForKey:kSessionUser] isKindOfClass:[NSNull class]])
            row.user = [dicSession objectForKey:kSessionUser];

        row.name = [Utility validString:[dicSession objectForKey:kSessionName]];
        row.type = [Utility validString:[dicSession objectForKey:kSessionType]];
        row.dateTime = [Utility validString:[dicSession objectForKey:kSessionDateTime]];
        row.venue = [Utility validString:[dicSession objectForKey:kSessionVenue]];
        row.status = [dicSession objectForKey:kSessionStatus];
    }
    else {
        NSLog(@"CoreData Error: Unable to insert row, Session row is nil.");
    }
    
    [[DBManager sharedInstance] saveContext];
    NSLog(@"Session Added into data base.");
    return row;
}

- (NSString*)generateSessionIdForUser:(NSString*)userid {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"EEEE hh:mm:ss a MMM dd yyyy"];
    NSString *dt = [[df stringFromDate:[NSDate date]] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return [NSString stringWithFormat:@"Session_%@_%@", userid, dt];
}

- (Session*)updateSession:(NSDictionary*)dicSession withId:(NSString*)sessionId {
    Session *ses = [self sessionWithId:sessionId];
    if (![[dicSession objectForKey:kSessionUser] isKindOfClass:[NSNull class]])
        ses.user = [dicSession objectForKey:kSessionUser];
    ses.name = [Utility validString:[dicSession objectForKey:kSessionName]];
    ses.type = [Utility validString:[dicSession objectForKey:kSessionType]];
    ses.dateTime = [Utility validString:[dicSession objectForKey:kSessionDateTime]];
    ses.venue = [Utility validString:[dicSession objectForKey:kSessionVenue]];
    ses.status = [dicSession objectForKey:kSessionStatus];
    [[DBManager sharedInstance] saveContext];
    return ses;
}

@end

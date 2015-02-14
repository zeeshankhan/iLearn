//
//  User_DM.m
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "User_DM.h"

@implementation User_DM

+ (instancetype)sharedInstance {
    
    static User_DM *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [User_DM new];
    });
    return instance;
}

- (BOOL)isAdminLogin {
    return [[[self loggedInUser] isAdmin] boolValue];
}

- (NSString*)loggedInUserId {
    return [[self loggedInUser] userId];
}

- (User*)addUser:(NSDictionary*)dicUser {
    
    if (dicUser == nil) {
        NSLog(@"User dictionary is nil.");
    }
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([User class]) inManagedObjectContext:context];
    
    User *row = (User*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    if (row) {
        row.fname = [Utility validString:[dicUser objectForKey:kUserFirstName]];
        row.lname = [Utility validString:[dicUser objectForKey:kUserLastName]];
        row.picPath = [Utility validString:[dicUser objectForKey:kUserPicPath]];
        row.userId = [[Utility validString:[dicUser objectForKey:kUserId]] lowercaseString];
        row.password = [Utility validString:[dicUser objectForKey:kUserPassword]];
        row.isAdmin = [dicUser objectForKey:kUserIsAdmin];
    }
    else {
        NSLog(@"CoreData Error: Unable to insert row, User row is nil.");
    }
    
    [[DBManager sharedInstance] saveContext];
    return row;
}

- (User*)updateUser:(NSDictionary*)dicUser {
    User *usr = [self userWithId:@""];
    return usr;
}

- (User*)userWithId:(NSString*)userId {
    return [[self getUsersWithId:userId] lastObject];
}

- (NSArray*)getUsers {
    return [self getUsersWithId:nil];
}

- (NSArray*)getUsersWithId:(NSString*)userId {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([User class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    [fetchRequest setResultType:NSManagedObjectResultType];
    //    [fetchRequest setReturnsDistinctResults:YES];
    //    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"__ATTRIBUTE_NAME__"]];
    
    if (![[Utility validString:userId] isEqualToString:@""]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@", userId ];
        if (predicate != nil)
            [fetchRequest setPredicate:predicate];
    }
    
    NSError *error = nil;
    NSArray *arrResult = [[[DBManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"GET Users Error: %@", error.debugDescription);
    }
    
    return arrResult;
}


#define OldDataLoaded @"IsOldDataLoaded"

- (void)populateUsersFromList {
    
    BOOL isAlreadyThere = [[NSUserDefaults standardUserDefaults] boolForKey:OldDataLoaded];
    if (isAlreadyThere) {
        return;
    }
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([User class]) inManagedObjectContext:context];
    
    @autoreleasepool {
        
        NSArray *arrDummyData = (NSArray*)[Utility plistDataWithPath:[[NSBundle mainBundle] pathForResource:@"UserDM" ofType:@"plist"]];
        for (NSDictionary *dicData in arrDummyData) {
            
            User *row = (User*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            if (row) {
                row.fname = [Utility validString:[dicData objectForKey:kUserFirstName]];
                row.lname = [Utility validString:[dicData objectForKey:kUserLastName]];
                row.picPath = [Utility validString:[dicData objectForKey:kUserPicPath]];
                row.userId = [[Utility validString:[dicData objectForKey:kUserId]] lowercaseString];
                row.password = [Utility validString:[dicData objectForKey:kUserPassword]];
                row.isAdmin = [dicData objectForKey:kUserIsAdmin];
            }
            else {
                NSLog(@"CoreData Error: Unable to insert row, User row is nil.");
            }
            
            [Utility saveThumb:[UIImage imageNamed:row.userId] withName:row.userId];
        }
        
    }
    
    [[DBManager sharedInstance] saveContext];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:OldDataLoaded];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)generateUserList {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([User class]) inManagedObjectContext:[[DBManager sharedInstance] managedObjectContext]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    NSError *error = nil;
    NSArray *arrResult = [[[DBManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"GET Users Error: %@", error.debugDescription);
    }
    
    if (arrResult.count > 0) {
        NSString *userDMListPath = [Utility filePathFor:@"UserDM.plist"];
        BOOL writeStatus = [arrResult writeToFile:userDMListPath atomically:YES];
        NSLog(@"[Local Data] UserDM write status: %@", (writeStatus==YES) ? [NSString stringWithFormat:@"success: %@", userDMListPath] : @"failed.");
    }
    else {
        NSLog(@"No users found.");
    }
}


@end

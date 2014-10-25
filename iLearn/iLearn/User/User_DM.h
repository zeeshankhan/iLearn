//
//  User_DM.h
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#define kUserFirstName                  @"fname"
#define kUserLastName                  @"lname"
#define kUserPicPath                      @"picPath"
#define kUserId                             @"userId"
#define kUserPassword                   @"password"
#define kUserIsAdmin                     @"isAdmin"


@interface User_DM : NSObject

@property (nonatomic, strong) User *loggedInUser;

+ (instancetype)sharedInstance;

- (User*)getUserWithId:(NSString*)userId;
- (NSArray*)getUsers;
- (void)generateUserList;

- (User*)addUser:(NSDictionary*)dicUser;
- (void)updateUser:(NSDictionary*)dicUser;

- (void)populateUsersFromList;

@end
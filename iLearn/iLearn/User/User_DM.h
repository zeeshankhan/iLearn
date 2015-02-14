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

#define kNavItemTag                     1092


typedef NS_ENUM(NSUInteger, UserType) {
    UserTypePresenter = 0,
    UserTypeParticipant,
    UserTypeRequester,
};


@interface User_DM : NSObject

@property (nonatomic, strong) User *loggedInUser;

+ (instancetype)sharedInstance;

- (BOOL)isAdminLogin;

- (User*)userWithId:(NSString*)userId;
- (NSArray*)getUsersWithId:(NSString*)userId;
- (NSArray*)getUsers;

- (void)generateUserList;

- (User*)addUser:(NSDictionary*)dicUser;
- (User*)updateUser:(NSDictionary*)dicUser;

- (void)populateUsersFromList;

@end
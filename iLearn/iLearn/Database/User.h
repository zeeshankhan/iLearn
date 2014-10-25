//
//  User.h
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * picPath;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSNumber * isAdmin;
@property (nonatomic, retain) NSManagedObject *session;
@property (nonatomic, retain) NSManagedObject *feedback;

@end

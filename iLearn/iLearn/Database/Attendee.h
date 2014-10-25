//
//  Attendee.h
//  iLearn
//
//  Created by Zeeshan Khan on 25/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Session;

@interface Attendee : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * attendeeId;
@property (nonatomic, retain) Session *session;

@end

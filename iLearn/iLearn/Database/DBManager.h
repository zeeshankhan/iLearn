//
//  DBManager.h
//  iLearn
//
//  Created by Zeeshan Khan on 17/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedInstance;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

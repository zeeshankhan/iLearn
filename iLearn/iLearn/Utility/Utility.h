//
//  Utility.h
//  iLearn
//
//  Created by Zeeshan Khan on 24/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ThumbSize CGSizeMake(36, 36)

@interface Utility : NSObject

+ (NSString*)validString:(NSString*)str;

+ (UIImage*)imageSFor:(NSString*)name;
+ (UIImage*)imageMFor:(NSString*)name;
+ (UIImage*)imageOFor:(NSString*)name;

+ (NSString*)filePathFor:(NSString*)name;
+ (id)plistDataWithPath:(NSString*)path;
+ (void)saveThumb:(UIImage*)thumb withName:(NSString*)name;

@end

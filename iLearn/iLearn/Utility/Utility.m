//
//  Utility.m
//  iLearn
//
//  Created by Zeeshan Khan on 24/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utility

+ (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+ (NSString*)validString:(NSString*)str {
    
    if (str == nil)
        return @"";
    
    if (![str isKindOfClass:[NSString class]]) {
        return @"";
    }
    else if(str && ![@"(null)" isEqualToString:str] && ![@"null" isEqualToString:str] && ![@"<null>" isEqualToString:str] && ![str isKindOfClass:[NSNull class]]  && [str length] > 0){
        str = [str stringByReplacingOccurrencesOfString:@"" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@" "];
        return str;
    }
    return @"";
}

+ (void)saveThumb:(UIImage*)thumb withName:(NSString*)name {

    // Save Original
    NSString *filePath = [[self class] filePathFor:[NSString stringWithFormat:@"%@.png",name]];
    NSData *imgData = UIImagePNGRepresentation(thumb);
    BOOL status = [imgData writeToFile:filePath atomically:NO];
    if (status == FALSE)
        NSLog(@"Thumb Saving Failed!!");

    
    // Save M
    filePath = [[self class] filePathFor:[NSString stringWithFormat:@"%@_M.png",name]];
    UIImage *imgM = [thumb scaleImageProportionallyToSize:ThumbSizeM];
    imgData = UIImagePNGRepresentation(imgM);
    status = [imgData writeToFile:filePath atomically:NO];
    if (status == FALSE)
        NSLog(@"Thumb_M Saving Failed!!");

    
    // Save S
    filePath = [[self class] filePathFor:[NSString stringWithFormat:@"%@_S.png",name]];
    UIImage *imgS = [imgM scaleImageProportionallyToSize:ThumbSizeS];
    imgData = UIImagePNGRepresentation(imgS);
    status = [imgData writeToFile:filePath atomically:NO];
    if (status == FALSE)
        NSLog(@"Thumb_M Saving Failed!!");
}


+ (UIImage*)imageSFor:(NSString*)name {
    if ([[[self class] validString:name] isEqualToString:@""]) {
      return [UIImage imageNamed:@"placeholder"];
    }
    else {
        NSString *imgname = [NSString stringWithFormat:@"%@_S.png",name];
        return [[self class] imageFor:imgname];
    }
}

+ (UIImage*)imageMFor:(NSString*)name withFN:(NSString*)fn {
    if ([[[self class] validString:name] isEqualToString:@""]) {
        return [UIImage imageNamed:@"placeholder"];
    }
    else {
        NSString *imgname = [NSString stringWithFormat:@"%@_M.png",name];
        return [[self class] imageFor:imgname];
    }
}

+ (UIImage*)imageMFor:(NSString*)name {
    return [[self class] imageMFor:name withFN:nil];
}

+ (UIImage*)imageOFor:(NSString*)name {
    if ([[[self class] validString:name] isEqualToString:@""]) {
        return [UIImage imageNamed:@"placeholder"];
    }
    else {
        NSString *imgname = [NSString stringWithFormat:@"%@.png",name];
        return [[self class] imageFor:imgname];
    }
}

+ (UIImage*)imageFor:(NSString*)name {
    NSString *path = [[self class] filePathFor:name];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (exist == YES) {
//        NSLog(@"Exist: %d %@", exist, path);
        NSData *pngData = [NSData dataWithContentsOfFile:path];
        UIImage *img = [UIImage imageWithData:pngData];
        return img;
    }
    else {
        return [UIImage imageNamed:@"placeholder"];
    }
}

+ (NSString*)filePathFor:(NSString*)name {
    NSURL *dir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [dir URLByAppendingPathComponent:name];
    NSString *path = storeURL.path;
    return path;
}

+ (id)plistDataWithPath:(NSString*)path {
    
    id data = nil;
    if (path) {
        
        NSData *fileData = [NSData dataWithContentsOfFile:path];
        if (fileData) {
            
            NSError *error = nil;
            NSPropertyListFormat format = NSPropertyListBinaryFormat_v1_0;
            data = [NSPropertyListSerialization propertyListWithData:fileData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
            if (error != nil) {
                NSLog(@"[Local Data] Plist error while loading: %@",[error localizedDescription]);
            }
        }
        else {
            NSLog(@"[Local Data] Plist File data is nil");
        }
    }
    return data;
}

+ (UIColor*)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0 % 256
    CGFloat saturation = ( arc4random() % 256 / 256.0 ); //+ 0.5;  //  0.5 to 1.0, away from white % 128
    CGFloat brightness = ( arc4random() % 256 / 256.0 ); //+ 0.5;  //  0.5 to 1.0, away from black % 128
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


+ (UIImage*)imageWithRandomColor {
    
    CGSize size = CGSizeMake(400,400);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [[[self class] randomColor] setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage*)imageWithText:(NSString*)text {
    text = [text uppercaseString];
    UIImage *image = [[self class] imageWithRandomColor];
    CGPoint point = CGPointMake(image.size.width/2.0, image.size.height/2.0);
    UIFont *font = [UIFont fontWithName:@"Futura" size:200];
    CGSize size = CGSizeMake(400, 400);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    CGRect rect = CGRectMake(point.x/2 - 20,point.y/2 - 20,size.width, size.height);
    [[UIColor whiteColor] set];
    NSDictionary *dicAtt = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: font};
    [text drawInRect:CGRectIntegral(rect) withAttributes:dicAtt];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end

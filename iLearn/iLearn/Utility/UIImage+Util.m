//
//  UIImage+Util.m
//  iLearn
//
//  Created by Zeeshan Khan on 23/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

#pragma mark - Image Coloring

- (UIImage *)convertImageToGrayScale {
    
    CGSize imgSize = self.size;
    CGRect imageRect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(nil, imgSize.width, imgSize.height, 8, imgSize.width, colorSpace,
                                                 (CGBitmapInfo) kCGImageAlphaNone);
    
    CGContextDrawImage(context, imageRect, [self CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    return newImage;
}

- (UIImage *)convertOriginalImageToBWImage {

    CGSize          imgSize     = self.size;
    CGRect          imageRect   = CGRectMake(0.0, 0.0, imgSize.width, imgSize.height);
    CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceGray();
    UIImage         *newImage;
    
    CGContextRef context = CGBitmapContextCreate(nil, imgSize.width * self.scale, imgSize.height * self.scale, 8, imgSize.width * self.scale, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    
    CGContextDrawImage(context, imageRect, [self CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *resultImage = [UIImage imageWithCGImage:bwImage];
    CGImageRelease(bwImage);
    
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, self.scale);
    [resultImage drawInRect:imageRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return newImage;
}

#pragma mark - Image compression

- (UIImage*)compressedJPEGImage:(CGFloat)compressionRatio {
    if (compressionRatio>1 || compressionRatio<0)
        return nil;
    NSData *data = [self compressedJPEGImageData:compressionRatio];
    return [UIImage imageWithData:data];
}

- (NSData*)compressedJPEGImageData:(CGFloat)compressionRatio {
    if (compressionRatio>1 || compressionRatio<0)
        return nil;
    NSData *data = UIImageJPEGRepresentation(self, compressionRatio);
    //[self saveImg:@"1.JPEG" andImgData:data];
    return data;
}

#pragma mark - Image scaling

- (UIImage*)scaleImageToHalfTheSize {
    
    // scaling set to 2.0 makes the image 1/2 the size.
    UIImage *scaledImage = [UIImage imageWithCGImage:[self CGImage]
                                               scale:(self.scale * 2.0)
                                         orientation:(self.imageOrientation)];
    
    return scaledImage;
}

- (UIImage*)scaleImageProportionallyToSize:(CGSize)size {
    
    if ((self.size.width < size.width && self.size.height < size.height) || CGSizeEqualToSize(size, self.size))
        return self;
    
    CGSize newSize = [self scaleProportionallyToSize:size];
    NSLog(@"From:%@, To:%@", NSStringFromCGSize(self.size), NSStringFromCGSize(newSize));
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    //    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (CGSize)scaleProportionallyToSize:(CGSize)size {
    
    CGSize newSize = CGSizeMake(size.width, size.height);
    CGFloat widthRatio = newSize.width/self.size.width;
    CGFloat heightRatio = newSize.height/self.size.height;
    
    CGSize scaledSize;
    if(widthRatio > heightRatio)
        scaledSize = CGSizeMake(self.size.width*heightRatio,self.size.height*heightRatio);
    else
        scaledSize = CGSizeMake(self.size.width*widthRatio,self.size.height*widthRatio);
    
    return scaledSize;
}

#pragma mark - Image Orientation

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)rotateImage {
    
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = self.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

@end

//
//  UIImage+Util.h
//  iLearn
//
//  Created by Zeeshan Khan on 23/10/14.
//  Copyright (c) 2014 Zeeshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)


// Coloring
- (UIImage *)convertImageToGrayScale;
- (UIImage *)convertOriginalImageToBWImage;


// Compression
- (UIImage*)compressedJPEGImage:(CGFloat)compressionRatio;
- (NSData*)compressedJPEGImageData:(CGFloat)compressionRatio;


// Scale image size in points not in pixels
- (UIImage*)scaleImageToHalfTheSize;

// Scale image into size in points and pixels as well
- (UIImage*)scaleImageProportionallyToSize:(CGSize)size;

// toSize is basically proportion limit, return value would be under toSize
- (CGSize)scaleProportionallyToSize:(CGSize)size;


// Orientation
- (UIImage *)fixOrientation;
- (UIImage *)rotateImage;

@end

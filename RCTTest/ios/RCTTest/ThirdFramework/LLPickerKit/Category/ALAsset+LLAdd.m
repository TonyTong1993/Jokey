//
//  ALAsset+LLAdd.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/20.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "ALAsset+LLAdd.h"
#import "FunctionDefines.h"

@implementation ALAsset (LLAdd)

//- (UIImage *)originImage {
//    ALAssetRepresentation *image_representation = [self defaultRepresentation];
//    uint8_t buffer = (Byte)malloc(image_representation.size);
//    NSUInteger length = [image_representation getBytes:&buffer fromOffset: 0.0 length:image_representation.size error:nil];
//    if (length == 0) {
//        return nil;
//    }
//    NSData *imageData = [[NSData alloc] initWithBytesNoCopy:&buffer length:image_representation.size freeWhenDone:YES];
//    UIImage *resultImage = [UIImage imageWithData:imageData];
//    return resultImage;
//}

- (UIImage *)fullResolutionImage {
    ALAssetRepresentation *representation = [self defaultRepresentation];
    CGImageRef imageRef = [representation fullResolutionImage];
    return [UIImage imageWithCGImage:imageRef];
}

- (UIImage *)fullScreenImage {
    ALAssetRepresentation *representation = [self defaultRepresentation];
    CGImageRef imageRef = [representation fullScreenImage];
    return [UIImage imageWithCGImage:imageRef];
}

- (void)originalSize:(void(^)(NSString *result))result {
    ALAssetRepresentation *representation = [self defaultRepresentation];
    unsigned long size = [representation size] / 1024;
    NSString *sizeString = [NSString stringWithFormat:@"%liK", size];
    if (size > 1024) {
        NSInteger integral = size / 1024.0;
        NSInteger decimal = size % 1024;
        NSString *decimalString = [NSString stringWithFormat:@"%li",decimal];
        if(decimal > 100){ // 取两位
            decimalString = [decimalString substringToIndex:2];
        }
        sizeString = [NSString stringWithFormat:@"%li.%@M", integral, decimalString];
    }
    Block_exe(result, sizeString);
}

@end

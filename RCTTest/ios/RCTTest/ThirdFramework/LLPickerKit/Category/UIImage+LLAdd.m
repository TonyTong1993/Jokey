//
//  UIImage+LLAdd.m
//  PSPhotoManager
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UIImage+LLAdd.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@implementation UIImage (LLAdd)

- (NSDictionary *)JPEGMetadata {
    if (!self) {
        return nil;
    }
    // 转换成jpegData, 信息要多一些
    NSData *jpegData = UIImageJPEGRepresentation(self, 1.0);
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)jpegData, NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    CFRelease(source);
    
    NSDictionary *metaDataInfo = CFBridgingRelease(imageMetaData);
    return metaDataInfo;
}

- (NSDictionary *)PNGMetadata {
    if (!self) {
        return nil;
    }
    NSData *pngData = UIImagePNGRepresentation(self);
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)pngData , NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    CFRelease(source);
    NSDictionary *metaDataInfo = CFBridgingRelease(imageMetaData);
    return metaDataInfo;
}

@end

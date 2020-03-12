//
//  TYPhotoView.m
//  RCTTest
//
//  Created by ZZHT on 2018/5/16.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoView.h"
#import "TYLocalAlbumPhoto.h"
#import "TYRemotePhoto.h"
#import "PHAsset+Image.h"
@implementation TYPhotoView
-(instancetype)init {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(void)setPhoto:(TYPhoto *)photo {
    
     _photo = photo;
   
    if ([photo isKindOfClass:[TYLocalAlbumPhoto class]]) {
        __weak typeof(self) weakSelf = self;
        TYLocalAlbumPhoto *localPhoto = (TYLocalAlbumPhoto *)_photo;
        [localPhoto.phAsset getPreViewImage:^(UIImage *result, NSDictionary *info) {
                CGPoint center = weakSelf.center;
                weakSelf.size = [weakSelf adaptImageSize:result];
                weakSelf.image = result;
                weakSelf.center = center;
            
           
        }];
    }
}
-(CGSize)adaptImageSize:(UIImage *)image {
    CGFloat width  = image.size.width;
    CGFloat height = image.size.height;
    CGFloat standardWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat standardHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat standardRatio = standardWidth / standardHeight;
    standardRatio =[[NSString stringWithFormat:@"%.2f", standardRatio] floatValue];
    if (width > standardWidth) {//宽度对齐
        CGFloat scale = width / standardWidth;
        height = height/scale;
        width = standardWidth;
    }
     CGFloat ratio = width/height;
 
   ratio =[[NSString stringWithFormat:@"%.2f", ratio] floatValue];
    
    //图片小于规定尺寸的，规定min 80
    if (ratio < standardRatio){
        if (height > standardHeight) {
            CGFloat scale = height / standardHeight;
            width = width / scale;
            height = standardHeight;
        }
    }
    
    if (standardRatio == ratio) {
        height = standardHeight;
        width = standardWidth;
    }
   
    
    return CGSizeMake(width, height);
    
}
@end

//
//  UIImageView+Extension.m
//  RCTTest
//
//  Created by 童万华 on 2018/1/19.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImage+Extentions.h"
@implementation UIImageView (Extension)
-(void)sd_setAvatarImageWithURL:(NSURL *)url andRoundRadius:(CGFloat)radius {
    [self sd_setImageWithURL:url placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         self.image = [image imageByRoundCornerRadius:radius];
    }];
}
@end

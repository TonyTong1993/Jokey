//
//  UIButton+LPExtension.m
//  lepaotiyu
//
//  Created by 童万华 on 2017/4/18.
//  Copyright © 2017年 pengdada. All rights reserved.
//

#import "UIButton+LPExtension.h"

@implementation UIButton (LPExtension)
- (void)verticalImageAndTitle:(CGFloat)spacing titleAttribute:(NSDictionary *)attributes;
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:attributes];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}
@end

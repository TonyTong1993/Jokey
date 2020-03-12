//
//  UIImage+Extentions.h
//  SimpleMapGuide
//
//  Created by 童万华 on 2017/3/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extentions)

/**
 add alpha for image

 @param alpha alpha vale
 @return new image contain alpha
 */
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;



@end

@interface UIImage (Photo)

/**
 adjust image orientation
 */
- (UIImage *)fixOrientation;



@end

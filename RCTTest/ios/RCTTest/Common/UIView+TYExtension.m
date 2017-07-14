//
//  UIView+TYExtension.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "UIView+TYExtension.h"

@implementation UIView (TYExtension)
-(CGFloat)x {
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)y {
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)height {
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)width {
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
@end

//
//  UIScrollView+Refresh.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/1.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)
-(void)addHeaderRefreshWithBlock:(void (^)())refreshingBlock;
-(void)addFooterRefreshWithBlock:(void (^)())refreshingBlock;
@end

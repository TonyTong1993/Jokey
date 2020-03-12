//
//  AdPageView.h
//  RCTTest
//
//  Created by 童万华 on 2018/2/28.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 启动广告页面
 */
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

typedef void(^TapBlock)();
@interface AdPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTapBlock:(TapBlock)tapBlock;

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;
@end

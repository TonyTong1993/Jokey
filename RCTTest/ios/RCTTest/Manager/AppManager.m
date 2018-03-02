//
//  AppManager.m
//  RCTTest
//
//  Created by 童万华 on 2018/2/27.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "AppManager.h"
#import "AdPageView.h"
#import "YYFPSLabel.h"
@implementation AppManager
+(void)appADStart {
    //加载广告
    AdPageView *adView = [[AdPageView alloc] initWithFrame:[UIScreen mainScreen].bounds withTapBlock:^{
     
    }];
     adView = adView;
}
+(void)showFPS {
    CGFloat width = 52.0f;
    CGFloat height = 20.0f;
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake(size.width - width - 20, size.height-kTabBarHeight-40, width, height);
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:frame];
    fpsLabel.backgroundColor = [UIColor randomColor];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:fpsLabel];
    [keyWindow bringSubviewToFront:fpsLabel];
}
@end

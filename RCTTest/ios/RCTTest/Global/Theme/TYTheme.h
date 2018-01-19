//
//  TYTheme.h
//  RCTTest
//
//  Created by 童万华 on 2017/7/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const themeColorHexValue;//主题色值
extern NSInteger const separatorColorHexValue;//间隔线的色值
extern NSInteger const textTint;
extern CGFloat const textFont;
extern NSInteger const backgroundColorHexValue;
typedef NS_ENUM(NSInteger,TYThemeType) {
    TYThemeLight = 1,//纯色
    TYThemeDark,//亮黑
    TYThemeBrightRed, //富贵红
    TYThemeSkyBlue, //天空蓝
    TYThemePureWhite //白
};

@interface TYTheme : NSObject
//设置主题色
+(NSString *)themeColorWithType:(TYThemeType)type;
//获取主题色
+(NSString *)themeColor;

+(NSString *)themeFontFamilyName;

@end

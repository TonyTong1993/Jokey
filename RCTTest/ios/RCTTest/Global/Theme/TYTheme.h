//
//  TYTheme.h
//  RCTTest
//
//  Created by 童万华 on 2017/7/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const themeColorHexValue;
extern NSInteger const separatorColorHexValue;
extern NSInteger const textTint;
extern CGFloat const textFont;
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

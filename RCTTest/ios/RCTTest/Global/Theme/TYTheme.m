//
//  TYTheme.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/7.
//  Copyright © 2017年 童万华. All rights reserved.
//
//导航栏选中字体颜色 5BB4EB 未选中颜色 black

#import "TYTheme.h"
NSInteger const themeColorHexValue = 0x55B1E6;//主题颜色
NSInteger const separatorColorHexValue = 0xebebeb;//间隔线
NSInteger const textTint = 0x333333;//文本默认颜色
CGFloat const textFont = 14;//文本默认大小
@implementation TYTheme
static NSString *themeColor;
+(NSString *)themeColorWithType:(TYThemeType)type {
    NSString *color;
    switch (type) {
        case TYThemeLight:
            color = @"#e0ffff";
            break;
            
        case TYThemeDark:
             color = @"#333333";
            break;
            
        case TYThemeBrightRed:
             color = @"#dc143c";
            break;
        case TYThemeSkyBlue:
             color = @"#87ceeb";
            break;
        case TYThemePureWhite:
            color = @"#ffffff";
            break;
    }
    themeColor = color;
    return color;
}
+(NSString *)themeColor {
    return themeColor;
}
+(NSString *)themeFontFamilyName {
    return @"PingFangSC-Regular";
}

@end

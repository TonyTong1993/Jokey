//
//  Utils.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)addScaleAnimation:(UIView *)totalView;

+ (UILabel *)building:(NSInteger)numberOfLines textColor:(UIColor *)textColor textAligment:(NSTextAlignment)textAligment font:(UIFont *)font;

+ (UILabel *)building:(NSInteger)numberOfLines textColor:(UIColor *)textColor textAligment:(NSTextAlignment)textAligment font:(UIFont *)font superview:(UIView *)superview;

+ (NSString *)replaceEnglishAssetCollectionNamme:(NSString *)englishName;

+ (void)loadingResultAssetsWithBlock:(void(^)(NSArray <UIImage *>*images))block;

@end

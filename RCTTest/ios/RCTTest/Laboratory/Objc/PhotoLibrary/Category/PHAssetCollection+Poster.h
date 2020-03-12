//
//  PHAssetCollection+Poster.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAssetCollection (Poster)
- (void)posterImage:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)posterImage:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;
+ (NSString *)replaceEnglishAssetCollectionNamme:(NSString *)englishName;
@end

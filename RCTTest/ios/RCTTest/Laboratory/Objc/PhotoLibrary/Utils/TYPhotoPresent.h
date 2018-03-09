//
//  TYPhotoPresent.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYPhotoHandler.h"
@interface TYPhotoPresent : NSObject
-(instancetype)initWithPresenter:(UIViewController *)presenter;
-(void)requestAuthorization:(void (^)(NSMutableArray *result))hanlder;
-(void)requestAllPhAssets:(void(^)(PHFetchResult <PHAsset *>*result))finishBlock;
@property (nonatomic,weak) UIViewController *viewController;
@end

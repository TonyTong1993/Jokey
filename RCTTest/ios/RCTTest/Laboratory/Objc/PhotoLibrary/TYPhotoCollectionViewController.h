//
//  TYPhotoCollectionViewController.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYPhotoPresent.h"
@interface TYPhotoCollectionViewController : UIViewController
@property (nonatomic,strong) PHFetchResult<PHAsset *> *fetchResult;
@end

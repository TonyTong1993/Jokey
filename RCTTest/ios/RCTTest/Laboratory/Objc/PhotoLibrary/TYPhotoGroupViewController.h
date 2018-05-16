//
//  TYPhotoGroupViewController.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYPhoto;
@interface TYPhotoGroupViewController : UIViewController
@property (nonatomic,copy) NSArray <TYPhoto *>* photos;
@property (nonatomic,assign) NSInteger selectedIndex;
@end

//
//  TYStatusViewCell.h
//  RCTTest
//
//  Created by 童万华 on 17/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYModelTest;
@interface TYStatusViewCell : UICollectionViewCell
@property (nonatomic,assign) NSIndexPath *outerIndexPath;

@property (nonatomic,strong) TYModelTest *model;

@end


//
//  TYPreviewPhotoViewCell.h
//  RCTTest
//
//  Created by 童万华 on 2018/5/26.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYPhotoView;
@interface TYPreviewPhotoViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet TYPhotoView *photoPreView;

+ (NSString *)reuseIdentifer;
@end

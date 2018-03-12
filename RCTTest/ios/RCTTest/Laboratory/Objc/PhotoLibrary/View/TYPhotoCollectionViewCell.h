//
//  TYPhotoCollectionViewCell.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYPhotoCollectionViewCell;
@protocol TYPhotoCollectionViewCellDelegate<NSObject>
-(void)photocell:(TYPhotoCollectionViewCell *)cell didSelectedAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface TYPhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UIButton *check;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<TYPhotoCollectionViewCellDelegate> delegate;
-(void)addSelectedShapeLayer:(int)count;
-(void)removeSelectedShaperLayer;
@end

//
//  TYPhotoCollectionViewCell.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoCollectionViewCell.h"
#import <CoreText/CoreText.h>
@interface TYPhotoCollectionViewCell()
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CATextLayer *textLayer;
@end
@implementation TYPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)checkOnClicked:(UIButton *)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(photocell:didSelectedAtIndexPath:)]) {
        [_delegate photocell:self didSelectedAtIndexPath:self.indexPath];
    }
}


-(void)addSelectedShapeLayer:(int)count{
    NSString *text = [NSString stringWithFormat:@"%d",count];
    if (self.shapeLayer){
        self.textLayer.string = text;
        return;
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGMutablePathRef mpath =  CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.0);
    CGRect rect = self.check.imageView.frame;//CGRectMake(0, 0, 32, 32);
    CGFloat width = self.check.imageView.bounds.size.width;
    CGPathAddRoundedRect(mpath, &transform, rect, width/2, width/2);
    shapeLayer.path = mpath;
    CGPathRelease(mpath);
    shapeLayer.fillColor = HEXCOLOR(themeColorHexValue).CGColor;
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = text;
    textLayer.fontSize = 18;
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.truncationMode = kCATruncationMiddle;
    textLayer.frame = rect;
    [shapeLayer addSublayer:textLayer];
    self.textLayer = textLayer;
    [self.check.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
    
}
-(void)removeSelectedShaperLayer {
    if (self.shapeLayer) {
        [self.textLayer removeFromSuperlayer];
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
        self.textLayer = nil;
    }
}
@end

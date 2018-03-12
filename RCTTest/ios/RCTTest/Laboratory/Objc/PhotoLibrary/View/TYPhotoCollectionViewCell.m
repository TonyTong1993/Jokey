//
//  TYPhotoCollectionViewCell.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoCollectionViewCell.h"
#import <CoreText/CoreText.h>
@implementation TYPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)checkOnClicked:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [self addSelectedShapeLayer:1];
    }else {
        [self removeSelectedShaperLayer];
    }
    
    
}

-(void)addSelectedShapeLayer:(int)count{
    NSString *text = [NSString stringWithFormat:@"%d",count];
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
    [self.check.layer addSublayer:shapeLayer];
    
}
-(void)removeSelectedShaperLayer {
    [[[self.check.layer sublayers] lastObject] removeFromSuperlayer];
}
@end

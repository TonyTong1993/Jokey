//
//  LLBrowerScrollView.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLBrowserScrollView.h"
#import "LLBrowserImageView.h"
#import "Config.h"

static CGFloat const kMAXZoomScale = 3.f;
static CGFloat const kMINZoomScale = 1.f;

@interface LLBrowserScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) LLBrowserImageView *imageView;
@property (nonatomic, copy) dispatch_block_t singleBlock;
@property (nonatomic, copy) dispatch_block_t doubleBlock;
@property (nonatomic, copy) dispatch_block_t longBlock;
@end

@implementation LLBrowserScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.imageView = [[LLBrowserImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        self.delegate = self;
        self.maximumZoomScale = kMAXZoomScale;
        self.minimumZoomScale = kMINZoomScale;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapAction:)];
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleTap];
        
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTapAction:)];
        longTap.allowableMovement = 10; //在失败之前允许移动的
        longTap.minimumPressDuration = 1;//长按的时间
        [_imageView addGestureRecognizer:longTap];
        
        // 只有当没有检测到doubleTap或者检测doubleTap失败singleTap才有效
        // 解决单击和双击手势冲突
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [longTap requireGestureRecognizerToFail:singleTap];
    }
    return self;
}

- (void)handleSingleTapAction:(UITapGestureRecognizer *)singleTap {
    Block_exe(_singleBlock);
}

- (void)handleDoubleTapAction:(UITapGestureRecognizer *)doubleTap {
    Block_exe(_doubleBlock);
    
    if (self.zoomScale == kMINZoomScale) {
        [self setZoomScale:kMAXZoomScale animated:YES];
    } else {
        [self setZoomScale:kMINZoomScale animated:YES];
    }
}

- (void)handleLongTapAction:(UITapGestureRecognizer *)longTap {
     Block_exe(_longBlock);
}
- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block {
    self.singleBlock = block;
}

- (void)handleDoubleTapActionWithBlock:(dispatch_block_t)block {
    self.doubleBlock = block;
}
-(void)handleLongTapActionWithBlock:(dispatch_block_t)block {
    self.longBlock = block;
}
- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
    [self resetImageViewFrame:self.size imageSize:image.size];
}
  //NEXT:有的设备self.width为无穷大
- (void)resetImageViewFrame:(CGSize)imageViewSize imageSize:(CGSize)imageSize {
    if (imageViewSize.width > 0 && imageViewSize.height > 0) {
        if (imageSize.width > 0 && imageSize.height > 0) { // 横条样式
             //FIXME:有的设备self.width为无穷大
            imageViewSize = CGSizeMake(self.width, imageSize.height / imageSize.width * imageViewSize.width);
        } else { // 竖条样式
            imageViewSize = CGSizeMake(imageSize.width / imageSize.height * imageViewSize.height, self.height);
        }
        self.imageView.frame = CGRectMake((self.width - imageViewSize.width) / 2, (self.height - imageViewSize.height) / 2, imageViewSize.width, imageViewSize.height);
    }
}

#pragma mark -
#pragma mark - scrollView protocol methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat centerX = scrollView.centerX;
    CGFloat centerY = scrollView.centerY;
    
    centerX = scrollView.contentSize.width > scrollView.width ? scrollView.contentSize.width / 2 : centerX;
    centerY = scrollView.contentSize.height > scrollView.height ? scrollView.contentSize.height / 2 : centerY;
    self.imageView.center = CGPointMake(centerX, centerY);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

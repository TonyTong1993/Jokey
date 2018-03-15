//
//  TYPhotoGroupView.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoGroupView.h"
#import <TBCityIconFont.h>
@interface TYPhotoGroupView() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *toContainerView;

@property (nonatomic, strong) UIImage *snapshotImage;
@property (nonatomic, strong) UIImage *snapshorImageHideFromView;

@property (nonatomic, strong) UIToolbar *topToolBar;

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *blurBackground;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) UIPageControl *pager;
@property (nonatomic, assign) CGFloat pagerCurrentPage;
@property (nonatomic, assign) BOOL fromNavigationBarHidden;

@property (nonatomic, assign) NSInteger fromItemIndex;
@property (nonatomic, assign) BOOL isPresented;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint panGestureBeginPoint;
@end
@implementation TYPhotoGroupView

-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.frame = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    self.topToolBar = [[UIToolbar alloc] initWithFrame:frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"jpeg"];
    UIImage *backgroundImage = [[UIImage alloc] initWithContentsOfFile:path];
    [self.topToolBar setBackgroundImage:backgroundImage
                  forToolbarPosition:UIBarPositionAny
                          barMetrics:UIBarMetricsDefault];
    [self.topToolBar setShadowImage:[UIImage new]
              forToolbarPosition:UIToolbarPositionAny];
    
 

    
     UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
     backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//   back &#xe720;check &#xe72e;
     TBCityIconInfo *iconInfo = TBCityIconInfoMake(@"\U0000e720", 26, [UIColor whiteColor]);
     UIImage *backImage = [UIImage iconWithInfo:iconInfo];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    checkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //   back &#xe720;check &#xe72e;
    TBCityIconInfo *iconCheckInfo = TBCityIconInfoMake(@"\U0000e72e", 32, [UIColor whiteColor]);
    UIImage *checkImage = [UIImage iconWithInfo:iconCheckInfo];
    [checkBtn setImage:checkImage forState:UIControlStateNormal];
    UIBarButtonItem *checkItem = [[UIBarButtonItem alloc] initWithCustomView:checkBtn];
    UIBarButtonItem *flexiableSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *items = @[backItem,flexiableSpaceItem,checkItem];
    
//    [self.topToolBar setItems:items];
    
   
    
//    _background = UIImageView.new;
//    _background.backgroundColor = [UIColor randomColor];
//    _background.frame = self.bounds;
//    _background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    _blurBackground = UIImageView.new;
//    _blurBackground.frame = self.bounds;
//    _blurBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//
//    _contentView = UIView.new;
//    _contentView.frame = self.bounds;
//    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//
////    [self addSubview:_background];
//    [self addSubview:_blurBackground];
//    [self addSubview:_contentView];
    [self addSubview:self.topToolBar];
    
    return self;
}
- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)toContainer
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    if (!toContainer) return;
    _fromView = fromView;
    _toContainerView = toContainer;
    
    _snapshotImage = [_toContainerView snapshotImageAfterScreenUpdates:NO];
    
    
}
-(void)dissmiss {
    if (_delegate&&[_delegate respondsToSelector:@selector(photoGroupViewDissmissActionResponder)]) {
        [_delegate photoGroupViewDissmissActionResponder];
    }
}
@end

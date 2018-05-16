//
//  TYPhotoGroupView.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYBrowserView.h"
#import <TBCityIconFont.h>
#import "UIImage+Extentions.h"
#import "TYPhoto.h"
#import "TYPhotoView.h"

@interface TYBrowserView() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

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
@implementation TYBrowserView
#pragma mark---getter and setter

-(UIToolbar *)topToolBar {
    if (!_topToolBar) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        _topToolBar = [[UIToolbar alloc] initWithFrame:frame];
        UIImage *backgroundImage = [[UIImage imageWithColor:HEXCOLOR(0x414141)] imageByApplyingAlpha:0.6];
        [_topToolBar setBackgroundImage:backgroundImage
                         forToolbarPosition:UIBarPositionAny
                                 barMetrics:UIBarMetricsDefault];
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
        
        TBCityIconInfo *iconCheckInfo = TBCityIconInfoMake(@"\U0000e72e", 32, [UIColor whiteColor]);
        UIImage *checkImage = [UIImage iconWithInfo:iconCheckInfo];
        [checkBtn setImage:checkImage forState:UIControlStateNormal];
        UIBarButtonItem *checkItem = [[UIBarButtonItem alloc] initWithCustomView:checkBtn];
        UIBarButtonItem *flexiableSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSArray *items = @[backItem,flexiableSpaceItem,checkItem];
        [_topToolBar setItems:items];
    }
    return _topToolBar;
}

-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.frame = [UIScreen mainScreen].bounds;
    _scrollView = [UIScrollView new];
    _scrollView.frame = [UIScreen mainScreen].bounds;
    _scrollView.pagingEnabled = true;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor randomColor];

    [self addSubview:_scrollView];
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
-(void)setDataSource:(id<TYBrowserViewDataSource>)dataSource {
    _dataSource = dataSource;
    NSMutableArray <TYPhoto *> *datas = [NSMutableArray array];
    CGFloat startCenterX = self.size.width / 2;
    CGFloat startCenterY = self.size.height / 2;
    
    NSUInteger count = [_dataSource numberOfPhotosInBrowserView];
    self.scrollView.contentSize = CGSizeMake(self.size.width * count, self.size.height);
    for (int i = 0; i < [_dataSource numberOfPhotosInBrowserView]; i++) {
        NSAssert([[_dataSource browserView:self photoForRowAtIndex:i] isKindOfClass:[TYPhoto class]], @"类型不匹配");
        TYPhoto *photo = [_dataSource browserView:self photoForRowAtIndex:i];
        [datas addObject:photo];
        TYPhotoView *photoView = [TYPhotoView new];
        photoView.backgroundColor = [UIColor randomColor];
        photoView.photo = photo;
        photoView.center = CGPointMake(startCenterX+(i*self.size.width), startCenterY);
        [self.scrollView addSubview:photoView];
    }
    
    
      _groupItems = datas;
}
-(void)setDelegate:(id<TYBrowserViewDelegate>)delegate {
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(selectedIndexInBrowserView)]) {
        CGPoint contentOffset = CGPointMake(self.size.width * [_delegate selectedIndexInBrowserView], 0);
        [self.scrollView setContentOffset:contentOffset];
      
    }
}
-(void)dissmiss {
    if (_delegate&&[_delegate respondsToSelector:@selector(photoBrowserViewDissmissActionResponder)]) {
        [_delegate photoBrowserViewDissmissActionResponder];
    }
}

#pragma mark---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
@end

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
#import "TYPreviewPhotoViewCell.h"
@interface TYBrowserView() <UIScrollViewDelegate, UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *toContainerView;

@property (nonatomic, strong) UIImage *snapshotImage;
@property (nonatomic, strong) UIImage *snapshorImageHideFromView;

@property (nonatomic, strong) UIToolbar *topToolBar;

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *blurBackground;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
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
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _layout = layout;
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TYPreviewPhotoViewCell class]) bundle:nil] forCellWithReuseIdentifier:[TYPreviewPhotoViewCell reuseIdentifer]];
    }
    
    return _collectionView;
}

-(instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.collectionView];
    [self addSubview:self.topToolBar];
    
    return self;
}

-(void)setDataSource:(id<TYBrowserViewDataSource>)dataSource {
    _dataSource = dataSource;
    NSUInteger count = [_dataSource numberOfPhotosInBrowserView];
    self.collectionView.contentSize = CGSizeMake(self.size.width * count, self.size.height);
    
}
-(void)setDelegate:(id<TYBrowserViewDelegate>)delegate {
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(selectedIndexInBrowserView)]) {
        CGPoint contentOffset = CGPointMake(self.size.width * [_delegate selectedIndexInBrowserView], 0);
        [self.scrollView setContentOffset:contentOffset];
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    _layout.minimumLineSpacing = 0.0f;
    _layout.minimumInteritemSpacing = 0.0f;
    _layout.itemSize = CGSizeMake(self.width, self.height);
    [self.collectionView setCollectionViewLayout:_layout];
}
-(void)dissmiss {
    if (_delegate&&[_delegate respondsToSelector:@selector(photoBrowserViewDissmissActionResponder)]) {
        [_delegate photoBrowserViewDissmissActionResponder];
    }
}
#pragma mark - UICollectionViewDataSource an UICollectionViewDelegtate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.numberOfPhotosInBrowserView;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([[_dataSource browserView:self photoForRowAtIndex:indexPath.item] isKindOfClass:[TYPhoto class]], @"类型不匹配");
    TYPhoto *photo = [_dataSource browserView:self photoForRowAtIndex:indexPath.item];
    TYPreviewPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TYPreviewPhotoViewCell reuseIdentifer] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}
#pragma mark---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end

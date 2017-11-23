//
//  LLImageBrowserController.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageBrowserController.h"
#import "LLBrowserCollectionCell.h"
#import "LLToolbar.h"
#import "LLSelectButton.h"
#import "LLImagePickerController.h"

static CGFloat const kToolbarHeight = 42.f;
static NSString *const reUse = @"reUse";

@interface LLImageBrowserController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LLSelectButton *selectButton;
@property (nonatomic, strong) LLToolbar *toolbar;
@property (nonatomic, assign) BOOL needOriginal;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIView *pointView;
@property (nonatomic, strong) UILabel *originalSizeNameLabel;
@property (nonatomic, strong) UILabel *originalSizeLabel;
@property (nonatomic, strong) UIButton *originalButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) dispatch_group_t loadingImageGroup;

@end

@implementation LLImageBrowserController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.toolbar.bottom = kScreenHeight;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildingParams];
    [self buidlingUI];
    [self setOriginSize];
}

- (void)buildingParams {
    LLImagePickerController *navigationController = (LLImagePickerController *)self.navigationController;
    self.needOriginal = navigationController.allowSelectReturnType;
    self.loadingImageGroup = dispatch_group_create();
}

- (void)buidlingUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    [self.collectionView registerClass:[LLBrowserCollectionCell class] forCellWithReuseIdentifier:reUse];
    [self.collectionView reloadData];
    [self.view addSubview:self.toolbar];
    self.toolbar.top = kScreenHeight;
    
    [self.collectionView setContentOffset:CGPointMake(self.index * self.collectionView.width, 0) animated:NO];
    [self.toolbar resetSelectPhotosNumber:[[LLImageSelectHandler instance] selectedAssets].count];
    
    if (iOS8Upwards) {
        PHAsset *asset = self.phAssetsArray[self.index];
        if ([[[LLImageSelectHandler instance] selectedAssets] containsObject:asset]) {
            self.selectButton.selected = YES;
        } else {
            self.selectButton.selected = NO;
        }
    } else {
        ALAsset *asset = self.alAssetsArray[self.index];
        if ([[[LLImageSelectHandler instance] selectedAssets] containsObject:asset]) {
            self.selectButton.selected = YES;
        } else {
            self.selectButton.selected = NO;
        }
    }
}

#pragma mark -
#pragma mark - collectionView protocol methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (iOS8Upwards) {
        return self.phAssetsArray.count;
    }
    return self.alAssetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLBrowserCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reUse forIndexPath:indexPath];
    if (iOS8Upwards) {
        [cell reloadDataWithPHAsset:self.phAssetsArray[indexPath.row]];
    } else {
        [cell reloadDataWithALAsset:self.alAssetsArray[indexPath.row]];
    }
    WeakSelf(self)
    [cell handleSingleTapActionWithBlock:^{
        if (weakSelf.navigationController.navigationBarHidden) {
            [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.toolbar.bottom = kScreenHeight;
            }];
        } else {
            [weakSelf.navigationController setNavigationBarHidden:YES animated:YES];
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.toolbar.top = kScreenHeight;
            }];
        }
    }];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.index = round(scrollView.contentOffset.x / scrollView.width);
    if (iOS8Upwards) {
        PHAsset *asset = self.phAssetsArray[self.index];
        self.selectButton.selected = [[[LLImageSelectHandler instance] selectedAssets] containsObject:asset];
    } else {
        ALAsset *asset = self.alAssetsArray[self.index];
        self.selectButton.selected = [[[LLImageSelectHandler instance] selectedAssets] containsObject:asset];
    }
    [self setOriginSize];
}

- (void)setOriginSize {
    if (!self.needOriginal) {
        return;
    }
    if (iOS8Upwards) {
        PHAsset *asset = self.phAssetsArray[self.index];
        [self.activityIndicator startAnimating];
        self.originalSizeLabel.text = @"";
        [asset originalSize:^(NSString *result) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.originalSizeLabel.text = Format(@"(%@)", result);
            });
        }];
    } else {
        ALAsset *asset = self.alAssetsArray[self.index];
        [self.activityIndicator startAnimating];
        self.originalSizeLabel.text = @"";
        [asset originalSize:^(NSString *result) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.originalSizeLabel.text = Format(@"(%@)", result);
            });
        }];
    }
}

#pragma mark -
#pragma mark - getter methods
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat const kLineSpacing = 20;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, kLineSpacing);
        layout.minimumLineSpacing = kLineSpacing;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth + kLineSpacing, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (LLToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[LLToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - kToolbarHeight, kScreenWidth, kToolbarHeight)];
        _toolbar.barStyle = UIBarStyleBlack;
        [_toolbar hiddenPreviewButton];
        [_toolbar resetFinishedButtonEnable:YES];
        
        WeakSelf(self)
        [_toolbar handleFinishedButtonWithBlock:^{
            [weakSelf handleSelectedFinished];
        }];
        
        [self configToolbar];
    }
    return _toolbar;
}

- (void)configToolbar {
    if (!self.needOriginal) {
        return;
    }
    CGFloat circleRadius = 19.f / 2;
    CGFloat pointRadius = 12.f / 2;
    
    self.circleView = [[UIView alloc] init];
    _circleView.layer.borderColor = HEXACOLOR(0x2c2b2c, 0.5).CGColor;
    _circleView.layer.borderWidth = 1.f;
    _circleView.layer.cornerRadius = circleRadius;
    _circleView.clipsToBounds = YES;
    [self.toolbar addSubview:_circleView];
    
    self.pointView = [[UIView alloc] init];
    _pointView.backgroundColor = HEXCOLOR(0x09c106);
    _pointView.layer.cornerRadius = pointRadius;
    _pointView.clipsToBounds = YES;
    _pointView.hidden = YES;
    _pointView.hidden = ![LLImageSelectHandler instance].needOriginal;
    [_circleView addSubview:_pointView];
    
    self.originalSizeNameLabel = [Utils building:1 textColor:HEXCOLOR(0xb0b0b0) textAligment:0 font:BoldFont(12) superview:self.toolbar];
    _originalSizeNameLabel.text = @"原图";
    
    self.originalSizeLabel = [Utils building:1 textColor:HEXCOLOR(0xb0b0b0) textAligment:0 font:BoldFont(12) superview:self.toolbar];
    _originalSizeLabel.text = @"";
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.toolbar addSubview:_activityIndicator];
    
    self.originalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _originalButton.backgroundColor = [UIColor clearColor];
    [_originalButton addTarget:self action:@selector(handleOriginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:_originalButton];
    
    WeakSelf(self)
    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(weakSelf.toolbar);
        make.width.with.height.mas_equalTo(circleRadius * 2);
    }];
    
    [_pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.circleView);
        make.width.with.height.mas_equalTo(pointRadius * 2);
    }];
    
    [_originalSizeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.circleView.mas_right).offset(5);
        make.height.equalTo(weakSelf.toolbar);
        make.centerY.equalTo(weakSelf.toolbar);
    }];
    
    [_originalSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.originalSizeNameLabel.mas_right);
        make.centerY.equalTo(weakSelf.originalSizeNameLabel);
    }];
    
    [_activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.left.equalTo(weakSelf.originalSizeNameLabel.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.toolbar);
    }];

    [_originalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.with.bottom.equalTo(weakSelf.toolbar);
        make.width.mas_equalTo(150);
    }];
}

- (void)handleOriginButtonAction:(UIButton *)sender {
    [LLImageSelectHandler instance].needOriginal = ![LLImageSelectHandler instance].needOriginal;
    self.pointView.hidden = ![LLImageSelectHandler instance].needOriginal;
}

- (LLSelectButton *)selectButton {
    if (!_selectButton) {
        CGFloat kSelectButtonWidth = 38;
        
        _selectButton = [LLSelectButton building];
        _selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        _selectButton.size = CGSizeMake(kSelectButtonWidth, kSelectButtonWidth);
        _selectButton.left = 20;
        
        WeakSelf(self)
        // handle click
        [_selectButton handleSelectButtonEventWithBlock:^(LLSelectButton *sender, BOOL isSelected) {
            if ([[LLImageSelectHandler instance] selectedAssets].count >= [[LLImageSelectHandler instance] maxSelectedCount] && isSelected) {
                [LLMessageDialog showMessageDialog:kPhotosNumberReachedMaxValue];
                sender.selected = NO;
                return;
            }
            if (isSelected) {
                if (iOS8Upwards) {
                    [[LLImageSelectHandler instance] addAsset:weakSelf.phAssetsArray[weakSelf.index]];
                } else {
                    [[LLImageSelectHandler instance] addAsset:weakSelf.alAssetsArray[weakSelf.index]];
                }
                [Utils addScaleAnimation:sender];
            } else {
                if (iOS8Upwards) {
                    [[LLImageSelectHandler instance] removeAsset:weakSelf.phAssetsArray[weakSelf.index]];
                } else {
                    [[LLImageSelectHandler instance] removeAsset:weakSelf.alAssetsArray[weakSelf.index]];
                }
            }
            [weakSelf.toolbar resetSelectPhotosNumber:[[LLImageSelectHandler instance] selectedAssets].count];
        }];
    }
    return _selectButton;
}

#pragma mark -
#pragma mark - selected action finished
- (void)handleSelectedFinished {
    if (![[LLImageSelectHandler instance] selectedAssets].count) {
        [LLMessageDialog showMessageDialog:@"您还没有选择相片"];
        return;
    }
    LLImagePickerController *navigationController = (LLImagePickerController *)self.navigationController;
    [Utils loadingResultAssetsWithBlock:^(NSArray<UIImage *> *images) {
        if (iOS8Upwards) {
            Block_exe(navigationController.phAssetsBlock, images, [LLImageSelectHandler instance].selectedAssets);
        } else {
            Block_exe(navigationController.alAssetsBlock, images, [LLImageSelectHandler instance].selectedAssets);
        }
    }];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [self removeNotificationObserver];
}





@end

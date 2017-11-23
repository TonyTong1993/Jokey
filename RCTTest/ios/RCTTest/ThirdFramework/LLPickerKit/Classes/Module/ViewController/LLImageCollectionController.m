//
//  LLImageCollectionController.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageCollectionController.h"
#import "LLImagePickerController.h"
#import "LLImageCollectionCell.h"
#import "LLImageBrowserController.h"
#import "LLToolbar.h"

static CGFloat const kToolbarHeight = 42.f;
static NSInteger const kPreviewIndex = -1;
static NSString *const reUse = @"reUse";

@interface LLImageCollectionController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LLImageHandler *imageHandler;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LLToolbar *toolbar;
@property (nonatomic, assign) BOOL needOriginal;
@property (nonatomic, copy) NSArray <ALAsset *>*alAssetsArray;
@property (nonatomic, copy) NSArray <PHAsset *>*phAssetsArray;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;

@end

@implementation LLImageCollectionController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    [self buildingParams];
    [self buildingUI];
    [self addObserver];
    [self loadingPhotos];
}

#pragma mark -
#pragma mark - base methods
- (void)buildingParams {
    NSString *title;
    if (iOS8Upwards) {
        title = [Utils replaceEnglishAssetCollectionNamme:self.assetCollection.localizedTitle];
    } else {
        title = [Utils replaceEnglishAssetCollectionNamme:[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    }
    self.title = title;
    self.imageHandler = [[LLImageHandler alloc] init];
    self.lastSelectedIndex = 0;
    LLImagePickerController *navigationController = (LLImagePickerController *)self.navigationController;
    self.needOriginal = navigationController.allowSelectReturnType;
    self.cachingImageManager = [[PHCachingImageManager alloc] init];
}

- (void)buildingUI {
    [self rightBarButton:@"取消" selector:@selector(cancelAction:) delegate:self];
    [self.collectionView registerClass:[LLImageCollectionCell class] forCellWithReuseIdentifier:reUse];
    [self.view addSubview:self.toolbar];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAssetsUpdateNotification:) name:kSelectAssetsUpdateNotification object:nil];
}

- (void)loadingPhotos {
    WeakSelf(self)
    if (iOS8Upwards) {
        [_imageHandler enumerateAssetsInAssetCollection:self.assetCollection finishBlock:^(NSArray <PHAsset *>*result) {
            weakSelf.phAssetsArray = [NSArray arrayWithArray:result];
            [weakSelf.collectionView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView scrollsToBottomAnimated:NO];
            });
        }];
    } else {
        [_imageHandler enumerateAssetsInAssetsGroup:self.assetsGroup finishBlock:^(NSArray<ALAsset *> *result) {
            weakSelf.alAssetsArray = [NSArray arrayWithArray:result];
            [weakSelf.collectionView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView scrollsToBottomAnimated:NO];
            });
        }];
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
    LLImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reUse forIndexPath:indexPath];
    [cell resetSelected:NO];
    if (iOS8Upwards) {
        PHAsset *asset = self.phAssetsArray[indexPath.row];
        [cell reloadDataWithPHAsset:asset index:indexPath.row];
        [cell resetSelected:[[LLImageSelectHandler instance] containsAsset:asset]];
    } else {
        ALAsset *asset = self.alAssetsArray[indexPath.row];
        [cell reloadDataWithALAsset:asset index:indexPath.row];
        [cell resetSelected:[[LLImageSelectHandler instance] containsAsset:asset]];
    }
    WeakSelf(self)
    [cell getSelectedIndexWithBlock:^(NSInteger index) {
        weakSelf.lastSelectedIndex = index;
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self pushToNextPage:indexPath.row animated:YES isPreView:false];
}

#pragma mark -
#pragma mark - button click action methods
- (void)cancelAction:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - observer response methods
- (void)selectAssetsUpdateNotification:(NSNotification *)notification {
    if ([[LLImageSelectHandler instance] selectedAssets].count > 0) {
        [self.toolbar resetPreviewButtonEnable:YES];
        [self.toolbar resetSelectPhotosNumber:[[LLImageSelectHandler instance] selectedAssets].count];
        [self.toolbar resetFinishedButtonEnable:YES];
    } else {
        [self.toolbar resetPreviewButtonEnable:NO];
        [self.toolbar resetSelectPhotosNumber:0];
        [self.toolbar resetFinishedButtonEnable:NO];
    }
}

#pragma mark -
#pragma mark - push methods
- (void)pushToNextPage:(NSInteger)index animated:(BOOL)animated isPreView:(BOOL)preView{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    LLImageBrowserController *browserVC = [[LLImageBrowserController alloc] init];
    if (iOS8Upwards) {
        browserVC.phAssetsArray = preView?[LLImageSelectHandler instance].selectedAssets:self.phAssetsArray;
    } else {
        browserVC.alAssetsArray = preView?[LLImageSelectHandler instance].selectedAssets:self.alAssetsArray;
    }
    browserVC.index = preView?0:(index == kPreviewIndex) ? self.lastSelectedIndex : index;
    [self.navigationController pushViewController:browserVC animated:animated];
}

#pragma mark -
#pragma mark - getter methods
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat kPadding = 3.f;
        CGFloat kWidth = (kScreenWidth - 4 * kPadding) / 3;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kWidth, kWidth);
        layout.sectionInset = UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding);
        layout.minimumInteritemSpacing = kPadding;
        layout.minimumLineSpacing = kPadding;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = HEXCOLOR(0xffffff);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (LLToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[LLToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - kToolbarHeight, kScreenWidth, kToolbarHeight)];
        
        WeakSelf(self)
        // handle click callback
        [_toolbar handlePreviewButtonWithBlock:^{
            [weakSelf pushToNextPage:kPreviewIndex animated:YES isPreView:true];
        }];
        
        [_toolbar handleFinishedButtonWithBlock:^{
            [weakSelf handleSelectedFinished];
        }];
        
        // collectionView edgeInsets
        UIEdgeInsets insets = _collectionView.contentInset;
        insets.bottom = kToolbarHeight;
        _collectionView.contentInset = insets;
    }
    return _toolbar;
}

#pragma mark -
#pragma mark - selected action finished methods
- (void)handleSelectedFinished {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  TYPhotoCollectionViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoCollectionViewController.h"
#import "TYPhotoCollectionViewCell.h"
#import <TBCityIconFont.h>
#import <YYKit/NSArray+YYAdd.h>
#import "TYPhotoSelectedHandler.h"
#import "MBProgressHUD+MJ.h"
#import "TYPhotoGroupViewController.h"
#import "TYPhotoAlbumViewController.h"
#import "TYLocalAlbumPhoto.h"
@interface TYPhotoCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TYPhotoCollectionViewCellDelegate,UIToolbarDelegate>
@property (nonatomic,strong) TYPhotoPresent *present;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,weak) UIToolbar *toolBar;
@property (nonatomic,strong) MBProgressHUD *hud;
@end
static NSString *reuseIdentifier = @"UICollectionViewCell";
static CGFloat margin = 4.0f;
@implementation TYPhotoCollectionViewController

#pragma mark---Getter and Setter
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        int rowCount = 4;
        CGFloat square = floorf((SCREEN_WIDTH - margin*(rowCount+1))/rowCount);
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.itemSize = CGSizeMake(square,square);
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
       
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TYPhotoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        CGFloat bottomEdgeInset = kTopHeight+kTabBarHeight;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, bottomEdgeInset, 0);
        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
       
    }
    return _collectionView;
}
-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        self.present = [[TYPhotoPresent alloc] initWithPresenter:self];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的照片";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    
    //设置默认最大选择数量
    [TYPhotoSelectedHandler sharedTYPhotoSelectedHandler].maxSelectedCount = 6;
    
    //监听相册的授权变化
    __weak typeof(self) weakSelf = self;
    [self.present requestAuthorization:^{
//        [weakSelf.hud showAnimated:true];
        __strong typeof(weakSelf) strongSelf = self;
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            [TYPhotoHandler enumerateAllAssetsInCollectionsWithfinishBlock:^(PHFetchResult<PHAsset *> *result) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [strongSelf.hud hideAnimated:true];
                    strongSelf.fetchResult = result;
                    [strongSelf.collectionView reloadData];
                });
            }];

        });
    }];
    
    //添加相册视图到栈低
    NSArray *stacks = [self.navigationController viewControllers];
    NSMutableArray *newStacks = [[NSMutableArray alloc] initWithArray:stacks];
    TYPhotoAlbumViewController *vc0 = [[TYPhotoAlbumViewController alloc] init];
    [newStacks insertObject:vc0 atIndex:0];
    [self.navigationController setViewControllers:newStacks];
    
    
}

#pragma mark--- init UI

-(void)initUI {
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    
    [self.view addSubview:self.collectionView];
    
    CGRect frame = CGRectMake(0,SCREEN_HEIGHT-kTopHeight-kTabBarHeight, SCREEN_WIDTH, kTabBarHeight);
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:frame];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(goPreview)];
    leftItem.tintColor = HEXCOLOR(themeColorHexValue);
    //normal &#xe96b; selected &#xe96a;
    
    CGRect rect = CGRectMake(0, 0, 80, 49);
    UIButton *middleBtn = [[UIButton alloc] initWithFrame:rect];
    [middleBtn setTitle:@"原图" forState:UIControlStateNormal];
    TBCityIconInfo *iconInfo = TBCityIconInfoMake(@"\U0000e96b", 22, HEXCOLOR(themeColorHexValue));
    UIImage *image = [UIImage iconWithInfo:iconInfo];
    [middleBtn setImage:image forState:UIControlStateNormal];
    TBCityIconInfo *iconSelectedInfo = TBCityIconInfoMake(@"\U0000e96a", 22,HEXCOLOR(themeColorHexValue));
    UIImage *selectedImage = [UIImage iconWithInfo:iconSelectedInfo];
    [middleBtn setImage:selectedImage forState:UIControlStateSelected];
    [middleBtn setTitleColor:HEXCOLOR(themeColorHexValue) forState:UIControlStateNormal];
    middleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [middleBtn addTarget:self action:@selector(chooseOriginal:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *middleItem = [[UIBarButtonItem alloc] initWithCustomView:middleBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendPhotos)];
    rightItem.tintColor = HEXCOLOR(themeColorHexValue);
    UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    NSArray *items = @[leftItem,flexibleitem,middleItem,flexibleitem,rightItem];
    [toolBar setItems:items];
    
    toolBar.barTintColor = [UIColor grayColor];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark---action response
-(void)finish {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goPreview {
    NSLog(@"%s",__func__);
}
-(void)chooseOriginal:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
-(void)sendPhotos {
     NSLog(@"%s",__func__);
}
#pragma mark--UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PHAsset *phAsset = [self.fetchResult objectAtIndex:indexPath.item];
    [phAsset requestThumbnailWithTargetSize:cell.size complicationhandler:^(UIImage *result, NSDictionary *info) {
        cell.thumbnail.image = result;
    }];
    TBCityIconInfo *iconInfo = TBCityIconInfoMake(@"\U0000e8f7", 24, [UIColor whiteColor]);
    UIImage *image = [UIImage iconWithInfo:iconInfo];
    [cell.check setImage:image forState:UIControlStateNormal];
    cell.delegate = self;
    cell.indexPath = indexPath;
    NSMutableArray *selectedPhotos = [TYPhotoSelectedHandler sharedTYPhotoSelectedHandler].selectedPhotos;
    if ([selectedPhotos containsObject:phAsset]) {
        int index = (int)[selectedPhotos indexOfObject:phAsset];
        [cell addSelectedShapeLayer:index+1];
    }else {
        [cell removeSelectedShaperLayer];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TYPhotoGroupViewController *groupView = [[TYPhotoGroupViewController alloc] init];
  
    NSMutableArray *photos = [NSMutableArray array];
    [self.fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            TYLocalAlbumPhoto *photo = [TYLocalAlbumPhoto new];
            photo.phAsset = obj;
            [photos addObject:photo];
        }
    }];
    groupView.photos = photos;
    groupView.selectedIndex = indexPath.item;
    [self.navigationController pushViewController:groupView animated:YES];
}
#pragma mark---TYPhotoCollectionViewCellDelegate
-(void)photocell:(TYPhotoCollectionViewCell *)cell didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *phAsset = [self.fetchResult objectAtIndex:indexPath.item];
    NSMutableArray *selectedPhotos = [TYPhotoSelectedHandler sharedTYPhotoSelectedHandler].selectedPhotos;
    NSUInteger count = selectedPhotos.count;
    BOOL isSelected = [selectedPhotos containsObject:phAsset];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:8];
    BOOL isMax = (count >= [TYPhotoSelectedHandler sharedTYPhotoSelectedHandler].maxSelectedCount);
    if (!isSelected) {
        if (isMax) {
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"你最多只能选择%u张照片",(unsigned)count] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alerVC addAction:sureAction];
            [self presentViewController:alerVC animated:YES completion:nil];
            return;
        }
        [selectedPhotos addObject:phAsset];
        [indexPaths addObject:indexPath];
    }else {
        NSUInteger index = [selectedPhotos indexOfObject:phAsset];
        NSUInteger len = count-1 - index;
        NSArray *subArray = [selectedPhotos subarrayWithRange:NSMakeRange(index+1, len)];
        [subArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSUInteger index = [self.fetchResult indexOfObject:obj];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [indexPaths addObject:indexPath];
        }];
        [selectedPhotos removeObject:phAsset];
        [cell removeSelectedShaperLayer];
        
    }
    if (indexPaths.count) {
        [self.collectionView reloadItemsAtIndexPaths:indexPaths];
    }
    
}

@end

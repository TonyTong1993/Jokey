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
@interface TYPhotoCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) TYPhotoPresent *present;
@property (nonatomic,strong) UICollectionView *collectionView;
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
        
        CGFloat bottomEdgeInset =is_iPhoneX?83.0f:64.0f;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, bottomEdgeInset, 0);
        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
       
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的照片";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.present = [[TYPhotoPresent alloc] initWithPresenter:self];
    __weak typeof(self) weakSelf = self;
    [self.present requestAllPhAssets:^(PHFetchResult<PHAsset *> *result) {
        weakSelf.fetchResult = result;
    }];
    
    //
    if (!self.fetchResult.count) return;
    [self.view addSubview:self.collectionView];
    
}
#pragma mark---action response
-(void)finish {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
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
    //&#xe8f7;e6df
    TBCityIconInfo *iconInfo = TBCityIconInfoMake(@"\U0000e8f7", 24, [UIColor whiteColor]);
    UIImage *image = [UIImage iconWithInfo:iconInfo];
    [cell.check setImage:image forState:UIControlStateNormal];
    return cell;
}



@end

//
//  TYPhotoPickerViewControlller.m
//  RCTTest
//
//  Created by 童万华 on 2017/11/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYPhotoPickerViewControlller.h"
#import "TYPhotoHandler.h"
#import "TYPhotoCollectionViewController.h"
@implementation TYPhotoPickerViewControlller
-(instancetype)init {
    self = [super init];
    if (self) {
      
    }
    return self;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    TBCityIconInfo *iconInfo = TBCityIconInfoMake(@"\U0000e6e9;", 28, HEXCOLOR(0xcccccc));
    UIImage *image = [UIImage iconWithInfo:iconInfo];
    UIButton *backButton =  [[UIButton alloc] init];
    [backButton sizeToFit];
    [self.view addSubview:backButton];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(40);
        make.leading.mas_equalTo(self.view.mas_leading).offset(20);
    }];
    
    [self setUpTableView];
    
    [TYPhotoHandler  enumeratePHAssetCollectionsWithResultHandler:^(NSArray<PHAssetCollection *> *result) {
        [result enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [TYPhotoHandler  enumerateAssetsInAssetCollection:obj finishBlock:^(NSArray<PHAsset *> *result) {
                NSLog(@"result.count = %lu",result.count);
            }];
        }];
        self.dataSource = result;
        [self.tableView reloadData];
    }];
  
}
-(void)setUpTableView {
    [super setUpTableView];
    
    self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuserIndentifier = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuserIndentifier];
    }
    PHAssetCollection *assetCollection = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = assetCollection.localizedTitle;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     PHAssetCollection *assetCollection = [self.dataSource objectAtIndex:indexPath.row];
    __block NSArray *dataSource;
    [TYPhotoHandler  enumerateAssetsInAssetCollection:assetCollection finishBlock:^(NSArray<PHAsset *> *result) {
        dataSource = result;
    }];
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = ceil((SCREEN_WIDTH-10*4)/3);
    flowlayout.itemSize =CGSizeMake(width, width);
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    TYPhotoCollectionViewController *collectionViewController = [[TYPhotoCollectionViewController alloc] initWithCollectionViewLayout:flowlayout];
    collectionViewController.dataSource = dataSource;
    [self.navigationController pushViewController:collectionViewController animated:YES];
}
#pragma mark--Private Method
-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

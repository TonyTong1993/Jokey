//
//  TYPhotoAlbumViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoAlbumViewController.h"
#import "TYPhotoPresent.h"
#import "TYPhotoAlbumViewCell.h"
#import "PHAssetCollection+Poster.h"
#import <MBProgressHUD.h>
@interface TYPhotoAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) TYPhotoPresent *present;
@property (nonatomic,strong) NSArray *phcollections;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation TYPhotoAlbumViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        self.present = [[TYPhotoPresent alloc] initWithPresenter:self];
    }
    return self;
}

#pragma mark--Getter and Setter
-(MBProgressHUD *)hud {
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的相册";
    [self initUI];
    //设置加载相册的进度

    __weak typeof(self) weakSelf = self;
    [self.present requestAuthorization:^{
        [weakSelf.hud showAnimated:true];
        [TYPhotoHandler enumeratePHAssetCollectionsWithResultHandler:^(NSArray<PHAssetCollection *> *result) {
            [weakSelf.hud hideAnimated:true];
            weakSelf.phcollections = result;
            [weakSelf.tableView  reloadData];
        }];
    }];
   
}

#pragma mark--- init UI
-(void)initUI {
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TYPhotoAlbumViewCell class]) bundle:nil] forCellReuseIdentifier:@"PHAssetCollectionPosterViewIdentifier"];
    
    CGFloat bottomOffset = 0.0f;
    if (@available(iOS 11, *)) {
        //关闭Self-Sizing
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        bottomOffset = is_iPhoneX?83.0f:64.0f;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
        bottomOffset = 64.0f;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomOffset, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

-(void)finish {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark---UITableViewDataSource--UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.phcollections.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAssetCollection *collection = self.phcollections[indexPath.row];
   TYPhotoAlbumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PHAssetCollectionPosterViewIdentifier"];
    [collection posterImage:^(UIImage *result, NSDictionary *info) {
        cell.posterView.image = result?:[UIImage imageNamed:@"placeholder"];
    }];
   NSString *text = [PHAssetCollection replaceEnglishAssetCollectionNamme:collection.localizedTitle];
   NSString *number = [NSString stringWithFormat:@"(%ld)",collection.numberOfAssets];
    cell.titleLabel.text = text;
    cell.numberLabel.text = number;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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

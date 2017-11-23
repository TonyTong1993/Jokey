//
//  LLImageGroupController.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageGroupController.h"
#import "LLImageGroupCell.h"
#import "LLImageCollectionController.h"

static NSString *const reUse = @"reUse";

@interface LLImageGroupController () <UITableViewDelegate, UITableViewDataSource> {
    NSTimer *_timer;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LLImageHandler *imageHandler;
@property (nonatomic, copy) NSArray <ALAssetsGroup *>*assetGroups;
@property (nonatomic, copy) NSArray <PHAssetCollection *>*assetCollections;
@property (nonatomic, assign) BOOL pushToCollectionPage;

@end

@implementation LLImageGroupController

#pragma mark -
#pragma mark - base methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildingParams];
        [self buildingUI];
        [self addObserver];
       
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[LLImageSelectHandler instance] removeAllAssets];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self checkInitialAuthority];
}

- (void)buildingParams {
    self.title = @"照片";
    self.imageHandler = [[LLImageHandler alloc] init];
    self.pushToCollectionPage = NO;
}

- (void)buildingUI {
    [self rightBarButton:@"取消" selector:@selector(cancelAction:) delegate:self];
    [self.tableView registerClass:[LLImageGroupCell class] forCellReuseIdentifier:reUse];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePushToCollectionPage:) name:kPushToCollectionPageNotification object:nil];
    
}
-(void)checkInitialAuthority {
    if (iOS8Upwards) {
        [LLImageHandler requestAuthorization:^(LLAuthorizationStatus status) {
            switch (status) {
                case LLAuthorizationStatusNotDetermined:
                {
                    [self setupTimer];
                    [self loadingPhotos];
                   
                }
                    break;
                case LLAuthorizationStatusRestricted:
                    
                    break;
                case LLAuthorizationStatusDenied:
                {
                   
                    
                 
                }
                    
                    break;
                case LLAuthorizationStatusAuthorized:
                {
                    [self cancelTimer];
                    
                   
                    [self loadingPhotos];
                }
                    break;
            }
        }];
    }else {
        LLAuthorizationStatus status = [LLImageHandler requestAuthorization];
        switch (status) {
            case LLAuthorizationStatusNotDetermined:
            {
                [self setupTimer];
                [self loadingPhotos];
            }
                break;
            case LLAuthorizationStatusRestricted:
                
                break;
            case LLAuthorizationStatusDenied:
                
                break;
            case LLAuthorizationStatusAuthorized:
            {
                [self cancelTimer];
                [self loadingPhotos];
            }
                break;
        }
    }
}
- (void)loadingPhotos {
    WeakSelf(self)
    if (iOS8Upwards) {
        [_imageHandler enumeratePHAssetCollectionsWithResultHandler:^(NSArray<PHAssetCollection *> *result) {
            weakSelf.assetCollections = [NSArray arrayWithArray:result];
            [weakSelf.tableView reloadData];
            if (weakSelf.pushToCollectionPage&& weakSelf.assetCollections.count > 0) {
               
                [weakSelf pushToNextPage:0 animated:NO];
            }else {
                 weakSelf.pushToCollectionPage = false;
            }
        }];
    } else {
        [_imageHandler enumerateALAssetsGroupsWithResultHandler:^(NSArray<ALAssetsGroup *> *result) {
            weakSelf.assetGroups = [NSArray arrayWithArray:result];
            [weakSelf.tableView reloadData];
            if (weakSelf.pushToCollectionPage && weakSelf.assetCollections.count > 0) {
                    [weakSelf pushToNextPage:0 animated:NO];
                
            }else {
                 weakSelf.pushToCollectionPage = false;
            }
        }];
    }
}
-(void)setupTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1
                                         target:self
                                       selector:@selector(handleTimerAction:)
                                       userInfo:nil
                                        repeats:true];
    }
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
}
-(void)cancelTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)handleTimerAction:(NSTimer *)timer{
   
    if (iOS8Upwards) {
        [LLImageHandler requestAuthorization:^(LLAuthorizationStatus status) {
            switch (status) {
                case LLAuthorizationStatusAuthorized:
                {
                    [self cancelTimer];
                    [self loadingPhotos];
                }
                    break;
            }
        }];
    }else {
        LLAuthorizationStatus status = [LLImageHandler requestAuthorization];
        switch (status) {
            case LLAuthorizationStatusAuthorized:
            {
                [self cancelTimer];
                [self loadingPhotos];
            }
                break;
        }
    }
    
}
#pragma mark -
#pragma mark - tableView protocol methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (iOS8Upwards) {
        return self.assetCollections.count;
    }
    return self.assetGroups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LLImageGroupCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLImageGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reUse forIndexPath:indexPath];
    if (iOS8Upwards) {
        [cell reloadDataWithAssetCollection:self.assetCollections[indexPath.row]];
    } else {
        [cell reloadDataWithAssetsGroup:self.assetGroups[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToNextPage:indexPath.row animated:YES];
}

#pragma mark -
#pragma mark - button click action methods
- (void)cancelAction:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 
#pragma mark - observer response methods
- (void)handlePushToCollectionPage:(NSNotification *)notification {
    self.pushToCollectionPage = YES;
}

#pragma mark - 
#pragma mark - other methods
- (void)pushToNextPage:(NSInteger)index animated:(BOOL)animated {
    if (iOS8Upwards && index >= self.assetCollections.count) {
        return;
    }
    if (!iOS8Upwards && index >= self.assetGroups.count) {
        return;
    }
    LLImageCollectionController *imageCollectionVC = [[LLImageCollectionController alloc] init];
    if (iOS8Upwards) {
        PHAssetCollection *collection = self.assetCollections[index];
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        imageCollectionVC.assetCollection = collection;
        imageCollectionVC.fetchResult = fetchResult;
    } else {
        ALAssetsGroup *group = self.assetGroups[index];
        imageCollectionVC.assetsGroup = group;
    }
    [self.navigationController pushViewController:imageCollectionVC animated:animated];
}

#pragma mark -
#pragma mark - getter methods
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
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

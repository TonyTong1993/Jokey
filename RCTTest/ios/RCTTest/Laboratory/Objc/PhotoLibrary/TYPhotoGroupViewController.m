//
//  TYPhotoGroupViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoGroupViewController.h"
#import "TYBrowserView.h"
@interface TYPhotoGroupViewController ()<TYBrowserViewDelegate,TYBrowserViewDataSource>
@property (nonatomic,strong) TYBrowserView *photoGroupView;
@end

@implementation TYPhotoGroupViewController
-(TYBrowserView *)photoGroupView {
    if (!_photoGroupView) {
        _photoGroupView = [[TYBrowserView alloc] init];
        _photoGroupView.delegate = self;
        _photoGroupView.dataSource  = self;
    }
    return _photoGroupView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.photoGroupView];
 
}
// WARNING: if set  self.navigationController.navigationBarHidden = YES; 会出现缝隙合龙的效果
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   self.navigationController.navigationBarHidden = NO;

}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark---TYPhotoGroupViewDelegate
-(void)photoBrowserViewDissmissActionResponder {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)photoBrowserViewCheckActionResponder {
    
}
-(NSUInteger)selectedIndexInBrowserView {
    return self.selectedIndex;
}
-(NSUInteger)numberOfPhotosInBrowserView {
    return self.photos.count;
}
-(TYPhoto *)browserView:(UIView *)browserView photoForRowAtIndex:(NSUInteger)index {
    return self.photos[index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

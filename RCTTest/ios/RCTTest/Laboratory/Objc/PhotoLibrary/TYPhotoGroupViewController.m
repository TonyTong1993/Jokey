//
//  TYPhotoGroupViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoGroupViewController.h"
#import "TYPhotoGroupView.h"
@interface TYPhotoGroupViewController ()<TYPhotoGroupViewDelegate>
@property (nonatomic,strong) TYPhotoGroupView *photoGroupView;
@end

@implementation TYPhotoGroupViewController
-(TYPhotoGroupView *)photoGroupView {
    if (!_photoGroupView) {
        _photoGroupView = [[TYPhotoGroupView alloc] init];
        _photoGroupView.delegate = self;
    }
    return _photoGroupView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.photoGroupView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   self.navigationController.navigationBarHidden = NO;

}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark---TYPhotoGroupViewDelegate
-(void)photoGroupViewDissmissActionResponder {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)photoGroupViewCheckActionResponder {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

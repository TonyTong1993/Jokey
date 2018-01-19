//
//  TYPublicViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/11/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYPublicViewController.h"
#import "TYPhotoPickerViewControlller.h"
#import "TYPhotoHandler.h"
@interface TYPublicViewController ()

@end

@implementation TYPublicViewController

- (void)viewDidLoad {
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
    
    UIButton *addPhotoButton =  [[UIButton alloc] init];
    [addPhotoButton setTitle:@"访问相册" forState:UIControlStateNormal];
    [addPhotoButton setTitleColor:HEXCOLOR(textTint) forState:UIControlStateNormal];
    [addPhotoButton sizeToFit];
    [self.view addSubview:addPhotoButton];
    [addPhotoButton addTarget:self action:@selector(enterPhotoPicker) forControlEvents:UIControlEventTouchUpInside];
    
    addPhotoButton.center = self.view.center;
}

-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)enterPhotoPicker {
    
    [TYPhotoHandler requestAuthorization:^(TYAuthorizationStatus status) {
        switch (status) {
                
            case TYAuthorizationStatusNotDetermined:
            case TYAuthorizationStatusAuthorized:
            {
                TYPhotoPickerViewControlller *photoPicker = [[TYPhotoPickerViewControlller alloc] init];
                [self.navigationController pushViewController:photoPicker animated:YES];
            }
                break;
                
            case TYAuthorizationStatusRestricted:
            case TYAuthorizationStatusDenied:
            {
                //请求权限
                if ( [[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
            }
                break;
                
        }
    }];
}
@end

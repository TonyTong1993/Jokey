//
//  TYLoginViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYLoginViewController.h"
#import "AppDelegate.h"
#import "TYTabBarController.h"
#import <CocoaSecurity/CocoaSecurity.h>
#import  <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+MJ.h"
#if !TARGET_IPHONE_SIMULATOR
#import <Hyphenate/Hyphenate.h>
#endif

@interface TYLoginViewController ()<UITextFieldDelegate>
@property(strong ,nonatomic) UITextField* atextField;
@property(strong ,nonatomic) UITextField* mtextField;
@end

@implementation TYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *atextField = [[UITextField alloc] init];
    atextField.accessibilityLabel = @"aTextField";
    atextField.delegate = self;
    atextField.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:14];
    atextField.placeholder = @"please input phone number";
    atextField.keyboardType = UIKeyboardTypeNumberPad;
    self.atextField = atextField;
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:14];
    aLabel.textColor  = HEXCOLOR(0x333);
    aLabel.text = @"账号:";
    
   
    UIStackView *astackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
    [astackView addArrangedSubview:atextField];
    [astackView addArrangedSubview:aLabel];
    [astackView insertArrangedSubview:atextField atIndex:1];
    astackView.spacing = 8;
    
    UITextField *mtextField = [[UITextField alloc] init];
    mtextField.accessibilityLabel = @"pwTextField";
    mtextField.delegate = self;
    mtextField.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:14];
    mtextField.placeholder = @"please input password";
    mtextField.secureTextEntry = YES;
    mtextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.mtextField = mtextField;
    UILabel *mLabel = [[UILabel alloc] init];
    mLabel.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:14];
    mLabel.textColor  = HEXCOLOR(0x333);
    mLabel.text = @"密码:";
    UIStackView *mstackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
    [mstackView addArrangedSubview:mtextField];
    [mstackView addArrangedSubview:mLabel];
    [mstackView insertArrangedSubview:mtextField atIndex:1];
    mstackView.spacing = 8;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.accessibilityLabel = @"login";
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = HEXCOLOR(themeColorHexValue);
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 250, 140)];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 10;
    [stackView addArrangedSubview:astackView];
    [stackView addArrangedSubview:mstackView];
    [stackView addArrangedSubview:loginBtn];

    [self.view addSubview:stackView];
    stackView.center = self.view.center;
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_atextField.isFirstResponder) {
        [_atextField resignFirstResponder];
    }
    if (_mtextField.isFirstResponder) {
        [_mtextField resignFirstResponder];
    }
}
-(void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}
/*1用户名及密码检验、2用户密码加密、3上传用户登录状态、4切换视图*/
-(void)loginAction {
    //用户名及密码检验
    int alength = (int)_atextField.text.length;
    int mlength = (int)_mtextField.text.length;
    if (!alength) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    
    if (!mlength) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    
    if (alength < 3 || mlength < 3) {
        [MBProgressHUD showError:@"请检查用户名或密码输入"];
        return;
    }
    
    //用户密码加密
    CocoaSecurityResult *pwd = [CocoaSecurity md5:_mtextField.text];
    NSLog(@"pwd = %@",pwd.hex);
    
    //模拟数据上传上传状态提示
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //修改hud样式

    //显示hud
    [hud show:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //隐藏hud
        [hud hide:true];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:APP_Login_Key];
#if !TARGET_IPHONE_SIMULATOR
        //登录环信
        [[EMClient sharedClient] loginWithUsername:@"19011100528"
                                          password:@"123456"
                                        completion:^(NSString *aUsername, EMError *aError) {
                                            if (!aError) {
                                                NSLog(@"登录成功");
                                            } else {
                                                NSLog(@"登录失败");
                                            }
                                        }];
#endif
        //切换window视图
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *window = app.window;
        TYTabBarController *rootVC = [[TYTabBarController alloc] init];
        window.rootViewController = rootVC;
        [window makeKeyAndVisible];
    });
    
    
};

#pragma mark---UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //特殊字符过滤如空格
    
    //控制输入长度
    
    return YES;
}
@end

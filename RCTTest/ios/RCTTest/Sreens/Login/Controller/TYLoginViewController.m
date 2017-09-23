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
@interface TYLoginViewController ()<UITextFieldDelegate>
@property(strong ,nonatomic) UITextField* atextField;
@property(strong ,nonatomic) UITextField* mtextField;
@end

@implementation TYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *atextField = [[UITextField alloc] init];
    atextField.delegate = self;
    atextField.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:14];
    atextField.placeholder = @"请输入手机号";
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
    mtextField.delegate = self;
    mtextField.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:14];
    mtextField.placeholder = @"请输入密码";
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
    if (_atextField.text.length < 3 && _mtextField.text.length < 3) {
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
    [hud showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //隐藏hud
        [hud hideAnimated:true];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:APP_Login_Key];
        
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

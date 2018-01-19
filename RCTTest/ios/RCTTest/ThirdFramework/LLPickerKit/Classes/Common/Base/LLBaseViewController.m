//
//  BaseViewController.m
//  Fplan
//
//  Created by 雷亮 on 16/8/15.
//  Copyright © 2016年 bikeLockTec. All rights reserved.
//

#import "LLBaseViewController.h"

@interface LLBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation LLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.canDragBack = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark - configure UI
- (void)rightBarButton:(NSString *)aTitle selector:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(textTint) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    float width = 50;
    if ([aTitle length] > 2) {
        width = 50 + ([aTitle length] - 2) * 10;
    }
    button.frame = CGRectMake(0, 0, width, 34);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7Upwards) {
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        fixedSpace.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fixedSpace, barButton, nil];
    } else {
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)rightBarButton:(NSString *)aTitle selector:(SEL)sel delegate:(id)delegate {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(textTint) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    float width = 50;
    if ([aTitle length] > 2) {
        width = 50 + ([aTitle length] - 2) * 10;
    }
    button.frame = CGRectMake(0, 0, width, 34);
    [button addTarget:delegate action:sel forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7Upwards) {
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        fixedSpace.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fixedSpace, barButton, nil];
    } else {
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)rightBarButtonWithImage:(NSString *)imageName withBtnSize:(CGSize)size selector:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7Upwards) {
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        fixedSpace.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fixedSpace, barButton, nil];
    } else {
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)rightBarButtonWithImage:(NSString *)imageName withBtnSize:(CGSize)size selector:(SEL)sel delegate:(id)delegate {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button addTarget:delegate action:sel forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7Upwards) {
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        fixedSpace.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fixedSpace, barButton, nil];
    } else {
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)leftBarButton:(NSString *)aTitle selector:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(textTint) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    float width = 50;
    if ([aTitle length] > 2) {
        width = 50 + ([aTitle length] - 2) * 10;
    }
    button.frame = CGRectMake(0, 0, width, 34);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7Upwards) {
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        fixedSpace.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:fixedSpace, barButton, nil];
    } else {
        self.navigationItem.leftBarButtonItem = barButton;
    }
}

- (void)leftBarButtonWithImage:(NSString *)imageName withBtnSize:(CGSize)size selector:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7Upwards) {
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
        fixedSpace.width = -5;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:fixedSpace, barButton, nil];
    } else {
        self.navigationItem.leftBarButtonItem = barButton;
    }
}

#pragma mark -
#pragma mark - setter methods
- (void)setCanDragBack:(BOOL)canDragBack {
    _canDragBack = canDragBack;
    if (canDragBack) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    } else {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.size = CGSizeMake(100, 33);
    titleLabel.font = BoldFont(18);
    titleLabel.textColor = HEXCOLOR(textTint);
    titleLabel.textAlignment = 1;
    titleLabel.numberOfLines = 1;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

#pragma mark -
#pragma mark - back action
- (void)backToHomePage {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - 找到当前ViewController的第一响应者
- (UIView *)findFirstResponderInView:(UIView *)topView {
    if ([topView isFirstResponder]) {
        return topView;
    }
    
    for (UIView* subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        
        UIView *firstResponderCheck = [self findFirstResponderInView:subView];
        if (nil != firstResponderCheck) {
            return firstResponderCheck;
        }
    }
    return nil;
}

- (UIView *)findFirstResponder {
    UIView *view = [self findFirstResponderInView:self.view];
    if (view) {
        return view;
    } else {
        return [self findFirstResponderInView:self.navigationController.navigationBar];
    }
}

#pragma mark -
#pragma mark - remove observer
- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - deinit
- (void)dealloc {
    LLog(@"%@", self);
}

@end

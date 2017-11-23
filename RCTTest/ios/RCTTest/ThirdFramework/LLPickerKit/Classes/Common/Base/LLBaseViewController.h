//
//  BaseViewController.h
//  Fplan
//
//  Created by 雷亮 on 16/8/15.
//  Copyright © 2016年 bikeLockTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface LLBaseViewController : UIViewController

/**
 * @brief canDragBack: default is YES, if NO, you can't dragBack to last viewController
 */
@property (nonatomic, assign) BOOL canDragBack;

- (UIView *)findFirstResponder;

// 移除监听
- (void)removeNotificationObserver;

- (void)rightBarButton:(NSString *)aTitle selector:(SEL)sel;
- (void)rightBarButton:(NSString *)aTitle selector:(SEL)sel delegate:(id)delegate;
- (void)rightBarButtonWithImage:(NSString *)imageName withBtnSize:(CGSize)size selector:(SEL)sel;
- (void)rightBarButtonWithImage:(NSString *)imageName withBtnSize:(CGSize)size selector:(SEL)sel delegate:(id)delegate;
- (void)leftBarButton:(NSString *)aTitle selector:(SEL)sel;
- (void)leftBarButtonWithImage:(NSString *)imageName withBtnSize:(CGSize)size selector:(SEL)sel;


@end

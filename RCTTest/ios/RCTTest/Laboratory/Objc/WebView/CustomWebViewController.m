//
//  CustomWebViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/6.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "CustomWebViewController.h"
#import <WebKit/WebKit.h>
#import <CocoaSecurity.h>
#import <YYKit/NSObject+YYAddForKVO.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
@interface CustomWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) WKWebViewJavascriptBridge *bridge;
@end

@implementation CustomWebViewController

#pragma mark---Getter and Setter

-(UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = HEXCOLOR(themeColorHexValue);
        _progressView.trackTintColor = HEXCOLOR(separatorColorHexValue);
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 2);
        _progressView.frame = frame;
        _progressView.transform = CGAffineTransformMakeScale(1.0, 1.5f);
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [WebViewJavascriptBridgeBase enableLogging];
    //添加WebViewJavascriptBridge
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"处理完js端的data后回传给js的data");
    }];
    
    [_bridge callHandler:@"testJavascriptHandler" data:@"native传给js处理的data"];
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.10.46:8020/bdtm/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"✅" style:UIBarButtonItemStylePlain target:self action:@selector(handleClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.progressView];
    __weak typeof(self) weakSelf = self;
    [self.webView addObserverBlockForKeyPath:@"estimatedProgress" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
        weakSelf.progressView.progress = weakSelf.webView.estimatedProgress;
        if (weakSelf.progressView.progress == 1) {
            
            [UIView animateWithDuration:0.25f animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }];

}
- (void)dealloc {
    [self.webView removeObserverBlocksForKeyPath:@"estimatedProgress"];
}
-(void)handleClicked {
    NSString *script = @"showAlert()";
    [self.webView evaluateJavaScript:script completionHandler:^(id _Nullable script, NSError * _Nullable error) {
        
    }];
}


#pragma mark--WKNavigationDelegate
-(void)webViewDidClose:(WKWebView *)webView {//ios 9.0
     NSLog(@"%s", __FUNCTION__);
}

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
   
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);

}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
   
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
    
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
   
    
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
        textField.placeholder = defaultText;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}
#pragma mark--WKUIDelegate

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    //  在发送请求之前，决定是否跳转
//
////    WKNavigationActionPolicy policy;
////    if (_isPush) {
////        policy = WKNavigationActionPolicyCancel;
////        [self.navigationController pushViewController:[[self class] new] animated:YES];
////    }else {
////        _isPush = YES;
////        policy = WKNavigationActionPolicyAllow;
////    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//
//}
//
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{

    // 页面开始加载时调用

    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您访问的网页似乎已经不存在了" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];

    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {

    // 当内容开始返回时调用



}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    // 页面加载完成之后调用
      self.title = webView.title;


}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您访问的网页似乎已经不存在了" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];

    [self presentViewController:alert animated:YES completion:NULL];
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

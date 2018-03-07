//
//  CustomWebViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/6.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "CustomWebViewController.h"
#import <WebKit/WebKit.h>
#import "TYURLProtocol.h"
#import <CocoaSecurity.h>
@interface CustomWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,weak) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;
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
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [NSURLProtocol registerClass:[TYURLProtocol class]];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"http://192.168.10.41:8020/bdtm/index.html?__hbt=1520245467770#"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    self.webView = webView;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"✅" style:UIBarButtonItemStylePlain target:self action:@selector(handleClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.progressView];
    [_progressView setProgress:0.5 animated:YES];

}
-(void)handleClicked {
    NSString *script = @"showAlert()";
    [self.webView evaluateJavaScript:script completionHandler:^(id _Nullable script, NSError * _Nullable error) {
        
    }];
}

-(void)webViewDidClose:(WKWebView *)webView {
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
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //  在发送请求之前，决定是否跳转
    NSLog(@"%s",__func__);
    WKNavigationActionPolicy policy;
    if (_isPush) {
        policy = WKNavigationActionPolicyCancel;
        [self.navigationController pushViewController:[[self class] new] animated:YES];
    }else {
        _isPush = YES;
        policy = WKNavigationActionPolicyAllow;
    }
    decisionHandler(policy);

}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    // 页面开始加载时调用
   
    [_progressView setProgress:0.9 animated:YES];
}


//以下三个是连续调用



- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    // 在收到响应后，决定是否跳转和发送请求之前那个允许配套使用
    decisionHandler(WKNavigationResponsePolicyAllow);
   
    
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
    [_progressView setProgress:1.0 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_progressView removeFromSuperview];
        _progressView = nil;
    });
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"%s",__func__);
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

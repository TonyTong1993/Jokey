//
//  RCTTestUITests.m
//  RCTTestUITests
//
//  Created by 童万华 on 2017/10/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RCTTestUITests : XCTestCase

@end

@implementation RCTTestUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    

    
}
- (void)testAutoLoginModule {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *account = app.textFields[@"aTextField"];
    XCUIElement *pwd = app.secureTextFields[@"pwTextField"];
    //判断账号密码是否都是偶数 是则跳转 不是则直接下一次测试
    //跳转后等待3s 返回登录界面
    
        int acc = arc4random() % 1000000 + 1000000;
        int pw = arc4random() % 1000000 + 1000000;
        [account tap];
        [account typeText:[NSString stringWithFormat:@"%d",acc]];
        [pwd tap];
        [pwd typeText:[NSString stringWithFormat:@"%d",pw]];
        
        //点击登录
        [app.buttons[@"login"] tap];
        //模拟正常登录网络访问等待3s
         [app.navigationBars.element pressForDuration:3];
        //判断是否跳转到登录之后的界面 如果是 则登录成功
        if ([app.navigationBars.element.identifier isEqualToString:@"首页"]) {
            [app.navigationBars[@"首页"].buttons[@"Mune"] tap];
        }else{
            NSLog(@"登录失败");
        }

}

@end

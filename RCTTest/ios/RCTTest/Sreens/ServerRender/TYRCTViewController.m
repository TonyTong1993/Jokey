//
//  TYRCTViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRCTViewController.h"
#import "TYHomeViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTConvert.h>
#import "AppDelegate.h"
@interface TYRCTViewController ()<RCTBridgeModule>

@end

@implementation TYRCTViewController
RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
-(instancetype)init {
    self = [super init];
    if (self) {
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doPushNotification:) name:@"RNOpenOneVC" object:nil];
    }
    return self;
}

- (void)doPushNotification:(NSNotification *)notification{
    
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}
-(void)dealloc {
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RNOpenOneVC" object:nil];
}
@end

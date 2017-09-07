//
//  TYRCTModule.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRCTModule.h"
#import "RCTBridge.h"
#import "TYPoprosManager.h"
@implementation TYRCTModule

RCT_EXPORT_MODULE(TYRCTModule)

RCT_EXPORT_METHOD(RNOpenOneVC:(NSString *)msg){
    
    NSLog(@"RN传入原生界面的数据为:%@",msg);
    //主要这里必须使用主线程发送,不然有可能失效
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"RNOpenOneVC" object:nil];
//    });
}

RCT_EXPORT_METHOD(rnGetPoprolengNotification:(NSDictionary *)dictionary){
    
    NSLog(@"RN传入原生界面的数据为:%@",dictionary);
    __weak __typeof(&*[TYPoprosManager sharePoprosManager]) poprosManager = [TYPoprosManager sharePoprosManager];
    //主要这里必须使用主线程发送,不然有可能失效
    dispatch_async(dispatch_get_main_queue(), ^{
        poprosManager.poproLeng = [dictionary[@"length"] integerValue];
    });
}
@end



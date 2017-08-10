//
//  TYServiceApi.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYServiceApi.h"

@implementation TYServiceApi

NSString * const  api_common = @"http://tbfile.ixiaochuan.cn";
NSString * const  api_common_avatar = @"/account/avatar/id/";
NSString * const  api_common_image = @"/img/view/id/";

+(NSString *)serviceForImagePath:(NSString *)path imageID:(NSUInteger)imageID  {
    return  [NSString stringWithFormat:@"%@%@%lu/sz/228",api_common,path,imageID];
}
@end

@implementation TYServiceApi(Home)

const NSString *api_home = @"";

@end

@implementation TYServiceApi(Mail)

const NSString *api_mail = @"";

@end

@implementation TYServiceApi(Profile)

const NSString *api_profile = @"";

@end

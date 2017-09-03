//
//  TYServiceApi.h
//  RCTTest
//
//  Created by 童万华 on 2017/7/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
//通用接口
@interface TYServiceApi : NSObject

extern NSString  * const  api_common;

extern NSString  * const  api_common_avatar;
extern NSString  * const  api_common_image;
extern NSString  * const  api_topic_cover;
+(NSString *)serviceForImagePath:(NSString *)path imageID:(NSUInteger)imageID size:(NSUInteger)size;
@end
//!!!!模块接口
@interface TYServiceApi (Home)

extern const NSString *api_home;

@end

@interface TYServiceApi (Mail)

extern const NSString *api_mail;

@end

@interface TYServiceApi (Video)

extern const NSString *api_mail;

@end

@interface TYServiceApi (Profile)

extern const NSString *api_profile;

@end

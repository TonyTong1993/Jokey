//
//  TYPhotoGroupView.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYPhotoGroupViewDelegate<NSObject>
-(void)photoGroupViewDissmissActionResponder;
-(void)photoGroupViewCheckActionResponder;
@end

@interface TYPhotoGroupItem : NSObject


@end

@interface TYPhotoGroupView : UIView
@property (nonatomic,readonly) NSArray *groupItems;
@property (nonatomic,readonly) NSInteger currentPage;

@property (nonatomic,weak) id<TYPhotoGroupViewDelegate> delegate;

-(instancetype)init;
@end

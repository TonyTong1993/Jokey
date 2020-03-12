//
//  UIScrollView+Refresh.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/1.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
-(void)addHeaderRefreshWithBlock:(void (^)())refreshingBlock {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
    
    NSMutableArray *normalImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%d_54x54_",i+1]];
        [normalImages addObject:image];
    }
    
   NSMutableArray *pullingImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%d_54x54_",i+1]];
        [pullingImages addObject:image];
    }
    
    NSMutableArray *refreshImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%d_54x54_",i+1]];
        [refreshImages addObject:image];
    }
    
    [header setImages:normalImages forState:MJRefreshStateIdle];
    [header setImages:pullingImages  forState:MJRefreshStatePulling];
    [header setImages:refreshImages  forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.mj_header = header;
    self.mj_header.mj_h = 74;
}
-(void)addFooterRefreshWithBlock:(void (^)())refreshingBlock {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
    self.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
}
@end

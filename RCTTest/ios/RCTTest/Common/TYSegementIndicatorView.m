//
//  TYSegementIndicatorView.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYSegementIndicatorView.h"

@implementation TYSegementIndicatorView

+(instancetype)indicatorView {
    TYSegementIndicatorView *view = [[TYSegementIndicatorView alloc] initWithFrame:CGRectZero];
    return view;
}
-(void)refreshIndicatorFrame:(CGRect)react {
    self.frame = react;
}
@end

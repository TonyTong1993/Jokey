//
//  TestView.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/15.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TestView.h"

@implementation TestView {
    CGRect _myFrame;
}

+(TestView *)testView{
    TestView *testView = [[[NSBundle mainBundle]loadNibNamed:@"TestView" owner:nil options:nil] firstObject];
    testView.backgroundColor = [UIColor clearColor];
    return testView;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
}


@end

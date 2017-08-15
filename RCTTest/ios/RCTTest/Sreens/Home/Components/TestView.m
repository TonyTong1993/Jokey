//
//  TestView.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/15.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TestView.h"

@implementation TestView
{
    CGRect myframe;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:@"TestView" owner:nil options:nil];
        self=[nibs objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        myframe = frame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
   self.frame=myframe;
}


@end

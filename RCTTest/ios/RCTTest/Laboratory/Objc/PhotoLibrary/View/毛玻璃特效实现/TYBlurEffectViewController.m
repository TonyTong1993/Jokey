//
//  TYBlurEffectViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYBlurEffectViewController.h"

@interface TYBlurEffectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *extraLight;
@property (weak, nonatomic) IBOutlet UIImageView *light;
@property (weak, nonatomic) IBOutlet UIImageView *dark;

@end

@implementation TYBlurEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png"];
    UIImage *background = [UIImage imageWithContentsOfFile:path];
    UIBlurEffect *blurExtraLight = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *visual = [[UIVisualEffectView alloc] initWithEffect:blurExtraLight];
    visual.frame = self.view.bounds;
    [self.view addSubview:visual];
    
     [self.extraLight setImage:background];
     [self.light setImage:background];
     [self.dark setImage:background];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

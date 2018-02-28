//
//  AdPageView.m
//  RCTTest
//
//  Created by 童万华 on 2018/2/28.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "AdPageView.h"
@interface AdPageView()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

@property (nonatomic, copy) TapBlock tapBlock;

@end
// 广告显示的时间
static int const showtime = 5;

@implementation AdPageView
- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
-(instancetype)initWithFrame:(CGRect)frame withTapBlock:(TapBlock)tapBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.contentMode = UIViewContentModeScaleToFill;
        _adView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAdViewController)];
        [_adView addGestureRecognizer:tapGesture];
        [self addSubview:_adView];
    
       
        
        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW - 24, kTopHeight, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        [self addSubview:_countBtn];
        
        NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
        if ([self isFileExistsWithFilePath:filePath]) {
            [self setFilePath:filePath];
             _tapBlock = tapBlock;
            [self show];
        }
        
        
        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
        [self requestAdvertisingImageAPI];
        
        
    }
    return self;
}
-(void)pushToAdViewController {
    [self dismiss];
    if (self.tapBlock) {
        self.tapBlock();
    }
}
-(void)show {
    
    //开启倒计时方法1：GCD
    [self startTimer];
    //开启倒计时方法2:计时器
    
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
-(void)dismiss {
    [_countTimer invalidate];
    _countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -Private Method
-(void)startTimer {
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}
-(void)countDown {
    _count--;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count <= 0) {
        
        [self dismiss];
    }
}
-(NSString *)getFilePathWithImageName:(NSString *)imageName {
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [paths firstObject];
        NSString *filePath = [cachePath stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}
-(BOOL)isFileExistsWithFilePath:(NSString *)filePath {
    BOOL isDirectory = FALSE;
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
}
/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}
-(void)requestAdvertisingImageAPI {
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistsWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
        
    }
}
-(void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filePath = [self getFilePathWithImageName:imageName];
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
             DLog(@"广告页保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
        }else {
            DLog(@"广告页保存失败");
        }
    });
}

#pragma mark--Setter and Getter
-(void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}
@end

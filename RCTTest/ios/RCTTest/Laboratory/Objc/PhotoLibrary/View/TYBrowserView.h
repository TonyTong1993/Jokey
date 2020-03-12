//
//  TYPhotoGroupView.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TYPhoto;
@protocol TYBrowserViewDelegate<NSObject>
-(void)photoBrowserViewDissmissActionResponder;
-(void)photoBrowserViewCheckActionResponder;
-(NSUInteger)selectedIndexInBrowserView;
@end

@protocol TYBrowserViewDataSource<NSObject>
@required
-(NSUInteger)numberOfPhotosInBrowserView;
-(TYPhoto *)browserView:(UIView *)browserView photoForRowAtIndex:(NSUInteger)index;
@end
@interface TYPhotoGroupItem : NSObject


@end

@interface TYBrowserView : UIView
@property (nonatomic,readonly) NSArray *groupItems;
@property (nonatomic,readonly) NSInteger currentPage;

@property (nonatomic,weak) id<TYBrowserViewDelegate> delegate;
@property (nonatomic,weak) id<TYBrowserViewDataSource> dataSource;

-(instancetype)init;
@end

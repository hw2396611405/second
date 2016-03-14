//
//  ScrollView.h
//  doctor
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewDelegate <NSObject>

- (void)tapImageView: (NSInteger)index;

@end

@interface ScrollView : UIView
@property (nonatomic,retain)UIScrollView *scroll;
@property (nonatomic,retain)UIPageControl *pageVC;
@property (nonatomic,retain) UIView *view;
@property (nonatomic,retain)NSTimer *timer;
@property (nonatomic,retain)NSArray  *imageDataArr;
@property (nonatomic,retain)id<ScrollViewDelegate>delegate;

@end

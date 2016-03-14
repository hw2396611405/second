//
//  ScrollView.m
//  doctor
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView ()<UIScrollViewDelegate>
{
       NSUInteger currentIndex;
}

@property (nonatomic,strong) UIImageView *currentView;
@property (nonatomic,strong) UIImageView *leftView;
@property (nonatomic,strong) UIImageView *rightView;

@end

@implementation ScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        currentIndex = 0;
        [self ViewShouldBeginScroll];
        self.scroll.delegate = self;
    }
    return self;

}

- (NSTimer *)timer {
    if (!_timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(ViewShouldBeginScroll) userInfo:nil repeats:YES];
    }

    return _timer;
}

- (UIScrollView *)scroll {
    if (!_scroll) {
        self.scroll = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scroll.pagingEnabled = YES;
        _scroll.bounces = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.delegate = self;
        [_scroll setContentOffset:CGPointMake(self.frame.size.width, 0)];
        _scroll.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
        [self addSubview:_scroll];

        }

    return _scroll;
}

- (UIPageControl *)pageVC {
    if (!_pageVC) {
        self.pageVC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        self.pageVC.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 30) ;
        _pageVC.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.4];
        _pageVC.numberOfPages = self.imageDataArr.count;
        [self addSubview:_pageVC];
    }
    return _pageVC;
}

- (UIImageView *)currentView {
    if (!_currentView) {
        self.currentView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _currentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tellDelegateShouldAction:)];
        [_currentView addGestureRecognizer:tap];
        [self.scroll addSubview:_currentView];
    }
    return _currentView;
}

- (UIImageView *)leftView {
    if (!_leftView) {
        self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.scroll addSubview:_leftView];
    }
    return _leftView;
}

- (UIImageView *)rightView {
    if (!_rightView) {
        self.rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
        [self.scroll addSubview:_rightView];
    }
    return _rightView;
}




//属性均为懒加载，这个方法必须触发
- (void)ViewShouldBeginScroll {
    [UIView animateWithDuration:0.4 animations:^{
        [self.scroll setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:NO];
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scroll];
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (0 == self.scroll.contentOffset.x) {
        currentIndex --;
    } else if (self.frame.size.width * 2 == self.scroll.contentOffset.x) {
        currentIndex ++;
    }
    NSInteger leftIndex,rightIndex;
    
    if (currentIndex == -1 ) {
        currentIndex = self.imageDataArr.count - 1;
    };
    
    if (currentIndex == self.imageDataArr.count) {
        currentIndex = 0;
    }
    
    rightIndex = currentIndex + 1;
    leftIndex = currentIndex - 1;
    if (rightIndex == self.imageDataArr.count) {
        rightIndex = 0;
    };
    if (leftIndex == -1) {
        leftIndex = self.imageDataArr.count - 1;
    };
    
    [self.leftView sd_setImageWithURL:[NSURL URLWithString:self.imageDataArr[leftIndex]]];
    [self.currentView sd_setImageWithURL:[NSURL URLWithString:self.imageDataArr[currentIndex]]];
    [self.rightView sd_setImageWithURL:[NSURL URLWithString:self.imageDataArr[rightIndex]]];
    self.pageVC.currentPage = currentIndex;
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

#pragma - mark - SelfDelegate -
- (void)tellDelegateShouldAction:(UITapGestureRecognizer *)tap {
    //获得此时下标
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapImageView:)]) {
        [self.delegate tapImageView:currentIndex];
    }
}





@end

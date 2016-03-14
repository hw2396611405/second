//
//  UserGuideController.m
//  UserGuideDemo
//
//  Created by laouhn lsh on 15/11/25.
//  Copyright (c) 2015年 laouhn lsh. All rights reserved.
//


#define KScreenWidth [[UIScreen mainScreen]bounds].size.width
#define KScreenHeight [[UIScreen mainScreen]bounds].size.height
#define KImageCount 3
#define KScrollerViewTag 101
#define KPageControlTag 102
#define KImageName @"information"
#import "UserGuideController.h"
#import "MainTabBarController.h"
@interface UserGuideController ()<UIScrollViewDelegate>
{
    
    UIScrollView *scrollView;
    UIScrollView *smallScrollView;
}

@end

@implementation UserGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScrollerView];
}

- (void)setUpScrollerView {
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*3, CGRectGetHeight(self.view.bounds));
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*i, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        [scrollView addSubview:imageView];
        scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, CGRectGetHeight(self.view.bounds)/4, CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2)];
    smallImageView.userInteractionEnabled = YES;
    smallImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:smallImageView];
    
    smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(smallImageView.bounds), CGRectGetHeight(smallImageView.bounds))];
    smallScrollView.scrollEnabled = NO;
    smallScrollView.delegate = self;
    smallScrollView.contentSize = CGSizeMake(CGRectGetWidth(smallImageView.bounds)*3, CGRectGetHeight(smallImageView.bounds));
    smallScrollView.pagingEnabled = YES;
    smallScrollView.bounces = NO;
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(smallImageView.bounds)*i, 0, CGRectGetWidth(smallImageView.bounds), CGRectGetHeight(smallImageView.bounds))];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        if (i == KImageCount - 1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleIntoMain:)];
            //打开交互
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
          //  [tap release];
        }
        [smallScrollView addSubview:imageView];
    }
    [smallImageView addSubview:smallScrollView];
    [self.view addSubview:scrollView];
    [self.view bringSubviewToFront:smallImageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView{
    if (aScrollView == scrollView) {
        CGPoint point = scrollView.contentOffset;
        point.y = point.y*4;
        smallScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x/2, scrollView.contentOffset.y);
    }
}
#pragma mark -handle action -

- (void)handleIntoMain:(UITapGestureRecognizer *)tap {
    //1.点击最后一张图片时 将内容存储到 NSUserDefaults中 2.进入程序主页面
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:KFirstMark];
    //立即同步存储 执行存储任务
    [defaults synchronize];
    
    //2.进入主页面
    MainTabBarController *mainVC = [[MainTabBarController alloc]init];
    //更改window的根视图控制器为主界面的视图控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
   // [mainVC release];
    
    
}

#pragma mark -UIScrollViewDeledate-

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded]&& !self.view.window) {
        self.view = nil;
    }
    
    
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

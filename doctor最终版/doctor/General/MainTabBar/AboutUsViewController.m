//
//  AboutUsViewController.m
//  doctor
//
//  Created by 陈春雷 on 16/1/23.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "AboutUsViewController.h"

#define SkyColor  [UIColor colorWithRed:84 /255.0 green:218/255.0 blue:255/255.0 alpha:1.0]

@interface AboutUsViewController ()

@property (nonatomic ,retain) UILabel *titleLabel;

@property (nonatomic ,copy) NSString *contentStr;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //84,218,255
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(animationLabel) object:nil];
    [thread start];
    self.contentStr = @"小医是一款医疗助理类的APP，此APP中有医学资讯(为你解读医学最前沿,在这里你可以了解和我们息息相关的医学最新资讯) ，医院大全(高德地图定位和导航,  为你打造最便捷的交通路线 ,方便你的就医）健康知识（为你推荐你喜欢的健康知识 属于专属的定制 和全方面的养生知识 ,养成良好的生活习惯,为健康宝航）,医路有我,做你身边最贴心的医生助理.";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(handlePop)];
    
}

- (void)handlePop {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)animationLabel {
    for (NSInteger i = 0; i < self.contentStr.length ; i++) {
        [self performSelectorOnMainThread:@selector(refreshUIWithContentStr:) withObject:[self.contentStr substringWithRange:NSMakeRange(0,i+1)] waitUntilDone:YES];
        [NSThread sleepForTimeInterval:0.3];
    }
}


- (void)refreshUIWithContentStr:(NSString *)contentStr {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height )];
    self.titleLabel.backgroundColor = SkyColor;
    self.titleLabel.text = contentStr;
    self.titleLabel.numberOfLines = 0;
    [self.view addSubview:_titleLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

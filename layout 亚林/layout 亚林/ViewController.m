//
//  ViewController.m
//  layout 亚林
//
//  Created by wanghui on 16/1/28.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
        make.top.left.equalTo(self.view).width.offset(100);
        make.bottom.and.right.equalTo(self.view).with.offset(-100);
    }];
    view.backgroundColor = [UIColor redColor];
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor yellowColor];
    [view addSubview:btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

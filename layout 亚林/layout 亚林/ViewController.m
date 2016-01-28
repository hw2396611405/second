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
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerX.equalTo(view);
       // make.height.and.width.mas_equalTo(@50);
        make.centerY.equalTo(self.view);
        make.left.equalTo(view).with.offset(5);
        make.height.mas_equalTo(@50);
       
//        make.width.mas_equalTo(@(width));
    }];
    
    UIButton *btn1 = [[UIButton alloc]init];
    btn1.backgroundColor = [UIColor blueColor];
    [view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.centerX.equalTo(view);
        make.left.equalTo(btn.mas_right).with.offset(5);
        
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(btn);
    }];
    UIButton *btn2 = [[UIButton alloc]init];
    btn2.backgroundColor = [UIColor greenColor];
    [view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(view);
        make.left.equalTo(btn1.mas_right).with.offset(5);
        make.right.equalTo(view).with.offset(-5);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(btn1);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

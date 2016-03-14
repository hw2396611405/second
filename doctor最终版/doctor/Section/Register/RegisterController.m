//
//  RegisterController.m
//  doctor
//
//  Created by 王辉 on 15/12/23.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "RegisterController.h"
#import "Register.h"

@interface RegisterController ()
@property (nonatomic, retain) Register *registerView;
@property (nonatomic, retain) NSArray *array;//定义一个数组，用来存放注册信息
@property (nonatomic, retain) UIAlertController *alert;//弹出信息框

@end

@implementation RegisterController
-(void)loadView {
    self.registerView = [[Register alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = _registerView;
    
    self.navigationItem.title = @"注册";



}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //添加btn
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(handleRight)];
    self.navigationItem.rightBarButtonItem  = right;

   
    
}


#pragma  注册登录
-(void)handleRight {
    __block RegisterController *registerVC = self;//使得局部变量在全局可用
#pragma 验证注册
    self.array = [self.registerView backTFArray];
    if ([self.array[0] isEqualToString:@""] || [self.array[1]isEqualToString:@""]) {
        self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名和密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
    }else if (NO == [self.array[1] isEqualToString:self.array [2]]) {
        self.alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
    }else {
        self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
    }
    [self presentViewController:self.alert animated:YES completion:^{
        //处理注册信息  定时器
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:registerVC selector:@selector(handleSuccess:) userInfo:nil repeats:YES];
        
    }];

}


- (void)handleSuccess:(NSTimer *)timer {
    [timer invalidate];
    [self.alert dismissViewControllerAnimated:YES completion:nil];
    if ([self.alert.message isEqualToString:@"注册成功"]) {
#pragma ---注册成功 WriteToFile---
        //制作字典
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        NSArray *arr = @[@"userName",@"password",@"",@"mailAddress",@"phoneNum"];
        //写入用户单例类
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        for (int i = 0; i < 5; i ++) {
            if (i == 2) {
                i ++;
            }
            [dic setValue:self.array[i] forKey:arr[i]];
        }
        [defaults setObject:dic forKey:self.array[0]];
        [self.navigationController popViewControllerAnimated:YES];
    
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

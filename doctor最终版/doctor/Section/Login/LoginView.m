//
//  LoginView.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "LoginView.h"



#define kLeftWidth  10
#define kheight  50

#define KYellowGreenColor colorWithRed:154/255.0 green:205/255.0 blue:50/255.0 alpha:1.0

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userLT = [[LTVIew alloc]initWithFrame:CGRectMake(kLeftWidth, 80, kScreenWidth - 20, kheight) leftLabel:@"用户名" placeholder:@"请输入用户名"];
        self.passwordsLT = [[LTVIew alloc] initWithFrame:CGRectMake(kLeftWidth, 140, kScreenWidth - 20, 50) leftLabel:@"密码" placeholder:@"请输入密码"];
        self.passwordsLT.rightTF.secureTextEntry = YES;
        [self addSubview:self.userLT];
        [self addSubview: self.passwordsLT];
        
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(80, 260, 70, 30);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor KYellowGreenColor];
        
        self.registerBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(180, 260, 70, 30);
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = [UIColor orangeColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 320, 260, 40)];
        label.text = @"快速登录, 无需密码";
        
        self.WbBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _WbBtn.frame = CGRectMake(80, 370, 48, 33);
       _WbBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xinlang"]];
        
        [self addSubview:_WbBtn];
        [self addSubview:label];
        [self addSubview:_registerBtn];
        [self addSubview:_loginBtn];
    }

    return self;
}



@end

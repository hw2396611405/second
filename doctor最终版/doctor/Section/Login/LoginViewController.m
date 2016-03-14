//
//  LoginViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//


#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "CollectHelper.h"

@interface LoginViewController ()
@property (nonatomic, retain)LoginView *loginView;
@property (nonatomic, retain)UIAlertController *alert;
@end

static BOOL isLogin = NO;

@implementation LoginViewController

- (void)loadView {
    self.loginView = [[LoginView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = self.loginView;
    self.view.backgroundColor = [UIColor whiteColor];
 
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor clearGreenColor];
    [self.loginView.loginBtn addTarget:self action:@selector(handleLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registerBtn addTarget:self action:@selector(handleRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.WbBtn addTarget:self action:@selector(handlewb) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel  target:self action:@selector(handleCancel)];
    self.navigationItem.title = @"登录";
    [FileManager sharedManager];
    
    MMDrawerBarButtonItem *leftDrawerBtn = [[MMDrawerBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-idcard2f"] style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftDrawerBtm:)];
    
    [self.navigationItem setLeftBarButtonItem:leftDrawerBtn animated:YES];
}

- (void)handleLeftDrawerBtm:(UIBarButtonItem *) btn {
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    MainTabBarController *main = [[MainTabBarController alloc] init];
    self.mm_drawerController.centerViewController =main;


}
-(void)handleCancel
{
  [self dismissViewControllerAnimated:YES completion:nil];

}
//第三方登录 微博登录
- (void)handlewb {
    if (isLogin) {
        self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"已登录,是否切换用户" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"切换" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     [self  handleshare];
                                 }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [self.alert addAction:action];
        [self.alert addAction:action1];
        [self presentViewController:self.alert animated:YES completion:nil];
        return;
    }else {
        [self handleshare];
        isLogin = YES;
    }
    
   }

//第三方验证判断
- (void)handleshare {
      __block LoginViewController *loginVC = self;
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
        [FileManager sharedManager].userOfLogin= user.nickname;
          //   NSLog(@"%@",[FileManager sharedManager].userOfLogin);
        self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:self.alert animated:YES completion:^{
                 [NSTimer scheduledTimerWithTimeInterval:2.0 target:loginVC selector:@selector(handleBack:) userInfo:nil repeats:YES];
             }];

         }
         
         else
         {
          //   NSLog(@"%@",error);
         }
     }];

}

//验证登录
- (void)handleLogin:(UIButton *) btn {
   if (isLogin) {
        self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"已登录,是否切换用户" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"切换" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            [self  handleChange];
           }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [self.alert addAction:action];
        [self.alert addAction:action1];
        [self presentViewController:self.alert animated:YES completion:nil];
        return;
    }
    else
    {
        [self handleChange];
  }
}

#pragma mark  对登录事件进行处理

//对用户进行验证
- (void)handleChange {
    __block LoginViewController *loginVC = self;
    if ([FileManager useLoginWithUserName:self.loginView.userLT.rightTF.text passerword:self.loginView.passwordsLT.rightTF.text]) {
        self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
    }else {
        self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    [self presentViewController:self.alert animated:YES completion:^{
        //添加定时器
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:loginVC selector:@selector(handleBack:) userInfo:nil repeats:YES];
    }];
}

-(void)handleBack:(NSTimer *)timer {
    [self.alert dismissViewControllerAnimated:YES completion:nil];
    if ([self.alert.message isEqualToString:@"登录成功"]) {
        //等有用户登录时,bool值为1;
        isLogin = YES;
        [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        MainTabBarController *main = [[MainTabBarController alloc] init];
        self.mm_drawerController.centerViewController =main;
        //创建数据库
        [[CollectHelper sharedInstance] createNewDataBase];
    }
    //移除定时器
    [timer invalidate];


}

//处理注册事件
-(void)handleRegister:(UIButton *)btn {
    RegisterController *registerVC = [[RegisterController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

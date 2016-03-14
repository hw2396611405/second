//
//  BaseViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/25.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.barTintColor = [UIColor clearGreenColor];
    [self setupLeftMenuBtn];
   

    // Do any additional setup after loading the view.
}

- (void)setupLeftMenuBtn {
   // MMDrawerBarButtonItem *leftDrawerBtn = [[MMDrawerBarButtonItem alloc] initWithImage:[single Singletion].image style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftDrawerBtm:)];
 
  MMDrawerBarButtonItem *leftDrawerBtn = [[MMDrawerBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-idcard2f"] style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftDrawerBtm:)];
    //为navigationItem 添加LeftButtonItem
    [self.navigationItem setLeftBarButtonItem:leftDrawerBtn animated:YES];
    
}

//在下面实现抽屉按钮的动作
- (void)handleLeftDrawerBtm: (id)sender {
    //开关左抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
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

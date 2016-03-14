//
//  MainTabBarController.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "MainTabBarController.h"
#import "hosipitalViewController.h"
#import "KnowledgeViewController.h"
#import "InformationViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"

#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"//第三方封装的头文件



@interface MainTabBarController ()
@property (nonatomic, retain)MMDrawerController *drawerController;
@property (nonatomic, retain)UINavigationController *informationNavi;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
   

    //模板设计
   // 资讯
    InformationViewController *informationVC = [[InformationViewController alloc]init];

   self.informationNavi = [[UINavigationController alloc]initWithRootViewController:informationVC];
    
    informationVC.tabBarItem.title = @"资讯";
    
    
    informationVC.navigationItem.title = @"资讯";
    informationVC.tabBarItem.image = [UIImage imageNamed:@"iconfont-yiliao"];
    
    //健康知识
    KnowledgeViewController *knowledgeVC = [[KnowledgeViewController alloc]init];
    UINavigationController *knowledgeNavi = [[ UINavigationController alloc]initWithRootViewController:knowledgeVC];
    knowledgeVC.tabBarItem.title = @"健康";
    knowledgeVC.tabBarItem.image = [UIImage imageNamed:@"iconfont-favorite"];
   knowledgeVC.navigationItem.title = @"健康知识";
    
    //医院大全
    hospitalViewController*hosipitalVC = [[hospitalViewController alloc]init];
    UINavigationController *hosipitalNavi = [[UINavigationController alloc]initWithRootViewController:hosipitalVC];

    hosipitalVC.tabBarItem.title = @"医院";
    hosipitalVC.navigationItem.title = @"医院大全";
    hosipitalVC.tabBarItem.image = [UIImage imageNamed:@"iconfont-chengshifuwu"];
  
   
self.viewControllers = @[knowledgeNavi,_informationNavi,hosipitalNavi];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }

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

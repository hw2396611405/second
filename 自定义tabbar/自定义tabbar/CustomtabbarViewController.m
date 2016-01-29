//
//  CustomtabbarViewController.m
//  自定义tabbar
//
//  Created by wanghui on 16/1/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "CustomtabbarViewController.h"

@interface CustomtabbarViewController ()
@property (nonatomic,strong)NSArray *viewControllers;//s数组,用来存放存进来的VC

@end

@implementation CustomtabbarViewController

-(instancetype)initWithViewControllers:(NSArray *)controllers {
    self = [super init];
    if (self) {
        self.viewControllers = [NSArray arrayWithArray:controllers];
        
        //布局下方子视图
        [self setSubView];
       
    }
    return self;

}

//布局下方子视图
- (void)setSubView {


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

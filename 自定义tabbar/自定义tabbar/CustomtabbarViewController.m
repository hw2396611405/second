//
//  CustomtabbarViewController.m
//  自定义tabbar
//
//  Created by wanghui on 16/1/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "CustomtabbarViewController.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kHeight 60  // 下方item视图的高度
#define kHeightOfBottomView kHeight - 12  // 显示的下方视图的高度

@interface CustomtabbarViewController ()
@property (nonatomic,strong)NSArray *viewControllers;//s数组,用来存放存进来的VC
@property (nonatomic,strong)NSMutableArray *btnArr;//button存放的数组
@property (nonatomic,strong)NSMutableArray *labelArr;//label的数组
@end

@implementation CustomtabbarViewController

-(instancetype)initWithViewControllers:(NSArray *)controllers {
    self = [super init];
    if (self) {
        self.viewControllers = [NSArray arrayWithArray:controllers];
        self.btnArr = [NSMutableArray arrayWithCapacity:1];
        self.labelArr = [[NSMutableArray alloc]init];
        
        //布局下方子视图
        [self setSubView];
       
    }
    return self;

}

//布局下方子视图
- (void)setSubView {
    //创建底层透明的View
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kHeight, kScreenWidth, kHeight)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    //创建底层不透明的小一点的View
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kHeightOfBottomView, kScreenWidth, kHeightOfBottomView)];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    float width = kScreenWidth /self.viewControllers.count;
    
    //创建每个item的button和label
    for (int i = 0; i < self.viewControllers.count; i++) {
        //创建button
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((width - 25) / 2 + width * i, 17, 25, 25);
        btn.tintColor = [UIColor blackColor];
        [view addSubview:btn];
        [self.btnArr addObject:btn];
        // btn的点击事件
        [btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 创建label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5 + width * i, 42, width - 10, kHeightOfBottomView - 30)];
        label.text = @"test";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        [self.labelArr addObject:label];
    }
    
    
    

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

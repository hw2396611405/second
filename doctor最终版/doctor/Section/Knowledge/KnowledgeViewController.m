//
//  KnowledgeViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "FifthViewController.h"
#import "ScrollView.h"
#import "knowledgeViewCell.h"
#import "doctor.h"

#define kScrollHeight  self.view.frame.size.height
#define kHeadStrollViewHeight 44

@interface KnowledgeViewController ()<UIScrollViewDelegate>
@property (nonatomic ,retain) UIScrollView *headScrollView;  //  顶部滚动视图
@property (nonatomic ,retain) NSArray *headArray;
@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) NSMutableArray *imageArr;
@property (nonatomic,assign)NSInteger x;
@property (nonatomic, strong) FirstViewController *firstVC;
@property (nonatomic,strong)SecondViewController *SecondVC;
@property (nonatomic,strong)ThirdViewController *thirdVC;
@property (nonatomic, strong)ForthViewController *ForthVC;
@property (nonatomic,strong)FifthViewController *FifthVC;
@end

@implementation KnowledgeViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
     [self setUpsubview];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpsubview {
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    

    
    self.headArray = @[@"推荐",@"专题",@"真相",@"营养",@"母婴"];
    //headScrollView
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth,40)];
    self.headScrollView.backgroundColor = [UIColor clearGreenColor];
    self.headScrollView.contentSize = CGSizeMake(480, 0);
    self.headScrollView.bounces = NO;
    self.headScrollView.pagingEnabled = NO;
    self.headScrollView.showsHorizontalScrollIndicator = NO;
    self.headScrollView.delegate = self;
    self.headScrollView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.headScrollView];
    
    
    for (int i = 0; i < self.headArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0 + 75 * i, 0, 75, kHeadStrollViewHeight- 4);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20 + 75 * i, kHeadStrollViewHeight - 3, 40, 2)];
        view.layer.cornerRadius = 1;
        view.layer.borderColor = [UIColor clearBlueColor].CGColor;
        view.backgroundColor = [UIColor clearBlueColor];
        view.tag = 200 + i;
        view.hidden = YES;
        [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = 100 + i;
        if (i == 0) {
            button.titleLabel.font = [UIFont systemFontOfSize:18];
        }
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:button];
        [self.headScrollView addSubview:view];
    }
    
        self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, [UIScreen mainScreen].bounds.size.height - kHeadStrollViewHeight)];
        
        self.mainScrollView.contentSize = CGSizeMake(kScreenWidth * 5, kScreenHeight) ;
        self.mainScrollView.delegate = self;
        [self.view addSubview:_mainScrollView];
        self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO;
    
        //设置第一个View为红色
        UIView *view1 = (UIView *)[self.view viewWithTag:200];
        view1.hidden = NO;
        //设置默认的开始第一个按钮文字颜色为红色
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:100];
        [btn1 setTitleColor:[UIColor clearBlueColor] forState:UIControlStateNormal];
        

        
        
        
        
        //添加为当前视图
        
        self.firstVC = [[FirstViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.firstVC.view setFrame:CGRectMake(0, 0, kScreenWidth, kScrollHeight - 30)];
        self.firstVC.tableView.showsVerticalScrollIndicator = NO;
        [self.mainScrollView addSubview:self.firstVC.view];
        
        
        self.SecondVC = [[SecondViewController alloc]initWithStyle:UITableViewStylePlain];
    
        [self.SecondVC.view setFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight )];
        self.SecondVC.tableView.showsHorizontalScrollIndicator = NO;
        [self.mainScrollView addSubview:self.SecondVC.view];
        
        
        self.thirdVC = [[ThirdViewController alloc]initWithStyle:UITableViewStylePlain];
        [self.thirdVC.view setFrame:CGRectMake(kScreenWidth * 2,0, kScreenWidth, kScrollHeight - 30)];
        [self.mainScrollView addSubview:self.thirdVC.view];
        
        self.ForthVC = [[ForthViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.ForthVC.view setFrame:CGRectMake(kScreenWidth *3, 0, kScreenWidth, kScrollHeight - 30)];
        [self.mainScrollView addSubview:self.ForthVC.view];
        
        
        self.FifthVC = [[FifthViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.FifthVC.view setFrame:CGRectMake(kScreenWidth *4, 0, kScreenWidth , kScrollHeight - 30)];
          [self.mainScrollView addSubview:_FifthVC.view];
        
        //建立和视图的父子关系
        [self addChildViewController:_firstVC];
        [self addChildViewController:_SecondVC];
        [self addChildViewController:_thirdVC];
        [self addChildViewController:_ForthVC];
        [self addChildViewController:_FifthVC];
        
        
    }
    
#pragma mark

- (void)handleBtn {


}





//点击不同的按钮

- (void)didClickHeadButtonAction:(UIButton *)button {
    
    switch (button.tag) {
        case 100:
            [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            [self setRedView:200];
            break;
        case 101:
            [self.mainScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
            [self setRedView:201];
            [self.SecondVC.tableView reloadData];
            break;
      case 102:
            [self.mainScrollView setContentOffset:CGPointMake(2 * kScreenWidth, 0) animated:YES];
           [self setRedView:202];
           [self.thirdVC.tableView reloadData];
           break;
       case 103:
            [self.mainScrollView setContentOffset:CGPointMake(3 * kScreenWidth, 0) animated:YES];
            [self setRedView:203];
            [self.ForthVC.tableView reloadData];
            break;
        case 104:
            [self.mainScrollView setContentOffset:CGPointMake(4 * kScreenWidth, 0) animated:YES];
            [self setRedView:204];
            [self.FifthVC.tableView reloadData];
            break;

        default:
            break;
    }
}




//设置headScrollView的偏移量
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger t = self.mainScrollView.contentOffset.x / kScreenWidth + 200;
    [self setRedView:t];
    if (t - 200 == 0) {
        [self.headScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        if (self.headScrollView.contentOffset.x != 100) {
            [self.headScrollView setContentOffset:CGPointMake((480 - kScreenWidth) / 5 * (t - 200), 0) animated:YES];
            
        }
    }
    switch (t - 200) {
        case 0:
            //            [self.firstVC.tableView reloadData];
            break;
            
        case 1:
            [self.SecondVC.tableView reloadData];
            break;
        case 2:
            [self.thirdVC.tableView reloadData];
            break;
        case 3:
            [self.ForthVC.tableView reloadData];
            break;
            
        case 4:
            [self.FifthVC.tableView reloadData];
            break;

            
        default:
            break;
    }
    
}

//设置按钮下的红条的显示 && 设置按钮上文字的颜色
- (void)setRedView:(NSInteger)t {
    for (NSInteger i = 200; i < 206 ; i++) {
        UIView *view = (UIView *)[self.view viewWithTag:t];
        UIButton *btn = (UIButton *)[self.view viewWithTag:t - 100];
        if (t == i) {
            view.hidden = NO;
            [btn setTitleColor:[UIColor clearBlueColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
        }else{
            
            UIView *view1 = (UIView *)[self.view viewWithTag:i];
            view1.hidden = YES;
            UIButton *btn1 = (UIButton *)[self.view viewWithTag:i - 100];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.titleLabel.font = [UIFont systemFontOfSize:15];
            
            
        }
    }
}





@end

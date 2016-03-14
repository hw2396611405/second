//
//  InformationViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//


#define URLPHOTOS @"http://c.3g.163.com/photo/api/set/0038/3542.json            "
#import "InformationViewController.h"

#import "InfomationViewCell.h"
#import "DetailViewController.h"
#import "AFHTTPSessionManager.h"
#import "MainModel.h"
#import "DetailInfomationController.h"



#define healthURl  @"http://dxy.com/app/i/columns/article/list?u=&page_index=&mc=fffffffff13eed16ffffffffe4059c53&ac=d5424fa6-adff-4b0a-8917-4264daf4a348&bv=2015&vc=5.0&vs=4.4.2&items_per_page=5&channel_id=10"

@interface InformationViewController ()<UIGestureRecognizerDelegate,ScrollViewDelegate>

{
    int page;
}

@property (nonatomic, retain) UIScrollView *scrollView;//声明一个UISCrollView

@property (nonatomic, retain) UIPageControl *pageControl; //声明一个UIPageControl

@property (nonatomic ,retain) NSTimer *timer;

@property (nonatomic ,retain) UIImageView *imageView;

@property (nonatomic , strong) NSMutableArray *dataSouce;  //数据源，存储数据

@property (nonatomic ,retain) NSMutableArray *detailID;

@property (nonatomic ,strong) NSMutableArray *dataArr;

@property (nonatomic , assign) NSInteger page1;

@property (nonatomic ,strong) UIView *headView;

@end

@implementation InformationViewController



- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray arrayWithCapacity:1];
        
    }
    return _dataArr;
}


- (NSMutableArray *)dataSouce {
    if (!_dataSouce) {
       self.dataSouce = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSouce;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBar.barTintColor = [UIColor clearGreenColor];
    MMDrawerBarButtonItem *leftDrawerBtn = [[MMDrawerBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-idcard2f"] style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftDrawerBtm:)];
    //为navigationItem 添加LeftButtonItem
    [self.navigationItem setLeftBarButtonItem:leftDrawerBtn animated:YES];    self.page1 =  0;
    
    //请求数据
    [self requestData];
    //下拉刷新
    __block typeof (self)weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page1 = 0;
        [weakSelf requestData];
    }];
      [self.tableView headerBeginRefreshing];
    //上拉刷新
    [self.tableView addFooterWithCallback:^{

        [weakSelf requestData];
    }];
    //开始刷新
    
    
    //设置标题
    self.navigationItem.title = @"健康资讯";
   
       //设置轮播图
    [self request:healthURl ];
    //单元格cell属性
    [self.tableView registerClass:[InfomationViewCell class] forCellReuseIdentifier:@"cell"];
   
}

//- (void)pushNext {
//    self.views = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 0, 75, 70)];
//    //view.backgroundColor = [UIColor blueColor];
//    [_headView addSubview:_views];
//    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    firstBtn.backgroundColor = [UIColor redColor];
//    firstBtn.frame = CGRectMake(_views.frame.size.width - 70, 0, 70, 35);
//    [firstBtn setTitle:@"视频" forState:UIControlStateNormal];
//    [firstBtn addTarget:self action:@selector(nextAvdio) forControlEvents:UIControlEventTouchUpInside];
//    [_views addSubview:firstBtn];
//    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    secondBtn.frame = CGRectMake(_views.frame.size.width - 70, CGRectGetMaxY(firstBtn.frame), 70, 35);
//    secondBtn.backgroundColor = [UIColor blueColor];
//    [secondBtn setTitle:@"二维码" forState:UIControlStateNormal];
//    [secondBtn addTarget:self action:@selector(ToErWeiMa) forControlEvents:UIControlEventTouchUpInside];
//    [_views addSubview:secondBtn];
//
//}



//轮播图解析网址
-(void)request: (NSString*)urlStr {
      NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue]  completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        if (error)
        {
         //   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = dic[@"data"][@"items"];
        //    NSLog(@"arr  %ld",arr.count);
            for (NSDictionary *dict in arr)
            {
              [self.dataArr addObject:dict[@"cover"]];
               
                //轮播图
            ScrollView *view = [[ScrollView alloc]initWithFrame:CGRectMake(0, 30 , kScreenWidth, 200)];
                self.tableView.tableHeaderView = view;
                    //接口为属性
                    view.imageDataArr = _dataArr;
                    view.delegate = self;
                    [view.timer fire];
                
                
                    }
        }
         
    }];
  

}




//轮播图检测方法
- (void)tapImageView:(NSInteger)index {
  //  NSLog(@"点击了数据源中的第%ld张图片,这个图片的网址是%@",index,self.dataArr[index]);
}


- (void)pageTurn:(UIPageControl *)pageControl {
    NSInteger pages = self.pageControl.currentPage;
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) *pages;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
    
}

//列表请求数据
- (void)requestData {
    //GET请求
    NSString *URL = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1414389941036/%d-20.html",self.page1 += 20];
    __block typeof (self)weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
   
        //处理数据
        [weakSelf handleData:responseObject];

     
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      //  NSLog(@"error:%@",error);
    }];
    [self.tableView reloadData];
    }




- (void)handleData:(id)responsObject {
    NSDictionary *dic = responsObject;
    NSMutableArray *array = dic[@"T1414389941036"];
   // NSLog(@"array:%@",array);
    NSMutableArray *currentArray = [NSMutableArray arrayWithCapacity:1];

    for (NSDictionary *dict in array) {
        MainModel *model = [[MainModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
//        NSLog(@"dic:%@",dictionary);
          [currentArray addObject:model];
              [self.detailID addObject:model.docid];//将cell的id存到数组里
       
       
    
    }
    
    //添加id
    if (20 == self.page1) {
  
        if (self.dataSouce.count > 0) {
            [self.dataSouce removeAllObjects];
        }
        self.dataSouce = [NSMutableArray arrayWithArray:currentArray];
    
        [self.tableView headerEndRefreshing];
    } else {
        [self.dataSouce addObjectsFromArray:currentArray];
       [self.tableView footerEndRefreshing];
    }
 
    [self.tableView reloadData];
        //结束刷新
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *indentifier = @"indentifier";
    InfomationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    
    // Configure the cell...
    //将每一条数据对应的显示在模拟器上
    MainModel *model = self.dataSouce[indexPath.row];
   
    
    cell.model = model;
    
    return cell;
}

//点击cell时的触发方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainModel *model = self.dataSouce[indexPath.row];
    DetailInfomationController *detail = [[DetailInfomationController alloc]init];
    detail.detailID = model.docid;
    
    [self.navigationController pushViewController:detail animated:YES];
    self.navigationController.hidesBarsOnSwipe = NO;
}

//在下面实现抽屉按钮的动作
- (void)handleLeftDrawerBtm: (id)sender {
    //开关左抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}





@end

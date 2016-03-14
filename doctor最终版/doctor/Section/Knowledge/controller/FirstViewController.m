//
//  FirstViewController.m
//  doctor
//
//  Created by lanouhn on 16/1/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "FirstViewController.h"
#import "knowledgeViewCell.h"
#import "ScrollView.h"



#define kScrollHeight  self.view.frame.size.height
#define kHeadStrollViewHeight 30
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface FirstViewController ()<ScrollViewDelegate>
@property (nonatomic,  strong)NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *refreshURL;
@property (nonatomic, retain)NSMutableArray *allDics;//存放所有的数据
@property (nonatomic , assign) NSInteger page1;
@property (nonatomic, retain) NSMutableArray *imageArr;
@property (nonatomic,assign)NSInteger x;

@end

@implementation FirstViewController
- (NSMutableArray *)dataSource {
 if (!_dataSource) {
     self.dataSource = [NSMutableArray arrayWithCapacity:1];
 }
    return _dataSource;
}

-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        self.imageArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imageArr;

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
     [self.tableView registerClass:[knowledgeViewCell class] forCellReuseIdentifier:@"cell"];
    //解析数据
    [self request:imageURLStr WithType:1];
  
    [self request:URLStr1 WithType:2];
    self.tableView.rowHeight = 110;
    //下拉刷新
    __block typeof (self)weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page1 = 0;
       // [weakSelf request:imageURLStr WithType:1];
        [weakSelf request:URLStr1 WithType:2];
    }];
    [self.tableView headerBeginRefreshing];
    //上拉刷新
    [self.tableView addFooterWithCallback:^{
        
        [weakSelf request:URLStr1 WithType:2];
    }];
    //开始刷新

    }

-(void)setupRefresh {


}
- (void)upRefresh {
    [self request:imageURLStr WithType:1];
    [self request:URLStr1 WithType:2];
    [self.tableView reloadData];
}

- (void)handleFooterRefresh {
    [self request:self.refreshURL WithType:1];
    [self.tableView reloadData];
    if (self.allDics.count > 1) {
        [self.allDics removeLastObject];
    }


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

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   knowledgeViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    KnowledgeModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}


//实现数据解析的方法
-(void)request: (NSString*)urlStr WithType:(NSInteger)flag
{
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue]  completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        if (error)
        {
          //  NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = dic[@"data"][@"items"];
            for (NSDictionary *dict in arr)
            {
                KnowledgeModel *model= [[KnowledgeModel alloc]initWithdic:dict];
                
                if (flag ==2)
                {
                    [self.dataSource  addObject:model];
                    [self.allDics addObject:model];
                    
                    [self.tableView reloadData];
                }
                if (flag ==1)
                {
                    
                    [self.imageArr addObject:dict[@"cover"]];
                    //轮播图
                    ScrollView *view = [[ScrollView alloc]initWithFrame:CGRectMake(0,100 , kScreenWidth, 200)];
                    self.tableView.tableHeaderView = view;
                    //接口为属性
                    view.imageDataArr = _imageArr;
                    view.delegate = self;
                    [view.timer fire];
                  
                }
            }
        }
    }];
    //添加id
    if (20 == self.page1) {
        
        if (self.dataSource.count > 0) {
            [self.dataSource removeAllObjects];
        }
        self.dataSource = [NSMutableArray arrayWithArray:_allDics];
        
        [self.tableView headerEndRefreshing];
    } else {
        [self.dataSource addObjectsFromArray:_allDics];

    }
    
    [self.tableView reloadData];
    //结束刷新
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    knowledgeDetailViewController *knowVC = [[knowledgeDetailViewController alloc] init];
    knowVC.model  = self.dataSource[indexPath.row];

   [self.navigationController pushViewController:knowVC animated:YES];
   
    
    
}

- (void)tapImageView:(NSInteger)index {
  //  NSLog(@"点击了数据源中的第%ld张图片,这个图片的网址是%@",index,self.imageArr[index]);
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

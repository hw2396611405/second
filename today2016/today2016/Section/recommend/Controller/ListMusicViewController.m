//
//  ListMusicViewController.m
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "ListMusicViewController.h"
#import "ListMusicViewCell.h"
#import "ListMusicViewController.h"
#import "listHeaderMOdel.h"
#import "listMusicModel.h"
#import "FirstListHeader.h"
#import "PlayViewController.h"
#import "secondHeaderView.h"

@interface ListMusicViewController ()
@property (nonatomic,assign)NSInteger page;//存储当前页数
@property (nonatomic,strong)NSMutableArray *headrArr;//存放区头的数组
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ListMusicViewController
-(NSMutableArray *)headrArr {
    if (!_headrArr) {
        self.headrArr = [[NSMutableArray  alloc]initWithCapacity:1];
    }
    return _headrArr;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataSource;

}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    
    
    //解析数据
    [self loadDataFromServer];
    
    //添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page =1;
        [self loadDataFromServer];
    }];
    
    //添加上拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadDataFromServer];
    }];
}

- (void)loadDataFromServer
{
    //拼接URL
    NSString *listUrl = [MusicListUrl stringByReplacingOccurrencesOfString:@"%ld" withString:[NSString  stringWithFormat:@"%ld",self.albumId]] ;
  
    NSURL *URL = [NSURL URLWithString:[listUrl  stringByReplacingOccurrencesOfString:@"page" withString:[NSString stringWithFormat:@"%ld",self.page]]];
    //NSLog(@"%@",URL);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    
    //创建任务
  NSURLSessionDataTask *dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      NSDictionary *Dic =dic[@"album"];
      listHeaderMOdel *headerModel = [[listHeaderMOdel alloc]initWithDic:Dic];
     
      //注册view
      NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FirstListHeader" owner:self options:nil];
      FirstListHeader *firstListHeaderView = [nib objectAtIndex:0];
      CGRect rectFrame = firstListHeaderView.frame;
      rectFrame.size.height = 160;
      rectFrame.size.width = kScreenWidth;
      firstListHeaderView.frame = rectFrame;
      firstListHeaderView.model = headerModel;
      
      self.tableView.tableHeaderView = firstListHeaderView;
      NSArray *listArr = dic[@"tracks"][@"list"];
      if (self.page == 1) {
          [self.tableView.mj_header endRefreshing];
          [self.dataSource removeAllObjects];
      }else {
          [self.tableView.mj_footer endRefreshing];
      }
      
     
      for (NSDictionary *dict in listArr) {
        
          listMusicModel *listmodel = [[listMusicModel alloc]initWithDic:dict];
          [self.dataSource addObject:listmodel];
      }
      //将数据刷新和界面加载交给主线程
      [self performSelectorOnMainThread:@selector(refreshData) withObject:nil waitUntilDone:YES];
      
    }];

    [dataTask resume];

}

- (void)refreshData {
    [self.tableView reloadData];
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
    ListMusicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listMusicCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayViewController *playVC = [storyboard instantiateViewControllerWithIdentifier:@"PlayViewController"];
    playVC.dataArray = self.dataSource;
    playVC.index = indexPath.row;
    [self.navigationController pushViewController:playVC animated:YES];

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

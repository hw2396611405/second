//
//  RankViewController.m
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "RankViewController.h"
#import "RankViewCell.h"
#import "RankModel.h"
#import "listViewController.h"

@interface RankViewController ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation RankViewController
//懒加载
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    //网络请求
    [self loadDataFromServer];
    
    //添加头部下拉刷新
   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       self.page = 1;
       [self loadDataFromServer];
   }];
    
    //添加底部上拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page++;
        [self loadDataFromServer];
    }];
    
}

#pragma mark ---custom Medthod
-(void)loadDataFromServer {
    NSURL *url = [NSURL URLWithString:[kRankURL stringByReplacingOccurrencesOfString:@"pageId=1" withString:[NSString stringWithFormat: @"pageId=%ld",self.page]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    //创建网络请求数据任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dic[@"list"];
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
            //清除旧数据
            [self.dataArray removeAllObjects];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        for (NSDictionary *dic in arr) {
            RankModel  *model = [[RankModel alloc]initWithDic:dic];
            [self.dataArray addObject:model];
        }
        //对于界面的刷新以及用户交互的处理全部交给主线程处理
        [self performSelectorOnMainThread:@selector(reload2) withObject:nil waitUntilDone:YES];
    }];

    [dataTask resume];
}

-(void)reload2 {
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
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankCell" forIndexPath:indexPath];
    RankModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
    if (indexPath.row < 3) {
        cell.numberLabel.textColor = @[[UIColor redColor],[UIColor orangeColor],[UIColor greenColor]][indexPath.row];
    }else {
        cell.numberLabel.textColor = [UIColor grayColor];
    }
    
    return cell;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //找到目标视图控制器
    listViewController *listVC = segue.destinationViewController;
    //找到当前cell上的数据模型
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    RankModel *model = self.dataArray[indexPath.row];
  listVC.listID = [model.ID  integerValue];
    listVC.text = model.title;
    
   }

@end

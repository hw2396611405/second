//
//  listViewController.m
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "listViewController.h"
#import "ListViewCell.h"
#import "PlayViewController.h"
#import "listModel.h"

@interface listViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger page;
@end

@implementation listViewController
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //xib 使用注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    
    //注册view
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FirstListHeader" owner:self options:nil];
    UIView *firstListHeaderView = [nib objectAtIndex:0];
    
    
    //网络请求
    [self loadDataFromServer];
    //添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadDataFromServer];
    }];
    //添加上拉加载
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadDataFromServer];
    }];
    
    
}

-(void)loadDataFromServer {
    NSString *listURL = [NSString stringWithFormat:kListUrl,self.listID];
    //拼接URL
    NSURL *url = [NSURL URLWithString:[listURL stringByReplacingOccurrencesOfString:@"page" withString:[NSString stringWithFormat:@"%ld",self.page]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    //创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dic[@"tracks"][@"list"];
        //判断page
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.dataArray removeAllObjects];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        for (NSDictionary *dic in arr) {
            listModel *model = [[listModel alloc]initWithDic:dic];
            [self.dataArray addObject:model];
        }
        //将数据刷新和界面加载交给主线程
        [self performSelectorOnMainThread:@selector(reload2) withObject:nil waitUntilDone:YES];
        
    } ];
    [dataTask resume];
}
-(void)reload2
{
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
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
  
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayViewController *playVC = [storyboard instantiateViewControllerWithIdentifier:@"PlayViewController"];
    playVC.dataArray = self.dataArray;
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
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//   
//    
//    
//}


@end

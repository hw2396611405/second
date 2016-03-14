//
//  AroundViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/25.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "AroundViewController.h"
#import  "AroundViewCell.h"
#import "AFHTTPSessionManager.h"
#import "hospitalDetailViewController.h"
#import "Around.h"


@interface AroundViewController ()
@property (nonatomic, retain)NSMutableArray *dataSource;

@end

@implementation AroundViewController


//懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"周边医院";
   
    //注册cell
    [self.tableView registerClass:[AroundViewCell class] forCellReuseIdentifier:@"cell"];
    //cell高度  
    self.tableView.rowHeight = 200;
    
    
   NSString *Url = @"http://apis.baidu.com/tngou/hospital/location";

    NSString *httpArg = [NSString stringWithFormat:@"x=%f&y=%f&page=1&rows=10",self.longitude,self.latitude];
   
    [self request: Url withHttpArg: httpArg];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//数据解析
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
 
    [request addValue: @"5026df6bf6f56cbb3dcb51d6e52b6bb0" forHTTPHeaderField: @"apikey"];
    __block AroundViewController *vc = self;
    
 [NSURLConnection sendAsynchronousRequest: request
   queue: [NSOperationQueue mainQueue]
completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
            if (error) {
   // NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
           
      

        [vc handleData: data];
                               }
                           }];
}


-(void)handleData: (id)data {
    //json 解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       NSArray *arr = dic[@"tngou"];
 
    for (NSDictionary *dic in arr) {
        Around *around = [[Around alloc]initWithDic:dic];
        [self.dataSource addObject:around];
    }

    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AroundViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Around *around = self.dataSource[indexPath.row];

    cell.around = around;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    hospitalDetailViewController *hospitalDetail = [[hospitalDetailViewController alloc]init];
    [self.navigationController pushViewController:hospitalDetail animated:YES];
    Around *around = self.dataSource[indexPath.row];
    
    hospitalDetail.name = around.name;
    hospitalDetail.gobus = around.gobus;

    
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

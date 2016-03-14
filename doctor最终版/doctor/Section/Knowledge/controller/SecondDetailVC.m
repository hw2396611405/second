//
//  SecondDetailVC.m
//  doctor
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "SecondDetailVC.h"
#import "SecondViewCell.h"

@interface SecondDetailVC ()
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UIImageView *photoView;
@property (nonatomic, strong)UILabel *desc;
@end

@implementation SecondDetailVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SecondViewCell class] forCellReuseIdentifier:@"SecondDetail"];
    
    self.navigationItem.title = self.SecondTitle;
   
    
    
    
    //解析数据

    [self request:[NSString stringWithFormat:@"http://dxy.com/app/i/columns/article/list?order=publishTime&page_index=&items_per_page=50&special_id=%@",self.ID]WithTape:1];
    
    [self request:[NSString stringWithFormat:@"http://dxy.com/app/i/columns/special/single?id=%@",self.ID]WithTape:2];
    

    self.tableView.rowHeight = 100;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//解析数据
-(void)request: (NSString *) urlStr WithTape:(NSInteger)flag
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
          //  NSLog(@"Httperror: %@%ld", connectionError.localizedDescription, connectionError.code);
        }else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = dic[@"data"][@"items"];
            for (NSDictionary *dict in arr) {
                KnowledgeModel *model = [[KnowledgeModel alloc]initWithdic:dict];
            if (flag == 1) {
                   [self.dataSource addObject:model];
                    [self.tableView reloadData];
            }
                if (flag == 2) {
                    self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
                    self.tableView.tableHeaderView = _photoView;
                    
                    self.desc = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kScreenWidth - 10, 80)];
                    _desc.numberOfLines = 0;
                    //设置字体渲染颜色
                    _desc.textColor = [UIColor whiteColor];
                    [_photoView addSubview:_desc];
                    
                    _desc.text = model.desc;
                    
                    [_photoView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
                    
                    
                    
            }
        }
    }
 }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondDetail" forIndexPath:indexPath];
    KnowledgeModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    knowledgeDetailViewController *knowVC = [[knowledgeDetailViewController alloc] init];
    knowVC.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:knowVC animated:YES];
    



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

//
//  ForthViewController.m
//  doctor
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "ForthViewController.h"
#import "SecondViewCell.h"


@interface ForthViewController ()
@property (nonatomic,retain)NSMutableArray *dataSource;
@end

@implementation ForthViewController
- (NSMutableArray*)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray  arrayWithCapacity: 1];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView  registerClass:[SecondViewCell class] forCellReuseIdentifier:@"second"];
    self.tableView.rowHeight = 90;
    [self request:forthURL];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//实现解析方法
- (void)request: (NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
         //   NSLog(@"Httperror: %@%ld", connectionError.localizedDescription, connectionError.code);
        }else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = dic[@"data"][@"items"];
            for (NSDictionary *dict in arr)
            {
                KnowledgeModel *model= [[KnowledgeModel alloc]initWithdic:dict];
                [self.dataSource  addObject:model];
                
                [self.tableView reloadData];
                
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
    SecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
    KnowledgeModel *model = self.dataSource[indexPath.row];
    cell.model = model;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    knowledgeDetailViewController *knowVC = [[knowledgeDetailViewController alloc] init];
    KnowledgeModel *model =self.dataSource[indexPath.row];
    knowVC.model = model;
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

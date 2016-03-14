//
//  CollectListController.m
//  doctor
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "CollectListController.h"
#import "knowledgeViewCell.h"
#import "CollectHelper.h"
@interface CollectListController ()

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation CollectListController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [[NSMutableArray alloc]initWithCapacity:1];
    }
   return _dataSource;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    [self.tableView registerClass:[knowledgeViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 120;
    
    [self readWithData];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-iconfontunie61e" ] style:UIBarButtonItemStylePlain target:self action:@selector(handleLeft)];
    self.navigationItem.leftBarButtonItem = btnItem;
    
   
}


- (void)handleLeft {
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    MainTabBarController *main = [[MainTabBarController alloc] init];
    self.mm_drawerController.centerViewController =main;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readWithData {
    NSArray *array = [[CollectHelper sharedInstance] getCollectAllInfo];
    
    [self.dataSource addObjectsFromArray:array];
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
   knowledgeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    KnowledgeModel *model = self.dataSource[indexPath.row];
    cell.model =model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    knowledgeDetailViewController *knowVC = [[knowledgeDetailViewController alloc] init];
    knowVC.model  = self.dataSource[indexPath.row];
    
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

//
//  CollectViewController.m
//  today2016
//
//  Created by wanghui on 16/3/10.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "CollectViewController.h"
#import "AppDelegate.h"

@interface CollectViewController ()
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSManagedObjectContext *manageObjectContext;

@end

@implementation CollectViewController

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArr;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.manageObjectContext = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    //查询数据
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"ListModel"];
    NSArray *requestArray = [[self.manageObjectContext executeRequest:request error:nil] mutableCopy];
    [self.dataArr addObjectsFromArray:requestArray];
    
    
    
    
    
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

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
    

    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

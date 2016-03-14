//
//  SecondViewController.m
//  doctor
//
//  Created by lanouhn on 16/1/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "SecondViewController.h"
#import "knowledgeVC.h"
#import "SecondDetailVC.h"




@interface SecondViewController ()
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation SecondViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }

    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //注册cell
    [self.tableView registerClass:[knowledgeVC class] forCellReuseIdentifier:@"knowVC"];
    
    [self request:URLStr2];
    self.tableView.rowHeight = 110;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现数据解析的方法
-(void)request: (NSString*)urlStr
{
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
    knowledgeVC *cell = [tableView dequeueReusableCellWithIdentifier:@"knowVC" forIndexPath:indexPath];
    KnowledgeModel *model = self.dataSource[indexPath.row];
    cell.model = model;

    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SecondDetailVC *secondVC = [[SecondDetailVC alloc]init];

   KnowledgeModel *model = self.dataSource[indexPath.row];
    secondVC.ID = [NSString stringWithFormat:@"%ld",model.ID];
    secondVC.SecondTitle = model.name;
 //   NSLog(@"----%@",secondVC.SecondTitle);
    
    
    
    [self.navigationController pushViewController:secondVC animated:YES];
    


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

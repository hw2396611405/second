//
//  FifthViewController.m
//  doctor
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "FifthViewController.h"
#import "SecondViewCell.h"

@interface FifthViewController ()
@property (nonatomic, retain)NSMutableArray *dataSource;
@end

@implementation FifthViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView  registerClass:[SecondViewCell class] forCellReuseIdentifier:@"five"];
    self.tableView.rowHeight = 90;
 
    [self request:fifthURL];

    
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
    SecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"five" forIndexPath:indexPath];
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




@end

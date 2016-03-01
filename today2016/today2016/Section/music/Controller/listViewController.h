//
//  listViewController.h
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listViewController : UITableViewController
@property (nonatomic,assign)NSInteger listID;
@property (nonatomic,retain)NSString *text;
@property (nonatomic,strong)NSString *musicTitle;

@end

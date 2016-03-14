//
//  InfomationViewCell.h
//  doctor
//
//  Created by 陈春雷 on 15/12/24.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface InfomationViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *label;  //显示数据简介

@property (nonatomic ,strong) UILabel *title;  //标题

@property (nonatomic ,strong) UIImageView *photoView;  //显示图片

@property (nonatomic ,retain) UILabel *count;  //跟帖数

@property (nonatomic ,retain) MainModel *model;  //

@end

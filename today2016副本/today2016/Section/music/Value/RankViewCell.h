//
//  RankViewCell.h
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"

@interface RankViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *tracklabel;
@property (weak, nonatomic) IBOutlet UILabel *introlLabel;
@property (nonatomic,strong)RankModel  *model;

@end

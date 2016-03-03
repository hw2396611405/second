//
//  ListMusicViewCell.h
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "listMusicModel.h"

@interface ListMusicViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playtimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *conmentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatdAtLabel;

@property (nonatomic,strong)listMusicModel *model;


@end

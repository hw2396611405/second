//
//  FirstListHeader.h
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "listHeaderMOdel.h"

@interface FirstListHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView1;
@property (weak, nonatomic) IBOutlet UIImageView *photoView2;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel3;

@property (nonatomic,strong)listHeaderMOdel *model;

@end

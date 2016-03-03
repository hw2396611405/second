//
//  ListViewCell.m
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//给cell控件赋值
-(void)setModel:(listModel *)model {
    self.titleLabel.text = model.title;
    self.autorLabel.text = model.nickname;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall]];
    NSInteger totalTime =[model.duration floatValue];
    self.platTimeLabel.text = [NSString stringWithFormat:@"%ld:%ld",totalTime/60,totalTime%60];

}

@end

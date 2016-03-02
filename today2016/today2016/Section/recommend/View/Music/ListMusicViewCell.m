//
//  ListMusicViewCell.m
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "ListMusicViewCell.h"

@implementation ListMusicViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(listMusicModel *)model {
    self.titleLabel.text = model.title;
    NSInteger play = [model.playtimes floatValue];
    self.playtimesLabel.text =[NSString stringWithFormat:@"%ld.%ld万",play/10000,play%10000/1000];
    NSInteger dur = [model.duration integerValue];
    self.durationLabel.text =[NSString stringWithFormat:@"%02ld:%02ld",dur/60,dur%60];
    NSInteger con = [model.comments integerValue];
    self.conmentsLabel.text = [NSString stringWithFormat:@"%ld",con];
    //时间戳的使用  把时间戳转换为时间的方法
    NSInteger time = [model.createdAt integerValue]/1000;
    
    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *nowTime = [NSDate date];
    NSTimeInterval inter = [nowTime timeIntervalSinceDate:confromTime];
    

}





@end

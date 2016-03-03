//
//  RankViewCell.m
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "RankViewCell.h"



@implementation RankViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(RankModel *)model {
    self.titlelabel.text = model.title;
    self.tracklabel.text = [model.tracks stringValue];
    self.introlLabel.text = model.intro;
    [self.photoView sd_setImageWithURL:[NSURL  URLWithString: model.coverSmall]];

}

@end

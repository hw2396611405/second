//
//  VideoViewCell.m
//  today2016
//
//  Created by wanghui on 16/3/2.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "VideoViewCell.h"

@implementation VideoViewCell
- (void)setModel:(JZTJModel *)model {
    _model = model;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.Description;
}

@end

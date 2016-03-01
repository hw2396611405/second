//
//  XBTJViewCell.m
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "XBTJViewCell.h"

@implementation XBTJViewCell

//通过setter方法赋值
-(void)setModel:(commonModel *)model {
    //_model = model;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    self.titleLabel.text = model.trackTitle;
    self.headerLine.text = model.title;
}



- (void)awakeFromNib {
    // Initialization code
}

@end

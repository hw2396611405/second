//
//  JPTDViewCell.m
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "JPTDViewCell.h"

@implementation JPTDViewCell

//重写set方法,给cell控件赋值
-(void)setModel:(JPTDModel *)model {
    _model = model;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.coverPath]];
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subtitle;
    self.footnoteLabel.text = model.footnote;

}

- (void)awakeFromNib {
    // Initialization code
}

@end

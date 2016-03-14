//
//  SecondViewCell.m
//  doctor
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "SecondViewCell.h"

@interface SecondViewCell ()
@property (nonatomic, retain)UIImageView *photoView;
@property (nonatomic, retain)UILabel *titleLabel;
@end

@implementation SecondViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10,240, 60)];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(265, 20, 80, 60)];
        _photoView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_photoView];
        
        
     
        
        
        
        
        
    }
    return  self;
}

- (void)setModel:(KnowledgeModel *)model {
    if (!_model) {
        
        _model = model ;
    }
    self.titleLabel.text = model.title;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.cover_small] ];

}




@end

//
//  knowledgeVC.m
//  doctor
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "knowledgeVC.h"

@interface knowledgeVC ()
@property (nonatomic, retain)UIImageView *photoView;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *descriptionLabel;

@end

@implementation knowledgeVC

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,275, 30)];

      
        
        [self.contentView addSubview:_titleLabel];
        
        self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 32, 80, 60)];
        _photoView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_photoView];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 32, kScreenWidth- 100, 70)];
        _descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLabel];
        
        
        
        
        
    }
    return  self;
}

- (void)setModel:(KnowledgeModel *)model {
    if (!_model) {

        _model = model ;
    }
    self.titleLabel.text = model.name;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.cover_small] ];
    self.descriptionLabel.text = model.desc;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

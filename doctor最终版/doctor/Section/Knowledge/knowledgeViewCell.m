//
//  knowledgeViewCell.m
//  doctor
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "knowledgeViewCell.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight 30


@interface knowledgeViewCell ()

@property (nonatomic, retain)UIImageView *photoView;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *descriptionLabel;
@end

@implementation knowledgeViewCell

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
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10,240, 100)];
        _titleLabel.numberOfLines = 0;
 
     
        [self.contentView addSubview:_titleLabel];
        self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 120, 90)];
        self.photoView.layer.cornerRadius = 10;
        self.photoView.layer.masksToBounds = YES;
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

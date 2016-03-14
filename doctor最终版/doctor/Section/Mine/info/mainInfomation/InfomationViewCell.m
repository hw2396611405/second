//
//  InfomationViewCell.m
//  doctor
//
//  Created by 陈春雷 on 15/12/24.
//  Copyright © 2015年 王辉. All rights reserved.
//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "InfomationViewCell.h"
#import "UIImageView+WebCache.h"


@implementation InfomationViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    //title
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame) + kScreenWidth * 0.35 + 10, CGRectGetMinY(self.photoView.frame)+10, kScreenWidth * 0.6, 30.f)];
   // self.title.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.title];
    //label
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.title.frame)+50, kScreenWidth * 0.55, self.textLabel.bounds.size.height - 45.f)];
    //self.label.backgroundColor = [UIColor grayColor];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.numberOfLines = 0;
    [self.contentView addSubview:self.label];
    
     //photoView
    self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth * 0.3, 80)];
    _photoView.layer.cornerRadius = 20;
    _photoView.layer.masksToBounds = YES;
    _photoView.image = [UIImage imageNamed:@"13-medicine-box-120"];
    [self.contentView addSubview:_photoView];
  
    
    
    //count
    
    self.count = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.label.frame)- 80, CGRectGetMaxY(self.label.frame), 80, 25)];
    //_count.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_count];
    
}

//重写model的setter方法
- (void)setModel:(MainModel *)model {
    if (_model != model) {

        _model = model ;
    }
    //为控件赋值
    self.label.text = model.digest;  //简介
    self.title.text = model.title;  //标题
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"13-medicine-box-120"]];
    self.count.text =[NSString stringWithFormat:@"跟帖:%ld",model.replyCount];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

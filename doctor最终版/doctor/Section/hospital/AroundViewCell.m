//
//  AroundViewCell.m
//  doctor
//
//  Created by 王辉 on 15/12/25.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "AroundViewCell.h"
#import "UIImageView+Addtion.h"
#import "UIImageView+WebCache.h"

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWeight   [UIScreen mainScreen].bounds.size.width
#define kWeight 90
#define kLabelWeight 260
#define kLabelHeight  30
#define kTopHeight 20
#define kHeight 30
@interface AroundViewCell ()
@property (nonatomic, retain)UILabel *nameLabel;//医院名字
@property (nonatomic,retain)UIImageView *posterView;//医院图片
@property (nonatomic, retain)UILabel *addressLabel;//医院地址
@property (nonatomic, retain)UILabel *levelLabel;//医院实行
@property (nonatomic, retain) UILabel *telLabel;//医院电话
@end

@implementation AroundViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.posterView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20,80, 120)];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight, kLabelWeight, kLabelHeight)];
       self.levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight + kHeight, kLabelWeight, kLabelHeight)];
        
        self.telLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight + kHeight*2, kLabelWeight, kLabelHeight)];
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight + kHeight*3, kLabelWeight, kLabelHeight)];
        
       
        [self addSubview:_addressLabel];
        [self addSubview:_telLabel];
        [self addSubview:_levelLabel];
        [self addSubview:_nameLabel];
        [self addSubview:_posterView];
        
    
    }
    return  self;
}

- (void)setAround:(Around *)around {
    
    if (_around != around) {
        
        _around = around ;
    }
     
    //图片网址的拼接
    NSString *imageUrl = [NSString stringWithFormat:@"http://tnfs.tngou.net/image"];
    imageUrl = [imageUrl stringByAppendingString:around.img];
    
   
  
    //使用第三方的图片缓存功能
//    [self.posterView sd_setImageWithURL:[NSURL URLWithString:around.img] placeholderImage:[UIImage imageNamed:@""]];
    [self.posterView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.nameLabel.text = around.name;
    self.levelLabel.text = around.level;
    self.telLabel.text = around.tel;
    self.addressLabel.text = around.address;
    

}



@end

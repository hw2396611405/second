//
//  XBTJViewCell.h
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTJViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLine;
@property (nonatomic,strong) commonModel *model;

@end

//
//  VideoViewCell.h
//  today2016
//
//  Created by wanghui on 16/3/2.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTJModel.h"

@interface VideoViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) JZTJModel *model;

@end

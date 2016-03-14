//
//  VideoLBTViewCell.h
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBTModel.h"

@interface VideoLBTViewCell : UICollectionViewCell
@property (nonatomic,strong)NSMutableArray *VideoLBTDataSource;
@property (nonatomic,strong)LBTModel *model;


@end

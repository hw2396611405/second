//
//  LBTViewCell.h
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLBT.h"

@interface LBTViewCell : UICollectionViewCell
@property (nonatomic,strong)NSMutableArray *imageDataSource;
@property (nonatomic,strong)MusicLBT *model;

@end

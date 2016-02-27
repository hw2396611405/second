//
//  RankModel.h
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RankModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,weak)NSNumber *tracks;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *coverSmall;
@property (nonatomic,retain)NSNumber *ID;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end


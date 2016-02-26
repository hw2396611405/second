//
//  RankModel.h
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject
@property (nonatomic,weak)NSString *title;
@property (nonatomic,weak)NSString *tracks;
@property (nonatomic,retain)NSString *intro;
@property (nonatomic,retain)NSString *coverSmall;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end


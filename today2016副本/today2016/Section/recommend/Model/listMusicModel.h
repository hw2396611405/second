//
//  listMusicModel.h
//  today2016
//
//  Created by wanghui on 16/3/2.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listMusicModel : NSObject
@property (nonatomic,strong)NSString *playUrl32;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *albumTitle;
@property (nonatomic,strong)NSNumber *duration;//总时长
@property (nonatomic,strong)NSNumber *createdAt;//创建时间
@property (nonatomic,strong)NSString *coverSmall;
@property (nonatomic,strong)NSNumber *playtimes;//播放次数
@property (nonatomic,strong)NSNumber *comments;//评论数


- (instancetype)initWithDic:(NSDictionary *)dic;

@end

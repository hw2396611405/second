//
//  listHeaderMOdel.h
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listHeaderMOdel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *coverSmall;
@property (nonatomic,strong)NSString *coverMiddle;
@property (nonatomic,strong)NSString  *nickname;
@property (nonatomic,strong)NSNumber *createdAt;
@property (nonatomic,strong)NSNumber *updatedAt;
@property (nonatomic,strong)NSString *tags;
@property (nonatomic,strong)NSNumber *playTimes;
@property (nonatomic,strong)NSString *intro;
@property (nonatomic,strong)NSString *avatarPath;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end

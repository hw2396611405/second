//
//  listModel.h
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listModel : NSObject
@property(nonatomic, copy)NSString *coverSmall;
@property(nonatomic, copy)NSString *nickname;
@property(nonatomic, copy)NSString *playUrl64;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)NSNumber * duration;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end

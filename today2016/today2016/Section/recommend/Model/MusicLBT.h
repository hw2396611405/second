//
//  MusicLBT.h
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicLBT : NSObject
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSNumber *albumId;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end

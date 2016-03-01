//
//  commonModel.h
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commonModel : NSObject
@property (nonatomic,strong)NSString *coverLarge;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *trackTitle;
@property (nonatomic,strong)NSNumber *playsCounts;
@property (nonatomic,strong)NSNumber *trackId;
@property (nonatomic,strong)NSNumber *tracks;
@property (nonatomic,strong)NSNumber *albumId;
-(instancetype)initWithDic:(NSDictionary *)dic;

@end

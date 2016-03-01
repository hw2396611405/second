//
//  JPTDModel.h
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPTDModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subtitle;
@property (nonatomic,strong)NSString *footnote;
@property (nonatomic,strong)NSString *coverPath;
@property (nonatomic,strong)NSNumber *albumId;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

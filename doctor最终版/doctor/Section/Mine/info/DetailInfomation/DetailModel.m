//
//  DetailModel.m
//  doctor
//
//  Created by 陈春雷 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+ (instancetype)detailImageWithDic:(NSDictionary *)dic {
    DetailModel *model = [[self alloc]init];
    model.time = dic[@"time"];
    model.title = dic[@"title"];
    model.message = dic[@"message"];
    model.img = dic[@"img"];

    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

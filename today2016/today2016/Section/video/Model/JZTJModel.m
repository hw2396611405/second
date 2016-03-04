//
//  JZTJModel.m
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "JZTJModel.h"

@implementation JZTJModel
-(instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }else if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }


}

@end

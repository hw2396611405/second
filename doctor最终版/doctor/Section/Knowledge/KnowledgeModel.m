//
//  KnowledgeModel.m
//  doctor
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "KnowledgeModel.h"

@implementation KnowledgeModel
- (instancetype)initWithdic:(NSDictionary *)dic {

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        //给自身字典赋值
        self.dic = [NSDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key  isEqualToString: @"description"]) {
     
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
  
    }

}
@end

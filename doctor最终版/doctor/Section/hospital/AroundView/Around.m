//
//  Around.m
//  doctor
//
//  Created by 王辉 on 15/12/25.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "Around.h"

@implementation Around
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


@end

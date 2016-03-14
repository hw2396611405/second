//
//  Login.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "Login.h"

@implementation Login
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self  setValuesForKeysWithDictionary:dic];
    }
    return self;
}

//做安全处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {


}

@end

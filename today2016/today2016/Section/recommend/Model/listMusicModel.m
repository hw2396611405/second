//
//  listMusicModel.m
//  today2016
//
//  Created by wanghui on 16/3/2.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "listMusicModel.h"

@implementation listMusicModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end

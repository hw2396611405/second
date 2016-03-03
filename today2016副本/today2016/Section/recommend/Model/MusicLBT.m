//
//  MusicLBT.m
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "MusicLBT.h"

@implementation MusicLBT
-(instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
@end

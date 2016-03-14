//
//  ListModel.m
//  today2016
//
//  Created by wanghui on 16/3/8.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

// Insert code here to add functionality to your managed object subclass


-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.coverSmall = keyedValues[@"coverSmall"];


}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key {


}

- (id)valueForKey:(NSString *)key {

    return key;
}





@end

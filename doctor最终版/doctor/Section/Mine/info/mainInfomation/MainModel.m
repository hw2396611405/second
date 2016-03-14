//
//  Model.m
//  doctor
//
//  Created by 陈春雷 on 15/12/24.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "MainModel.h"


@implementation MainModel
- (instancetype)initWithdic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;
}


+ (instancetype)detailWithDict:(NSDictionary *)dict {
    MainModel *model = [[self alloc]init];
    model.title = dict[@"title"];
    model.body = dict[@"body"];
    model.ref = dict[@"ref"];
    //model.pixel = dict[@"pixel"];
    model.src = dict[@"src"];
    model.docid = dict[@"docid"];
   // model.img = dict[@"img"];
    model.ptime =dict[@"ptime"];
    
    return model;
}




- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

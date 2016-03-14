//
//  JZTJModel.h
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTJModel : NSObject
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *Description;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

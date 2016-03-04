//
//  LBTModel.h
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBTModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSNumber *ID;

- (instancetype)initWithDic:(NSDictionary *)dic;




@end

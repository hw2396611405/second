//
//  KnowledgeModel.h
//  doctor
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KnowledgeModel : NSObject
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, copy)NSString *cover_small;
@property (nonatomic, assign)NSInteger ID;
@property (nonatomic, copy)NSString *keywords;
@property (nonatomic, copy)NSString *cover;
@property (nonatomic, copy)NSString *message;
@property (nonatomic,copy)NSString *title;
@property (nonatomic, copy)NSString *name;
@property(nonatomic,copy)NSString *desc;

- (instancetype)initWithdic: (NSDictionary *)dic;
// 创建一个字典属性，存储字典
@property (nonatomic,retain)NSDictionary *dic;
@end
//
//  CollectHelper.h
//  YueXiang
//
//  Created by 张永治 on 15/9/2.
//  Copyright (c) 2015年 NingNing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KnowledgeModel.h"
@interface CollectHelper : NSObject

+(instancetype)sharedInstance;

//查询所有数据
-(NSMutableArray *)getCollectAllInfo;

//查询一条记录
-(BOOL)selectCollectObject:(KnowledgeModel *)model;

//往数据库中添加一条记录
-(BOOL)insertCollectObject:(KnowledgeModel *)model;

//删除数据库中的一条记录
-(BOOL)deleteCollectOject:(KnowledgeModel *)model;

/** 创建一个新数据库 */
- (BOOL)createNewDataBase;

//清除缓存
-(void)clearAll;

@end

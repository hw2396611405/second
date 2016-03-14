//
//  CollectHelper.m
//  YueXiang
//
//  Created by 张永治 on 15/9/2.
//  Copyright (c) 2015年 NingNing. All rights reserved.
//

#import "CollectHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
//#define DOCUMENTSPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//#define DETALPATH  [DOCUMENTSPATH stringByAppendingPathComponent:@"Collect.sqlite"]
static CollectHelper *helper = nil;

@interface CollectHelper()
{
    NSString *getDocPath;
}
@end






@implementation CollectHelper


/** 创建一个新数据库 */
- (BOOL)createNewDataBase {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
   // NSLog(@"------%@",[FileManager whichUserLogin]);
    getDocPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.qlist",[FileManager whichUserLogin]]];
    FMDatabase *db = [FMDatabase databaseWithPath:getDocPath];
    //2.打开数据库
    if ([db open]) {
        //3.创建表格(数据库中整形数据用Integer, NSData用blob)
        [db executeUpdate:@"create table if not exists WangHui(kno_ID integer primary key autoincrement,kno_count integer,kno_cover_small text, kno_keywords text,kno_message text, kno_cover text,kno_title text, kno_name text)"];
        [db close];
    }
 
    
    
    return YES;
}


+(instancetype)sharedInstance
{
    if (!helper) {
        
        helper = [[CollectHelper alloc] init];
    }
    
    return helper;
}


//查询所有数据
-(NSMutableArray *)getCollectAllInfo
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:getDocPath];
    [dataBase open];
    
    FMResultSet *result = [dataBase executeQuery:@"select * from WangHui"];
    
    while (result.next) {
        KnowledgeModel *model = [[KnowledgeModel alloc] init];

        
        model.count = [result intForColumn:@"kno_count"];
        model.cover_small = [result stringForColumn:@"kno_cover_small"];
        model.ID = [result intForColumn:@"kno_ID"];
        model.keywords = [result stringForColumn:@"kno_keywords"];
        model.message = [result stringForColumn:@"kno_message"];
        model.cover = [result stringForColumn:@"kno_cover"];
        model.title = [result stringForColumn:@"kno_title"];
        model.name = [result stringForColumn:@"kno_name"];
        
        [array addObject:model];
        
    }
    
    [dataBase close];
    
    return array;
    
    
}

//查询一条记录
-(BOOL)selectCollectObject:(KnowledgeModel *)model
{
    BOOL flag = NO;
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:getDocPath];
    BOOL isOpen =[dataBase open];
    if (isOpen) {
      //  NSLog(@"打开成功");
    }
    else
    {
      //  NSLog(@"打开失败");
    }

   // NSLog(@"id:%ld",model.ID);
    NSString *result = [dataBase stringForQuery:@"select kno_ID from WangHui where kno_ID = ?;",[NSNumber numberWithInteger:model.ID]];
    
  //  NSLog(@"result:%@",result);
    
    if (result) {
        flag = YES;
    }
    
//    FMResultSet *result = [dataBase executeQuery:@"select col_contentid from Collect where col_contentid=?;",model.contentid];
//    
//    while (result.next) {
//        
//        id content = [[result resultDictionary] objectForKey:@"col_contentid"];
//        
//        if (content) {
//            flag = YES;
//        }
//    }
    
    [dataBase close];
    
    return flag;
}

//往数据库中添加一条记录
-(BOOL)insertCollectObject:(KnowledgeModel *)model
{
    BOOL flag = NO;
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:getDocPath];
    [dataBase open];

    /*
     create table if not exists Collect(kno_ID integer primary key autoincrement,kno_count integer,kno_cover_small text, kno_keywords text,kno_message text, kno_cover text,kno_title text, kno_name text)*/
    flag = [dataBase executeUpdate:@"insert into WangHui values(?,?,?,?,?,?,?,?);",[NSNumber numberWithInteger:model.ID],[NSNumber numberWithInteger:model.count],model.cover_small,model.keywords,model.message,model.cover,model.title,model.name];
    [dataBase close];
    
    return flag;
}

//删除数据库中的一条记录
-(BOOL)deleteCollectOject:(KnowledgeModel *)model
{
    BOOL flag = NO;
    FMDatabase *dataBase = [FMDatabase databaseWithPath:getDocPath];
    [dataBase open];
    
    flag = [dataBase executeUpdate:@"delete from WangHui where kno_ID=?",[NSNumber numberWithInteger:model.ID]];
    [dataBase close];
    
    return flag;

}

-(void)clearAll {
    [[NSFileManager defaultManager]removeItemAtPath:getDocPath error:nil];

}

@end

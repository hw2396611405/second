//
//  DetailModel.h
//  doctor
//
//  Created by 陈春雷 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic ,retain) NSString *title;  //标题

@property (nonatomic ,retain) NSString *message;  //内容

@property (nonatomic ,retain) NSArray *img;  //图片

@property (nonatomic ,retain) NSString *time;  //时间

@property (nonatomic ,retain) NSString *pixel;

@property (nonatomic ,retain) NSString *ref;

@property (nonatomic ,retain) NSString *src;


- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)detailImageWithDic:(NSDictionary *)dic;

@end

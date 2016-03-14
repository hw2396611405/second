//
//  Login.h
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString *mailAddress;
@property (nonatomic,copy)NSString *phoneNum;

//初始化一个方法 用来取值
- (instancetype)initWithDic:(NSDictionary *)dic;
@end

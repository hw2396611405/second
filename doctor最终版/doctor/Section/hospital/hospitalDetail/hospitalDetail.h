//
//  hospitalDetail.h
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hospitalDetail : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *tel;
@property (nonatomic, copy)NSString *nature;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *gobus;
@property (nonatomic, copy)NSString *message;
@property (nonatomic, copy)NSString *mtype;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *zipcode;

- (instancetype)initWithDic: (NSDictionary *)dic;


@end

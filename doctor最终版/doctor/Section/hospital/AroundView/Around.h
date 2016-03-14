//
//  Around.h
//  doctor
//
//  Created by 王辉 on 15/12/25.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Around : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *tel;
@property (nonatomic,copy)NSString *nature;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *level;
@property (nonatomic, copy)NSString *gobus;

- (id)initWithDic: (NSDictionary *)dic;
@end

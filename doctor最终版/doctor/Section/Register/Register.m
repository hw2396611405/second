//
//  Register.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "Register.h"
#import "LTVIew.h"

@implementation Register
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *titlesArr = @[@"用户名",@"密码",@"确认密码",@"邮箱",@"联系方式"];
        NSArray *placeholdersArr = @[@"请输入用户名",@"请输入密码",@"再次输入密码",@"请输入邮箱",@"请输入联系方式"];
        CGFloat y =  80;
        for (int i = 0; i < 5; i ++) {
            LTVIew *view = [[LTVIew alloc] initWithFrame:CGRectMake(20, y, 300, 60) leftLabel:titlesArr[i] placeholder:placeholdersArr[i]];
            if (i == 1 || i == 2) {
                view.rightTF.secureTextEntry = YES;
            }
            view.tag = 200 + i;
            [self addSubview:view];
       
            y += 70;
        }
    }


    return self;
}

- (NSArray *)backTFArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 5; i ++) {
        [array addObject:((LTVIew *)[self viewWithTag:200 + i]).rightTF.text];
    }
    return [NSArray arrayWithArray:array];

}

@end

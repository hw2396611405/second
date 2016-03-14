//
//  single.m
//  doctor
//
//  Created by lanouhn on 16/1/7.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "single.h"

@implementation single
static  single *singletion = nil;
+ (single *)Singletion {
    //多线程下安全问题  加锁
    @synchronized (self) {
        if (!singletion ) {
            singletion = [[single alloc] init];
        }
        return singletion;
    }
}

@end

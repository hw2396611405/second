//
//  FileManager.h
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
@property (nonatomic, copy)NSString *userOfLogin;
//单例方法  单例对象在使用前一定要初始化
+(FileManager *)sharedManager;

///***图片缓存的机制***/
////Caches路径
//+ (NSString *)cachesPath;
////Download路径
//+ (NSString *) downLoadImagePath;
////图片的路径
//+ (NSString *)imageFilePathWithName: (NSString *)imageName;
////清除缓存
//- (void)clearCaches;

//用户登录
+(BOOL)useLoginWithUserName:(NSString *)userName passerword:(NSString *)passerwoed;
+(BOOL)userHadLogin;//判断用户是否已经登录
+(NSString *)whichUserLogin;//哪个用户登录了
//退出登录
+ (void)exitLogin;


@end

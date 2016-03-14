//
//  FileManager.m
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "FileManager.h"
#import "Login.h"

static  FileManager *manager = nil;

@interface FileManager ()
@property (nonatomic, assign)BOOL isHaveLogin;


@end
@implementation FileManager


- (void)setUserOfLogin:(NSString *)userOfLogin {
    _userOfLogin = userOfLogin;
   // NSLog(@"+-+-+-***%@",userOfLogin);
}

//单例方法
+(FileManager *)sharedManager {
    @synchronized(self)
    {
        if (!manager)
        {
            manager = [[FileManager alloc] init];
        }
    }
    return  manager;
    
}
///***图片缓存的机制***/
////Caches路径
//- (NSString *)cachesPath {
//    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
//    
//    
//}
////Download路径
//- (NSString *) downLoadImagePath {
//    
//    NSString *downloadPath = [[self cachesPath]stringByAppendingPathComponent:@"download"];
//    //判断文件是否存在
//    BOOL isExist = [[NSFileManager defaultManager]fileExistsAtPath:downloadPath];
//    NSLog(@"%d",isExist);
//    //如果不存在 则创建
//    if (!isExist) {
//        //文件管理类的单例对象
//        BOOL isCteat =  [[NSFileManager defaultManager] createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
//        NSLog(@"%@",isCteat ? @"创建成功":@"创建失败");
//    }
//    return downloadPath;
//    
//}
////图片的路径
//- (NSString *)imageFilePathWithName: (NSString *)imageName {
//    //给本地图片一个图片名
//    NSString *localImageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
//    //去寻找本地图片
//    return  [[self downLoadImagePath]stringByAppendingPathComponent:localImageName];
//}
//


//判断是否注册过
+(BOOL)useLoginWithUserName:(NSString *)userName passerword:(NSString *)passerword {
    manager.isHaveLogin = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    Login *user = [[Login alloc]initWithDic:[defaults valueForKey:userName]];
    if ([user.userName isEqualToString:userName] &&  [user.password isEqualToString:passerword]) {
        manager.isHaveLogin = YES;
        manager.userOfLogin = userName;
        return YES;
    }
    return NO;
}

//用户是否已经登录
+(BOOL)userHadLogin {
     return manager.isHaveLogin;
}

//判断哪个用户登录
+(NSString *)whichUserLogin
{
    manager.isHaveLogin = YES;
    return [FileManager sharedManager].userOfLogin;

}
//退出登录
+ (void)exitLogin {
    manager.isHaveLogin = NO;
    manager.userOfLogin = nil;
}


@end

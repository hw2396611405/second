//
//  AppDelegate.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台 (对应QQ和QQ空间)SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//用户反馈
#import "UMFeedback.h"

//网络监测
#import "AFNetworking.h"
#import "SVProgressHUD.h"

//天气预报
#import "UMessage.h"

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

//引导页
#import "UserGuideController.h"

#import "MainTabBarController.h"

#import "LeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
   self.window.backgroundColor = [UIColor whiteColor];
    
    //启动页时间设置
    [NSThread sleepForTimeInterval:0.1];
    
    [self.window makeKeyAndVisible];
    
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    //引导页
    //NSUserDefaults 数据持久化的一种方式：主要存储用户的偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:KFirstMark]) {
        //用户引导
        UserGuideController *vc = [[UserGuideController alloc]init];
        self.window.rootViewController = vc;
   
        
    } else {
        //程序主页
        
        self.window.rootViewController = mainVC;
    }
    
    //用户反馈
    [UMFeedback setAppkey:@"569307fae0f55a278d001e4a"];
    
    //网络监测
    //菊花效果
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setRingThickness:0];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [SVProgressHUD showSuccessWithStatus:@"没有网络"];
               // NSLog(@"无网络");
                 }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
               // NSLog(@"WIFI");
                [SVProgressHUD showSuccessWithStatus:@"WIFI已连接"];
            }
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [SVProgressHUD showSuccessWithStatus:@"3G/4G网络"];
               // NSLog(@"无线");
            }
                break;
                case AFNetworkReachabilityStatusUnknown:
              //  NSLog(@"未知网络");
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
    
    
   
    
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    UINavigationController *leftNavi = [[UINavigationController alloc]initWithRootViewController:leftVC];
    //初始化抽屉控制器
    self.drawerVC = [[MMDrawerController alloc]initWithCenterViewController:mainVC   leftDrawerViewController:leftNavi];
    //设置抽屉抽出的宽度
    _drawerVC.maximumLeftDrawerWidth = 270;
    
    //滑动手势开关抽屉
    [_drawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window.rootViewController = _drawerVC;
    [UMSocialData setAppKey:@"5683e0d9e0f55a28c9000a7e"];
    [ShareSDK registerApp:@"e19b195b7390" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:nil onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"1282826288" appSecret:@"84ba782e34d1cca9255333e46ac6a615" redirectUri:@"http://www.lanou3g.com" authType:SSDKAuthTypeBoth];
                break;
                
            default:
                break;
        }
        
    }];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UMessage didReceiveRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

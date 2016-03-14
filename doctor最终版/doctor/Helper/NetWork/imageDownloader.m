//
//  imageDownloader.m
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "imageDownloader.h"
#import "FileManager.h"

@implementation imageDownloader
- (instancetype)initWithImageURL:(NSString *)imageURL {
    self = [super init];
    if (self) {
        self.imageURL = imageURL;
    }
    return self;
}

//- (void)startDownload {
////先判断本地是否缓存过该图片
//    if ([self fileExist]) {
//        //如果之前缓存过，直接把对应的数据传递给外界
//        [self loadFromlocal];
//    }else {
//    //如果本地没有，则请求网络下载，下载后保存到本地
//        [self loadFromNetWork];
//    
//    }

//}
////文件是否存在
//- (BOOL)fileExist {
//    //之前定义单例类 使用
//    return  [[NSFileManager defaultManager]fileExistsAtPath:[FileManager downLoadImagePath]];
//    
//    
//}
//
//
//
////从本地读取
//- (void)loadFromlocal {
// 
//    
//    NSData *data = [NSData dataWithContentsOfFile:[FileManager imageFilePathWithName:self.imageURL]];
//    self.imageDownloadBlock(data);
//    
//    
//}
//从网络请求
- (void)loadFromNetWork {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imageURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.imageDownloadBlock(data);
     //   NSString *filePath = [[FileManager sharedManager]imageFilePathWithName:self.imageURL];
        
        //写入
     //   [data writeToFile:filePath atomically:YES];
    }];
    
    
    
}


@end

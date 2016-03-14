//
//  imageDownloader.h
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^DownloadBlock)(NSData *data);

@interface imageDownloader : NSObject

/*
 采用异步缓存：先查找本地文件是否缓存，如果存在，读取本地文件 ，否则请求网络 请求之后保存到本地
 */
@property (nonatomic,copy)NSString *imageURL;

//定义Block属性
@property (nonatomic,  copy)DownloadBlock  imageDownloadBlock;
//开始下载
- (void)startDownload;
//重写初始化方法
- (instancetype)initWithImageURL:(NSString *)imageURL;


@end

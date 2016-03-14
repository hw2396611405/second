//
//  UIImageView+Addtion.m
//  DouBan
//
//  Created by 王辉 on 15/12/9.
//  Copyright (c) 2015年 王辉. All rights reserved.
//

#import "UIImageView+Addtion.h"
#import "imageDownloader.h"

@implementation UIImageView (Addtion)
- (void)setImageWithImageURL:(NSString *)imageURL placeholder: (UIImage *)placeholder {
    //占位符
    self.image = placeholder;
    //请求图片
    imageDownloader *downloader = [[imageDownloader alloc] initWithImageURL:imageURL];
    downloader.imageDownloadBlock = ^(NSData *data) {
        self.image = [UIImage imageWithData:data];
    };
    
    //开始下载
    [downloader startDownload];

    

}
@end

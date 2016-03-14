//
//  UIImageView+Addtion.h
//  DouBan
//
//  Created by 王辉 on 15/12/9.
//  Copyright (c) 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addtion)
//从网址上请求图片给它一个占位符
- (void)setImageWithImageURL:(NSString *)imageURL placeholder: (UIImage *)placeholder;
@end

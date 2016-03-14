//
//  Model.h
//  doctor
//
//  Created by 陈春雷 on 15/12/24.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject



@property (nonatomic ,copy) NSString *src;  //图片尺寸
@property (nonatomic ,copy) NSString *pixel;  //图片所处的位置
//
@property (nonatomic, copy) NSString *ref;
//
@property (nonatomic,copy)NSString *digest;//新闻题目详细
@property (nonatomic,copy)NSString *title;//新闻的题目
@property (nonatomic,copy)NSString *imgsrc;//新闻图片显示

@property (nonatomic,assign)NSInteger replyCount;//跟帖数目
@property (nonatomic,retain)NSString *docid;//到普通新闻详情的id  二级界面
@property (nonatomic,retain)NSString *body;//新闻的正文
@property (nonatomic,retain)NSMutableArray *img;
@property (nonatomic,retain)NSString *ptime;//新闻更新时间

@property (nonatomic ,retain) NSString *timgurl;  //轮播图图片

- (instancetype)initWithdic:(NSDictionary *)dic;

+ (instancetype)detailWithDict:(NSDictionary *)dict;


@end

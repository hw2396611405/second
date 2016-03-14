//
//  DetailInfomationController.m
//  doctor
//
//  Created by 陈春雷 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//


#import "DetailInfomationController.h"
#import "MainModel.h"
#import "AFHTTPSessionManager.h"

@interface DetailInfomationController ()<UIWebViewDelegate>

@property (nonatomic , copy) NSMutableArray *dataSouce;

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)NSMutableArray *imgArray;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *bodyLabel;
@property(nonatomic,retain)UIWebView *webView;

@property (nonatomic ,retain) MainModel *model;


@end

@implementation DetailInfomationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    [self.view addSubview:_webView];
    self.webView.delegate = self;
}

- (void)requestData {
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.detailID];
   // NSLog(@"详情ID:%@",self.detailID);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
      //  NSLog(@"------%@",responseObject);
        self.model = [MainModel detailWithDict:responseObject[self.detailID]];
        [self showInWebView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       // NSLog(@"error:%@",error);
    }];
}


- (void)showInWebView {
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"model.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    
    
    [self.webView loadHTMLString:html baseURL:nil];
    

}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.model.ptime];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.model.title];
    if (self.model.body != nil) {
        [body appendString:self.model.body];
    }
    // 遍历img

    for (NSDictionary *dict in self.model.img) {
       MainModel *detailImgModel = [[MainModel alloc]init];
        [detailImgModel setValuesForKeysWithDictionary:dict];
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        
        
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        
        
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}





- (void)handlePage{
    CGFloat x = self.scrollView.contentOffset.x;
    x+=[UIScreen mainScreen].bounds.size.width;
    if (x > kScreenWidth * 6) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(x, 0);}
}





- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bodyLabel.frame];
    }
    
    return _scrollView ;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

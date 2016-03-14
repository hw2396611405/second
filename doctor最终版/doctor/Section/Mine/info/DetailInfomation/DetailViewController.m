//
//  DetailViewController.m
//  doctor
//
//  Created by 陈春雷 on 15/12/23.
//  Copyright © 2015年 王辉. All rights reserved.
//

#define  URLSTR @"http://apis.baidu.com/tngou/info/show"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "DetailViewController.h"
#import "AFHTTPSessionManager.h"
#import "DetailModel.h"


@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic ,retain) NSMutableArray *dataSource;  //数据源

@property (nonatomic ,retain) UIWebView *webView;

@property (nonatomic ,retain) DetailModel *model;

@end

@implementation DetailViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    self.tabBarItem.title = @"详情";
    //[self requestData];
    
    //布局
    [self setViewDetail];
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/show";
    NSString *httpArg = @"id=10";
    [self request: httpUrl withHttpArg: httpArg];

}

- (void)setViewDetail {
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    [self.view addSubview:_webView];
    self.webView.delegate = self;
}

//数据请求
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"2cdc13601521a32bc958fa273881ffda" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               [self handleData:data];
                               
                               
                        
                               
                               if (error) {
                                  // NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   //NSLog(@"HttpResponseCode:%ld", responseCode);0
                                 //  NSLog(@"HttpResponseBody %@",responseString);
                               }
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
    [body appendFormat:@"<div class=\"time\">%@</div>",self.model.time];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.model.title];
    if (self.model.message != nil) {
        [body appendString:self.model.message];
    }
      return body;
}




- (void)handleData:(NSData *)data {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
   
        DetailModel *model = [[DetailModel alloc]initWithDic:dic];
    self.model = [DetailModel detailImageWithDic:dic];
    
      [self.dataSource addObject:model];
   
    [self showInWebView];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   // NSLog(@"error");
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

//
//  hospitalDetailViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "hospitalDetailViewController.h"
#import "hospitalDetail.h"
#import "UIImageView+Addtion.h"
#import "UIImageView+WebCache.h"

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWeight   [UIScreen mainScreen].bounds.size.width
#define kWeight 90
#define kLabelWeight 260
#define kLabelHeight  30
#define kTopHeight 20
#define kHeight 30

@interface hospitalDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,retain)UIImageView *posterView;//医院图片
@property (nonatomic, retain)UILabel *addressLabel;//医院地址
@property (nonatomic, retain)UILabel *levelLabel;//医院实行
@property (nonatomic, retain) UILabel *telLabel;//医院电话
@property (nonatomic, strong) UILabel *natureLabel;//医院性质
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain)NSDictionary *dataSource;

@property (nonatomic, retain)UIWebView *messageWebView;


@end

@implementation hospitalDetailViewController

//去掉网页中的标识符
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    NSString * regEx = @"<([^>]*)>";
    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.name;
  
   
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _scrollView;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize  = CGSizeMake([[UIScreen mainScreen]bounds].size.width - 20,2000);
    
     [self layoutSubView];
    
    NSString *httpUrl = @"http://apis.baidu.com/tngou/hospital/name";
    
    //将字符串转化为unicode
    NSString *str = [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    
NSString *httpArg = [NSString stringWithFormat:@"name=%@",str];


    [self request: httpUrl withHttpArg: httpArg];
    


    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubView {
    self.posterView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20,80, 120)];
   self.levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight, kLabelWeight, kLabelHeight)];
   self.telLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight + kHeight*2, kLabelWeight, kLabelHeight)];
    self.natureLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight +kHeight , kLabelWeight, kLabelHeight)];
  

    
  self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeight, kTopHeight + kHeight*3, kLabelWeight, kLabelHeight)];
    UILabel *GoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 142, 100, 30)];
    GoLabel.text = @"乘车路线:";
    self.GobusView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 175, kScreenWeight, 0)];

    self.messageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 175, kScreenWeight , 1000)];
    
   
    
    [_scrollView addSubview:_natureLabel];
    [_scrollView addSubview:_levelLabel];
    [_scrollView addSubview:_telLabel];
    [_scrollView addSubview:_messageWebView];
    [_scrollView addSubview:_GobusView];
    [_scrollView addSubview:GoLabel];
   [_scrollView addSubview:_posterView];
    [_scrollView addSubview:_addressLabel];
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 20];

    [request addValue: @"5026df6bf6f56cbb3dcb51d6e52b6bb0" forHTTPHeaderField: @"apikey"];
    __block hospitalDetailViewController *vc = self;
    
   [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if (error)
        {
        //    NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else
        {
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         //   NSLog(@"HttpResponseCode:%ld", responseCode);
         //   NSLog(@"HttpResponseBody %@",responseString);
        
            [vc handleData: data];

        }
    }];
}

- (void)handleData:(id)data {
    //json 解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    hospitalDetail *detail = [[hospitalDetail alloc]initWithDic:dic];
    
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /></head><body style=\"margin-top:-20px;\"bgcolor=\"#FFFFFF\"><div align=\"center\"><table width=\"288\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"font-family:黑体;font-size:15px;\"><tr><td valign=\"top\"><br>%@</td></tr></table></div><br /></body></html>",detail.message];
  //  NSLog(@"______%@",htmlString);
    
    self.telLabel.text = detail.tel;
    //图片网址的拼接
    NSString *imageUrl = [NSString stringWithFormat:@"http://tnfs.tngou.net/image"];
    imageUrl = [imageUrl stringByAppendingString:detail.img];
    [self.posterView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];

    self.addressLabel.text = detail.address;
    self.telLabel.text = detail.tel;
    self.levelLabel.text = detail.level;
    self.natureLabel.text = detail.mtype;
    
    [self.GobusView  loadHTMLString:self.gobus baseURL:nil];
    [self.messageWebView loadHTMLString:htmlString baseURL:nil];
    

}


+ (CGFloat)heightWithContent: (NSString *)content {
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
    //返回content的行高
    return [content boundingRectWithSize:CGSizeMake(kScreenWeight - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView == self.messageWebView) {
        
        
        CGFloat messageHeight = self.messageWebView.scrollView.contentSize.height;
        
        CGRect messageFrame = self.messageWebView.frame;
        messageFrame.size.height = messageHeight;
        self.messageWebView.frame = messageFrame;
        
        
        CGFloat contentHeigt = self.messageWebView.frame.origin.y + messageHeight;
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, contentHeigt);
      //  NSLog(@"成功");
        
    }
}

@end

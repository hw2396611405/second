//
//  knowledgeDetailViewController.m
//  doctor
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "knowledgeDetailViewController.h"
#import "doctor.h"
//#import "FileManager.h"
#import "CollectHelper.h"
#import "LoginViewController.h"



#define kHeight 30
#define kImageHeight 150
@interface knowledgeDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, retain)UIWebView *Webview;
@property (nonatomic, retain)NSString *urlStr;
@property (nonatomic, retain)NSString *concent;
@property (nonatomic,retain)UIAlertController *alert;
@end

@implementation knowledgeDetailViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[DataBaseManeger defaultManager];

   self.urlStr = [NSString stringWithFormat:@"http://dxy.com/app/i/columns/article/single?id=%ld",self.model.ID];

    self.Webview = [[UIWebView alloc]initWithFrame:CGRectMake(5, 375, kScreenWidth-20, 100)];
   self.Webview.delegate = self;
    self.view = _Webview;
    //解析数据
    [self request:_urlStr];
    
    //添加收藏按钮
    UIBarButtonItem *right = [[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:@"star_unfav"] style:UIBarButtonItemStyleDone target:self action:@selector(handleCollection)];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont"] style:UIBarButtonItemStyleDone target:self action:@selector(handleShare)];
    self.navigationItem.rightBarButtonItems = @[right,shareBtn];
 
  
  
}

//处理分享的事件
- (void)handleShare {
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    [shareParams SSDKSetupShareParamsByText:@"分享内容 @value(url)"
                                     images:nil
                                        url:[NSURL URLWithString:_urlStr]
                                      title:nil
                                       type:SSDKContentTypeAuto];
 
    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateCancel:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            default:
                break;
        }
        
        
    }];
    


}

- (void)handleCollection {
    self.alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //判断用户是否登录
    //
    if ([FileManager userHadLogin])
    {
        //用户已经登录 判断用户是否已经收藏过了
        
        BOOL isCollection = [[CollectHelper sharedInstance] selectCollectObject:self.model];
        
        if (!isCollection) {
            
            [[CollectHelper sharedInstance] insertCollectObject:self.model];
            self.alert.message = @"收藏成功";
            
        }else
        {
            self.alert.message = @"请勿重复收藏";
        }

        

//        if ([DataBaseManeger isNotHadIDInTab:[NSString stringWithFormat:@"%@",self.model.dic[@"id"]]])
//        {
//            //将收藏数据库放在子线程中
//            //__block typeof(self) blockSelf = self;
//            dispatch_queue_t queue = dispatch_queue_create("com.aa.bb", DISPATCH_QUEUE_CONCURRENT);//创建自定义队列
//            dispatch_async(queue, ^{
//                [DataBaseManeger addCollectToSQLite:self.model.dic];
//            });
    }
    else
    {
    //用户未登录,提示不能收藏,是否要登录
        self.alert.message = @"未登录不能收藏,是否要登录";
        __block typeof(self)weakSelf = self;
       UIAlertAction *action = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
           LoginViewController *loginVC = [[LoginViewController alloc]init];
           [weakSelf.navigationController pushViewController:loginVC animated:YES];
       }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        [self.alert addAction:action];
        [self.alert addAction:action1];
    }
    //弹出提示框
    [self presentViewController:self.alert animated:YES completion:^{
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTime:) userInfo:nil repeats:NO];
    }];
}

//提示框消失
- (void)handleTime: (NSTimer *)timer{
    [self.alert dismissViewControllerAnimated:YES completion:nil];
    [timer invalidate];


}


-(void)request: (NSString*)urlStr{

    NSURL  *url = [NSURL URLWithString: urlStr];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
   [NSURLConnection  sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       if (connectionError) {
        //   NSLog(@"connectionError%@",connectionError);
       }else {
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = dic[@"data"][@"items"];
            for (NSDictionary *dict in arr) {
               self.concent = dict[@"content"];
               [self.Webview loadHTMLString:self.concent baseURL:nil];
           }

       }
       
   } ];
   
}

    
    
- (void)handleData:(id)data {
    //json 解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.concent = dic[@"data"][@"items"][@"content"];
    
   NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /></head><body style=\"margin-top:-20px;\"bgcolor=\"#FFFFFF\"><div align=\"center\"><table width=\"288\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"font-family:黑体;font-size:15px;\"><tr><td valign=\"top\"><br>%@</td></tr></table></div><br /></body></html>",self.concent];
    [self.Webview loadHTMLString:htmlString baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView == self.Webview) {
        
        [_Webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
            "script.type = 'text/javascript';"
            "script.text = \"function ResizeImages() { "
            "var myimg,oldwidth;"
            "var maxwidth = %f;" // UIWebView中显示的图片宽度
            "for(i=0;i <document.images.length;i++){"
                    "myimg = document.images[i];"
                "if(myimg.width > maxwidth){"
                    "oldwidth = myimg.width;"
                    "myimg.width = maxwidth;"
                                    "}"
                                            "}"
                                                          "}\";"
                "document.getElementsByTagName('head')[0].appendChild(script);",355.0]];
        [_Webview stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
        CGFloat messageHeight = self.Webview.scrollView.contentSize.height;
        CGRect messageFrame = self.Webview.frame;
        messageFrame.size.height = messageHeight;
        self.Webview.frame = messageFrame;
        CGFloat contentHeigt = self.Webview.frame.origin.y + messageHeight;
    }
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

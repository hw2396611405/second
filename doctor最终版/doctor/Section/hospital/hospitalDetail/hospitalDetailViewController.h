//
//  hospitalDetailViewController.h
//  doctor
//
//  Created by 王辉 on 15/12/26.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hospitalDetailViewController : UIViewController
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *gobus;
@property (nonatomic, retain)UIWebView *GobusView;
@end

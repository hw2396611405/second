//
//  LoginView.h
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTVIew.h"

@interface LoginView : UIView
@property (nonatomic,retain)LTVIew *userLT;
@property (nonatomic, retain)LTVIew *passwordsLT;
@property (nonatomic, retain)UIButton *loginBtn;
@property (nonatomic, retain)UIButton *registerBtn;
@property (nonatomic, retain)UIButton *WbBtn;
@end

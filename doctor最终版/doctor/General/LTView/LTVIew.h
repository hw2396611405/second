//
//  LTVIew.h
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTVIew : UIView
@property (nonatomic, retain)UILabel *leftLabel;
@property (nonatomic, retain)UITextField *rightTF;
- (instancetype)initWithFrame:(CGRect)frame leftLabel:(NSString *)text placeholder: (NSString *)placeholder;
@end

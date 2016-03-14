//
//  LTVIew.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "LTVIew.h"

@implementation LTVIew
- (instancetype)initWithFrame:(CGRect)frame leftLabel:(NSString *)text placeholder:(NSString *)placeholder {
    self = [super initWithFrame:frame];
    if (self) {
        //获取该视图的宽度
        CGFloat width = frame.size.width;
        //leftLabel
        [self setUpLeftLabelWithWidth:width/3 Nstring:text];
        
        //rightTF
        [self setupRightTextFieldWithWidth:2*width/3 Nstring:placeholder];
        
        
    }
    return self;
}

- (void)setUpLeftLabelWithWidth: (CGFloat)width Nstring: (NSString *)text {
    self.leftLabel= [[UILabel alloc] initWithFrame: CGRectMake(0, 0, width, self.frame.size.height)];
    self.leftLabel.text = text;
    [self addSubview:_leftLabel];
 
}

//right textField
- (void)setupRightTextFieldWithWidth: (CGFloat)width  Nstring: (NSString *)text1{
    
    self.rightTF = [[UITextField alloc] initWithFrame:CGRectMake(width/2, 0, width, self.frame.size.height)];
    //_textField.backgroundColor = [UIColor redColor];
    _rightTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _rightTF.borderStyle = UITextBorderStyleRoundedRect;
    
    
    self.rightTF.placeholder = text1;
    [self addSubview:_rightTF];
   
}



@end

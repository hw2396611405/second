//
//  FirstListHeader.m
//  today2016
//
//  Created by wanghui on 16/3/1.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "FirstListHeader.h"

@implementation FirstListHeader

-(void)setModel:(listHeaderMOdel *)model {
    NSString *str = model.tags;
   NSArray *arr =  [str componentsSeparatedByString:@","];
    if (arr.count == 1) {
        self.tagLabel1.text = arr[0];
        self.tagLabel2.hidden = YES;
        self.tagLabel3.hidden = YES;
    }else if (arr.count == 2) {
        self.tagLabel1.text =arr[0];
        self.tagLabel2.text = arr[1];
        self.tagLabel3.hidden = YES;
    }else {
        self.tagLabel1.text = arr[0];
        self.tagLabel2.text = arr[1];
        self.tagLabel3.text = arr[2];
        }
    self.nicknameLabel.text = model.nickname;
    [self.photoView1 sd_setImageWithURL:[NSURL URLWithString:model.coverSmall]];
    [self.photoView2 sd_setImageWithURL:[NSURL URLWithString:model.avatarPath]];
    self.introLabel.text = model.intro;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    self.tagLabel1.layer.borderColor = [UIColor blueColor].CGColor;
//    self.tagLabel1.layer.borderWidth = 2;
    
}


@end

//
//  PlayViewController.h
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *needleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)NSInteger index;


@end

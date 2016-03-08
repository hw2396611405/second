//
//  PlayViewController.m
//  today2016
//
//  Created by wanghui on 16/2/26.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "listModel.h"

@interface PlayViewController ()
@property (nonatomic,strong)AVPlayer *avPlayer;
@property (nonatomic,assign)BOOL isPlayer;//播放状态
@property (nonatomic,strong)NSTimer *progressUpdataTime;//计时器
@property (nonatomic,assign)NSInteger total;

@end

@implementation PlayViewController
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //关闭计时器
    [self.progressUpdataTime invalidate];

}


- (IBAction)collectBtn:(id)sender {
    
    
}

- (IBAction)proBtn:(id)sender {
    if (self.index == 0) {
        self.index = self.dataArray.count - 1;
    }else {
        self.index--;
    }
    [self playMusic];
    
}
- (IBAction)playOrPauseBtn:(id)sender {
    //YES 为正在播放
    if (self.isPlayer) {
        [sender setImage:[UIImage imageNamed:@"playing_btn_play_h"] forState:UIControlStateNormal];
        //移开滑竿
        [UIView animateWithDuration:0.5 animations:^{
            self.needleImageView.transform = CGAffineTransformRotate(self.needleImageView.transform, -M_PI/6);
            [self.avPlayer  pause];
        }];
        //关闭计时器
        [self.progressUpdataTime invalidate];
    }else {
        [sender setImage:[UIImage imageNamed:@"playing_btn_pause_h"] forState:UIControlStateNormal];
        [self.avPlayer play];
        //添加滑竿
        [UIView animateWithDuration:0.5 animations:^{
            self.needleImageView.transform = CGAffineTransformRotate(self.needleImageView.transform, M_PI/6);
        }];
        //开启计时器
        self.progressUpdataTime = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    
    }
    //改变播放状态
    self.isPlayer = !self.isPlayer;
    
}
- (IBAction)nextBtn:(id)sender {
    if (self.index == self.dataArray.count - 1) {
        self.index = 0;
    }else {
        self.index ++;
    }
    [self playMusic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置播放状态
    self.isPlayer = YES;
    //播放音乐
    [self playMusic];
    //注册播放状态 观察播放结束
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark ---custom 
-(void)playFinish{
//播放下一曲
    [self nextBtn:nil];

}



- (void)playMusic {
    listModel *model = self.dataArray[self.index];

    NSURL *url = [NSURL URLWithString:model.playUrl32];
    //每一个音乐都为一个项目
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.coverSmall] ];
    //导航条标题
    self.navigationItem.title =model.title;
    //设置开始时间
    self.startLabel.text = @"00:00";
    //给总时长赋值
    self.total = [model.duration floatValue];
    self.totalLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",_total/60,_total%60];
    //设置播放进度
    self.progressView.progress = 0.0f;
    if (!_avPlayer) {
        //创建播放器
        self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:item];
        self.progressUpdataTime = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    }else {
    //替换播放资源对象 切换歌曲
        [self.avPlayer replaceCurrentItemWithPlayerItem:item];
    }
    [self.avPlayer play];
}

- (void)changeTime {
    //获取当前的播放时间
    CMTime currentTime = self.avPlayer.currentItem.currentTime;
    NSInteger seconds = CMTimeGetSeconds(currentTime);
    self.startLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",seconds/60,seconds%60];
    CGFloat progress = seconds*1.0/self.total;
    self.progressView.progress = progress;
    //旋转背景图片
    self.photoView.transform = CGAffineTransformRotate(self.photoView.transform, M_PI/360);
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

- (void)dealloc
{
//移除观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}


@end

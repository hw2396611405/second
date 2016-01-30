//
//  MusicViewController.m
//  today
//
//  Created by wanghui on 16/1/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MusicViewController ()<AVAudioPlayerDelegate,UITableViewDataSource>
//记忆标示
@property (nonatomic,assign)BOOL isPlay;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic,strong)AVAudioPlayer *audioPlayer;//播放器

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;//进度条

@property (nonatomic,strong)NSTimer *progressUpdataTimer;//计时器

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;//当前时间显示
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;//总时间显示
@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;//

@property (nonatomic,strong)NSMutableArray *lrcTimeAry;
@property (nonatomic, strong)NSMutableDictionary *licDic;//存放歌词
@property (assign,nonatomic)NSInteger line;
@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = @[@"情非得已",@"情非得已",@"情非得已"];
    NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",_dataArr[0]] ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;//传地址,就说明要在该地方内部对对象进行修改
    //初始化一个播放器
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error == nil) {
        NSLog(@"正常播放");
    }else  {
        NSLog(@"播放失败%@",error);
    }
    self.audioPlayer.delegate = self;
    //对歌词进行解析
    [self parserLrc];

}
//播放或暂停
- (IBAction)changeProgress:(UISlider *)sender {
    self.audioPlayer.currentTime = sender.value;
}

//paly事件
- (IBAction)playButton:(UIButton *)sender {
    if (!self.isPlay) {
        //播放
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        self.isPlay = !self.isPlay;
        //播放
        [self.audioPlayer play];
        //修改slider 的最大值
        self.progressSlider.maximumValue = self.audioPlayer.duration;
        //通过计时器观测当前时间
        self.progressUpdataTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changTime) userInfo:nil repeats:YES];
        //显示总时间
        self.totalTimeLabel.text = [self timeStringFromSecond:self.audioPlayer.duration];
    }else {
        //暂停
        [self.audioPlayer pause];
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        self.isPlay = !self.isPlay;
    
    }
}


- (IBAction)downButton:(UIButton *)sender {
    [self.progressUpdataTimer invalidate];
}

- (IBAction)upButton:(UIButton *)sender {
    [self.progressUpdataTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self .progressUpdataTimer invalidate];
    [self.audioPlayer play];

}


//对歌词进行解析
- (void)parserLrc {
    //读取歌词内容
    NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",_dataArr[0]] ofType:@"lrc"];
    NSString *contentStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.licDic = [NSMutableDictionary dictionaryWithCapacity:1];
    self.lrcTimeAry  = [NSMutableArray arrayWithCapacity:1];
    //进行换行分割,获取每一行的歌词
    NSArray *linArr = [contentStr componentsSeparatedByString:@"\n"];
    for (NSString *string in linArr) {
        if (string.length > 7) {
            NSString *str1 = [string substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [string substringWithRange:NSMakeRange(6, 1)];
            
            if ([str1 isEqualToString:@":"]&&[str2 isEqualToString:@"."]) {
                //截取歌词和时间
                NSString *timeStr = [string substringWithRange:NSMakeRange(1, 5)];
                NSString *lrcStr = [string substringFromIndex:10];
                //加入到集合中
                [self.lrcTimeAry addObject:timeStr];
                [self.licDic setObject:lrcStr forKey:timeStr];
                
            }
        }
        
    }

}


//计时器关联方法
- (void)changTime {
    NSString *currentString = [self timeStringFromSecond:self.audioPlayer.currentTime];
    self.progressSlider.value =  self.audioPlayer.currentTime;
    self.currentTimeLabel.text = currentString;
    //判断数组是否包含某个元素
    if ([self.lrcTimeAry containsObject:currentString]) {
        self.line = [self.lrcTimeAry indexOfObject:currentString];
        [self.lrcTableView reloadData];
        //选中tableView的这一行
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.line inSection:0];
        [self.lrcTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }


}

- (NSString *)timeStringFromSecond:(NSInteger)second {
    return [NSString stringWithFormat:@"%02ld:%02ld",second/60,second %60];
}

#pragma mark UITableViewDataSource;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.lrcTimeAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *key = self.lrcTimeAry[indexPath.row];
    cell.textLabel.text = self.licDic[key];
    //改变textLabel 的样式
    if (indexPath.row == self.line) {
        cell.textLabel.font = [UIFont systemFontOfSize:20.0];
        cell.textLabel.textColor = [UIColor blueColor];
    } else {
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

//远程控制
-(void)remoteControlReceivedWithEvent:(UIEvent *)event {
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            NSLog(@"播放");
            break;
            case UIEventSubtypeRemoteControlStop:
            
            
        default:
            break;
    }

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

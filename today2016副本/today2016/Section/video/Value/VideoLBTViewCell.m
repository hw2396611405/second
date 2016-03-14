//
//  VideoLBTViewCell.m
//  today2016
//
//  Created by wanghui on 16/3/3.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "VideoLBTViewCell.h"
#import "LBTModel.h"


@interface VideoLBTViewCell ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *VideoLBTView;


@end


@implementation VideoLBTViewCell

- (void)awakeFromNib {
   //服从代理方法
    self.VideoLBTView.delegate = self;
}

//实现点滑动点击的方法
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{


}

//重写数组的setter的方法
-(void)setVideoLBTDataSource:(NSMutableArray *)VideoLBTDataSource {
    if (_VideoLBTDataSource != VideoLBTDataSource) {
        _VideoLBTDataSource = VideoLBTDataSource;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
    for (LBTModel *model  in VideoLBTDataSource) {
        [arr addObject:model.img];
    }
    self.VideoLBTView.imageURLStringsGroup = [NSArray arrayWithArray:arr];

}

@end

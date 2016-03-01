//
//  LBTViewCell.m
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "LBTViewCell.h"
#import "SDCycleScrollView.h"
#import "MusicLBT.h"

@interface LBTViewCell()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *LBTView;

@end
@implementation LBTViewCell


- (void)awakeFromNib {
    //服从代理方法
    self.LBTView.delegate = self;

}
//滑动点击的方法
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

}

-(void)setImageDataSource:(NSMutableArray *)imageDataSource {
    if (_imageDataSource != imageDataSource) {
        _imageDataSource = imageDataSource;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
    NSLog(@"----%ld",self.imageDataSource.count);
    for (MusicLBT *model in imageDataSource) {
        [arr addObject:model.pic];
        NSLog(@"%@",model.pic);
    }
    self.LBTView.imageURLStringsGroup = [NSArray arrayWithArray:arr];
}


@end

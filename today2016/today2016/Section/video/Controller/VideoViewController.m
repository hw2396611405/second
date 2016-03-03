//
//  VideoViewController.m
//  today2016
//
//  Created by wanghui on 16/3/2.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoViewCell.h"
#import "VideoHeaderView.h"
#import "LBTViewCell.h"
#import "today2016-Swift.h"





@interface VideoViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray *LBTArr;//轮播图
@property (nonatomic,strong)NSMutableArray *JZTJArr;//佳作推荐
@property (nonatomic,strong)NSMutableArray *GNZPArr;//国内作品
@property (nonatomic,strong)NSMutableArray *GWZPArr;//国外作品

@end

@implementation VideoViewController
//懒加载 为数组开辟空间
- (NSMutableArray *)LBTArr {
    if (!_LBTArr) {
        self.LBTArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _LBTArr;
}

- (NSMutableArray *)JZTJArr {
    if (!_JZTJArr) {
        self.JZTJArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _JZTJArr;
}

- (NSMutableArray *)GNZPArr {
    if (!_GNZPArr) {
        self.GNZPArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _GNZPArr;
}

- (NSMutableArray *)GWZPArr {
    if (!_GWZPArr) {
        self.GWZPArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _GWZPArr;
}





//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LBTViewCell" bundle:nil] forCellWithReuseIdentifier:@"LBTViewCell"];
    
    //注册区头
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoHeaderView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VideoHeaderView"];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        LBTViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBTViewCell" forIndexPath:indexPath];
        return cell;
    }
    VideoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell"forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"listVideoViewController" bundle:nil];
    listVideoViewController *listVideoVC = [storyboard instantiateViewControllerWithIdentifier:@"listVideoViewController"];
    [self presentViewController:listVideoVC animated:YES completion:nil];
    
  
    


}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 200);
    }

    return CGSizeMake((kScreenWidth - 30)/3, 160);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(5, 10, 5, 10);
}

//最小的竖直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 5;
}


//区头的代理方法实现
  //返回header的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 30);

}

 //返回区头cell的方法
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }else {
        VideoHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VideoHeaderView" forIndexPath:indexPath];
        return header;
    
    }
    
    
}










@end
//
//  MusicViewController.m
//  today2016
//
//  Created by wanghui on 16/2/29.
//  Copyright © 2016年 王辉. All rights reserved.
//

#import "MusicViewController.h"
#import "LBTViewCell.h"
#import "XBTJViewCell.h"
#import "MusicViewHeader.h"
#import "JPTDViewCell.h"
#import "MusicLBT.h"
#import "MusicLBT.h"



@interface MusicViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *musicView;
@property (nonatomic,strong)NSMutableArray *imagedataSource;//数据源
@property (nonatomic,strong)NSMutableArray *categoryArr;//分类数据源
@property (nonatomic,strong)NSMutableArray *allArr;//存放所有数组
@end

@implementation MusicViewController

//懒加载
- (NSMutableArray *)imagedataSource {
    if (!_imagedataSource) {
        self.imagedataSource = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _imagedataSource;
}

-(NSMutableArray*)categoryArr {
    if (!_categoryArr) {
        self.categoryArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _categoryArr;

}

-(NSMutableArray *)allArr {
    if (!_allArr) {
        self.allArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _allArr;
}

//static NSString * const reuseIdentifier = @"LBTViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.musicView registerNib:[UINib nibWithNibName:@"LBTViewCell" bundle:nil]forCellWithReuseIdentifier:@"LBTViewCell" ];
    [self.musicView registerNib:[UINib nibWithNibName:@"XBTJViewCell" bundle:nil] forCellWithReuseIdentifier:@"XBTJViewCell"];
    [self.musicView registerNib:[UINib nibWithNibName:@"JPTDViewCell" bundle:nil] forCellWithReuseIdentifier:@"JPTDViewCell"];
    
    //区头
    [self.musicView registerNib:[UINib  nibWithNibName:@"MusicViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MusicViewHeader"];
  
    //数据解析
    [self dataRequestURL:MusicUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
//数据解析的实现
- (void)dataRequestURL:(NSString *)url {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray  *focusImagesArr = dic[@"focusImages"][@"list"];
        for (NSDictionary *dic in focusImagesArr) {
            MusicLBT *model = [[MusicLBT alloc] initWithDic:dic];
           [self.imagedataSource addObject:model];
           NSLog(@"%ld",self.imagedataSource.count);
            [self.musicView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error%@",error);
    }];
    

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

    return 10;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 3) {
        return 2;
    }else if (section == 0) {
        return 1;
    }
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       LBTViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBTViewCell" forIndexPath:indexPath];
        //给cell赋值
        if (self.imagedataSource.count > 0) {
            cell.model = self.imagedataSource[indexPath.row];
            cell.imageDataSource = self.imagedataSource;
        }
        
        return cell;
    }else if (indexPath.section == 3) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JPTDViewCell" forIndexPath:indexPath];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XBTJViewCell" forIndexPath:indexPath];
    return cell;
    
    
}



#pragma mark ----<UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 200);
    }
    if (indexPath.section == 3) {
        return CGSizeMake(kScreenWidth, 80);
    }
    
    return CGSizeMake((kScreenWidth - 40)/3, 150);
}


//区头的代理方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath  {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //if (indexPath.section == 2) {
        
         if (indexPath.section == 0 || indexPath.section == 1){
        
            return nil;
         }else {
             MusicViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MusicViewHeader" forIndexPath:indexPath];
             return header;
         
         }
        
    }
        return  nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 46);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //设置缩进量
    if (section != 0 || section != 3) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}




@end

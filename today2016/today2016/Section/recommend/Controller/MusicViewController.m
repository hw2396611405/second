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
#import "XBTJViewCell.h"
#import "listViewController.h"
#import "FirstListHeader.h"

@interface MusicViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *musicView;
@property (nonatomic,strong)NSMutableArray *imagedataSource;//数据源
@property (nonatomic,strong)NSMutableArray *categoryArr;//分类数据源
@property (nonatomic,strong)NSMutableArray *RMTJArr;//存放所有数组
@property (nonatomic,strong)NSMutableArray *JPTDArr;//精品听单数组
@property (nonatomic,strong)NSMutableArray *XBTJArr;//小编推荐数组
@property (nonatomic,strong)NSMutableArray *headerArr;//所有区头标题数组
@end

@implementation MusicViewController
#pragma mark 懒加载
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

-(NSMutableArray *)RMTJArr {
    if (!_RMTJArr) {
        self.RMTJArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _RMTJArr;
}
-(NSMutableArray *)JPTDArr
{
    if (!_JPTDArr) {
        self.JPTDArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _JPTDArr;
}

-(NSMutableArray *)XBTJArr
{
    if (!_XBTJArr) {
        self.XBTJArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _XBTJArr;
}

- (NSMutableArray *)headerArr {
    if (!_headerArr) {
        self.headerArr = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _headerArr;
}



#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];

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
        }
        
        NSArray *specialColumnArr = dic[@"specialColumn"][@"list"];
        for (NSDictionary *dic in specialColumnArr) {
            JPTDModel *model = [[JPTDModel alloc]initWithDic:dic];
            [self.JPTDArr addObject:model];
        }
        
        NSArray *editorRecommendAlbumsArr = dic[@"editorRecommendAlbums"][@"list"];
        for (NSDictionary *dic in editorRecommendAlbumsArr) {
            commonModel *model = [[commonModel alloc]initWithDic:dic];
            [self.XBTJArr addObject:model];
        }
        
        NSArray *hotRecommendsArr = dic[@"hotRecommends"][@"list"];
        for (NSDictionary *dic in hotRecommendsArr) {
           NSString *header = dic[@"title"];
            [self.headerArr addObject:header];
            NSArray *arr = dic[@"list"];
            for (NSDictionary *Dic in arr) {
                commonModel *model = [[commonModel alloc] initWithDic:Dic];
                [self.RMTJArr addObject:model];
            }
        }
        
        //ANF3.0 之后解析数据在子线程 要返回主线程刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.musicView reloadData];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error%@",error);
    }];
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 17;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 2) {
        return 2;
    }else if (section == 0) {
        return 1;
    }
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       LBTViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LBTViewCell" forIndexPath:indexPath];
        if (self.imagedataSource.count > 0) {
            cell.model = self.imagedataSource[indexPath.item];
            cell.imageDataSource = self.imagedataSource;
   }
        return cell;
    }else if (indexPath.section == 2) {
        JPTDViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JPTDViewCell" forIndexPath:indexPath];
        //安全处理
        if (self.JPTDArr.count > 0) {
             cell.model = self.JPTDArr[indexPath.row];
        }
        return cell;
    }else if (indexPath.section  == 1 ) {
        XBTJViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XBTJViewCell" forIndexPath:indexPath];
        if (self.XBTJArr.count > 0) {
            cell.model = self.XBTJArr[indexPath.row];
        }
        return cell;
    };
    XBTJViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XBTJViewCell" forIndexPath:indexPath];
    if (self.RMTJArr.count > 0) {
        commonModel *model = self.RMTJArr[(indexPath.section - 3) * 3 + indexPath.item];
        cell.model = model;
        }
    
    return cell;
    
    
}

#pragma mark 实现跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //找到目标控制器
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    listViewController *listVC = [storyboard instantiateViewControllerWithIdentifier:@"listViewController"];
    if (indexPath.section == 0) {
       // listVC.tableView.tableHeaderView =
    }

    
    [self.navigationController pushViewController:listVC animated:YES];
}



#pragma mark ----<UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 200);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(kScreenWidth - 30, 80);
    }
    
    return CGSizeMake((kScreenWidth - 40)/3, 140);
}


//区头的代理方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath  {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
         if (indexPath.section == 0){
            return nil;
         }else {
             MusicViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MusicViewHeader" forIndexPath:indexPath];
          NSMutableArray *titleArr = [[NSMutableArray alloc]initWithCapacity:1];
             NSArray *arr = @[@"小编推荐",@"精品听单"];
             [titleArr addObjectsFromArray:arr];
             [titleArr addObjectsFromArray:self.headerArr];
             if (self.headerArr.count > 0) {
                  header.titleLabel.text = titleArr[indexPath.section-1];
             }
              return header;

         }
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 30);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //设置缩进量
    if (section != 0 || section != 2) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}




@end

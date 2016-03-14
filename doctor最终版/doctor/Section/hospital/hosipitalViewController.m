//
//  hosipitalViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/22.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "hosipitalViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "hosipitalViewController.h"
#import "AroundViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
typedef void(^OffsetBlock)(NSInteger);
@interface hospitalViewController ()<MAMapViewDelegate,CLLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)CLLocationManager *locationManager;
/** btn事件调用的block-翻页 */
@property (nonatomic,copy)OffsetBlock offsetBlock;
@property (nonatomic,  strong)AMapSearchAPI *mapSearch;
@property (nonatomic, strong)AMapPOIAroundSearchRequest *mapPOIAround;//发起周边请求
@end

@implementation hospitalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearGreenColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAdd)];
    //配置用户的key
    [MAMapServices sharedServices].apiKey = @"6a9cb26e4fa23a003f6460b088f431b9";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
   [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
   [self.view addSubview:_mapView];
    //配置搜索
    _mapSearch = [[AMapSearchAPI alloc]init];
    _mapSearch.delegate = self;
    
    //请求对象
    self.mapPOIAround = [[AMapPOIAroundSearchRequest alloc]init];
    _mapPOIAround.keywords = @"医院";
    _mapPOIAround.types = @"医疗保健服务";
    _mapPOIAround.sortrule = 0;
    _mapPOIAround.requireExtension = YES;
    
    //布局子试图
     [self setUpSubView];
}

// 布局子视图
- (void)setUpSubView {
    
    // 左btn
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 64, kScreenWidth / 2, 40);
    leftBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftBtn];
    leftBtn.tag = 200;
    [leftBtn setTitle:@"地图模式" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 右btn
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(kScreenWidth / 2, 64, kScreenWidth / 2, 40);
    rightBtn.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:rightBtn];
    rightBtn.tag = 201;
    [rightBtn setTitle:@"周边医院" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(handleAdd) forControlEvents:UIControlEventTouchUpInside];
}

// btn点击事件
- (void)handleBtn:(UIButton *)sender {
    //    NSLog(@"%ld",sender.tag);
    if (self.offsetBlock) {
        self.offsetBlock(sender.tag - 200);
    }
    switch (sender.tag) {
        case 200:
            [self.view viewWithTag:200].backgroundColor = [UIColor whiteColor];
            [self.view viewWithTag:201].backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
            break;
        case 201:
            [self.view viewWithTag:201].backgroundColor = [UIColor whiteColor];
            [self.view viewWithTag:200].backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
            break;
        default:
            break;
    }
}




- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
  //  NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}


- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleView *accuracyCircleView = [[MACircleView alloc] initWithCircle:overlay];
        
        accuracyCircleView.lineWidth    = 2.f;
        accuracyCircleView.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleView.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleView;
    }
    return nil;
}
#pragma  mark --MAMapViewDelegate----
//生成标注
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        annotationView.canShowCallout = YES;//设置气泡可以弹出 默认为NO
        annotationView.draggable = YES;//设置标注可以拖动 默认为NO
       // annotationView.animatesDrop =YES;
        
        return annotationView;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        [self addAnnotationWithInfo:userLocation];
        _mapView.centerCoordinate = userLocation.coordinate;
        self.latitude = userLocation.coordinate.latitude;
        self.longitude =  userLocation.coordinate.longitude;
     //   NSLog(@"定位%f",userLocation.coordinate.latitude);
        
        
    }
}


#pragma mark - AMapSearchDelegate -



//添加大头针
- (void)addAnnotationWithInfo: (id)sender {
    //大头针
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    if ([sender isKindOfClass:[MAUserLocation class]]) {
        MAUserLocation *userLocation  = sender;
        pointAnnotation.coordinate = userLocation.coordinate;
        pointAnnotation.title = userLocation.title;
        pointAnnotation.subtitle = userLocation.subtitle;
    }else if ([sender isKindOfClass:[AMapPOI class]]){
        AMapPOI *poi = sender;
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        pointAnnotation.title = poi.name;
        pointAnnotation.subtitle = poi.address;
    
    }
    [_mapView addAnnotation:pointAnnotation];
}





#pragma mark ---Btn---
-(void)handleAdd
{

    AroundViewController *aroundVC = [[AroundViewController alloc]init];
    aroundVC.latitude = self.latitude;
    aroundVC.longitude = self.longitude;
   // NSLog( @"%f",self.longitude);
    [self.navigationController pushViewController:aroundVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end

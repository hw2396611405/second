//
//  LeftViewController.m
//  doctor
//
//  Created by 王辉 on 15/12/23.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import "LeftViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "FirstViewController.h"
#import "CollectListController.h"
#import "hosipitalViewController.h"

//关于我们
#import "AboutUsViewController.h"
//用户反馈
#import "UMFeedback.h"


@interface LeftViewController ()<UMSocialUIDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor clearGreenColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        UIView *aView = [[UIView alloc]init];
       // aView.backgroundColor = [UIColor blueColor];
       aView.frame = CGRectMake(0, 0, 200, 150);
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 40, 60, 60)];
   // _imageView.backgroundColor = [UIColor greenColor];
    _imageView.image = [UIImage imageNamed:@"photoChoose"];
    _imageView.userInteractionEnabled =YES;
    //设置圆角
    _imageView.layer.cornerRadius = 30;
    _imageView.layer.masksToBounds = YES;
    //自适应图片宽高的比例
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
  
    [aView addSubview:_imageView];
    
    //轻拍头像
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [_imageView addGestureRecognizer:tap];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(80, 40, 140, 60);
    [btn setTitle:@"点我登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [aView addSubview:btn];
    [btn addTarget:self action:@selector(handlerLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = aView;
    
    [FileManager sharedManager];
    
}

//处理轻拍事件
-(void)handleTap: (UITapGestureRecognizer *)tap {
//判断相机是否可用
    BOOL isAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (isAvailable) {
        //相机可用 或系统图库
        [self setPhotoWithCamera:YES];
    }else {
    //图库选择
        [self setPhotoWithCamera:NO];
    
    }

}
//设置头像 判断相机是否可用
- (void)setPhotoWithCamera:(BOOL)isAvailable {
    UIAlertController *alert ;
    alert = [UIAlertController alertControllerWithTitle:@"select" message:@"photo" preferredStyle:UIAlertControllerStyleActionSheet];
    __block LeftViewController *vc =self;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action ){
        [vc pickImageWithType:UIImagePickerControllerSourceTypeCamera];
        
    }];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从图库选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //跳转到相册
        [vc pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    if (isAvailable) {
        [alert addAction:action1];
    }
    
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)pickImageWithType: (UIImagePickerControllerSourceType )SourceType {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.allowsEditing = YES;
    controller.sourceType = SourceType;
    [self presentViewController:controller animated:YES completion:nil];
    
}
#pragma mark ---UIImagePickerControllerDelegate----

//choose
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image =   [info objectForKey:UIImagePickerControllerOriginalImage];
    single *obj = [single  Singletion];
    obj.image = image;
    self.imageView.image =image;

    
}
//cancel  选中图片让图片显示
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


//btn处理事件
- (void)handlerLogin:(UIButton *)sender {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        self.mm_drawerController.centerViewController = loginNavi;
    }];
   

    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    switch (indexPath.row) {
      
        case 0:
            cell.textLabel.text = @"首页";
            cell.imageView.image = [UIImage imageNamed:@"Icon0@3x"];
            break;
        case 1:
            cell.textLabel.text = @"医院大全";
            cell.imageView.image = [UIImage imageNamed:@"Icon1@3x"];
            break;
        case 2:
            cell.textLabel.text = @"清除缓存";
            cell.imageView.image = [UIImage imageNamed:@"Icon2@3x"];
            break;
        case 3:
            cell.textLabel.text = @"收藏文章";
            cell.imageView.image = [UIImage imageNamed:@"Icon3@3x"];
            break;
            case 4:
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"Icon4@3x"];
            break;
        case 5:
            cell.imageView.image = [UIImage imageNamed:@"Icon5@3x"];
            cell.textLabel.text = @"设置与反馈";
             break;
        
            
        default:
            break;
    }

    
    return cell;
}

//反馈页面实现方法
- (void)setUpFanKui {
   // [self.navigationController pushViewController:[UMFeedback feedbackViewController] animated:YES];
    [self.mm_drawerController  closeDrawerAnimated:YES completion:^(BOOL finished) {
//        self.mm_drawerController.centerViewController = [UMFeedback feedbackViewController];
        [self presentModalViewController:[UMFeedback feedbackModalViewController] animated:YES];

    }];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectListController *collecVC = [[CollectListController alloc] init];
    UINavigationController *collectNavi = [[UINavigationController alloc]initWithRootViewController:collecVC];
    hospitalViewController *hospitalVC = [[hospitalViewController alloc]init];
    UINavigationController *hospitalNavi = [[UINavigationController alloc]initWithRootViewController:hospitalVC];

    switch (indexPath.row) {
        case 0:
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
          break;
            case 1:
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                self.mm_drawerController.centerViewController = hospitalNavi;
                
            }];
            
            break;
    }

    
    if (indexPath.row == 3 || indexPath.row == 2) {
        if ([FileManager userHadLogin]) {
            switch (indexPath.row) {
               case 2:
                    //清除缓存
                {
                   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleActionSheet];
                    [[CollectHelper sharedInstance]clearAll];

                    alert.message = @"清除缓存成功";
                    [self presentViewController:alert animated:YES completion:nil];
                    [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:alert afterDelay:2];
                    break;
                }
                    
                case 3:
                {
                    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                    self.mm_drawerController.centerViewController = collectNavi;
                       
                   }];
                    break;
                }

                   default:
                    break;
            }
        }else {
            //提醒登录/注册
            [self needLogin];
            
        }
  
    }
    
    if (indexPath.row == 4) {
        AboutUsViewController *aboutVC = [[AboutUsViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:aboutVC];
        [self presentViewController:navi animated:YES completion:nil];
    }
    
    if (indexPath.row == 5) {
        //跳转用户反馈页面
        [self setUpFanKui];
    }
    
    

   }

- (void)handleActionWeather {
   // [UMessage setLogEnabled:YES];
}


- (void)needLogin {

    __block LeftViewController *mineVC = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"不想登录" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [mineVC handleRight];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)handleRight {
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:login];
  
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        self.mm_drawerController.centerViewController = loginNavi;
    }];
  

}


//


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

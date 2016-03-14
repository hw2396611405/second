//
//  knowledgeDetailViewController.h
//  doctor
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnowledgeModel.h"


@interface knowledgeDetailViewController : UIViewController

@property (nonatomic, assign)NSInteger ID;
@property (nonatomic, retain)KnowledgeModel *model;


@end

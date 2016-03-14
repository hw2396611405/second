//
//  ListModel+CoreDataProperties.h
//  today2016
//
//  Created by wanghui on 16/3/8.
//  Copyright © 2016年 王辉. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *coverSmall;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSString *playUrl32;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *duration;

@end

NS_ASSUME_NONNULL_END

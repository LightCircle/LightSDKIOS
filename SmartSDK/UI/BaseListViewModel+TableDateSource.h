//
//  BaseListViewModel+TableDateSource.h
//  ShotEyesiPAD
//
//  Created by kita on 14-5-19.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import "BaseListViewModel.h"
typedef void (^TableViewCellConfigureBlock)(id cell, id item);
@interface BaseListViewModel (TableDateSource)<UITableViewDataSource>
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, retain) NSString *cellIdentifier;

- (id)initWithViewModelClass:(Class) modelClass
                     APIPath:(NSString *)path
              cellIdentifier:(NSString *)cellIdentifier
          configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;
@end

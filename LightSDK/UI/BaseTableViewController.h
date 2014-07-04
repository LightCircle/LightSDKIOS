//
//  BaseTableViewController.h
//  ShotEyesiPAD
//
//  Created by kita on 14-5-19.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewModel+TableDateSource.h"

@interface BaseTableViewController : UITableViewController
@property BaseListViewModel *viewModel;
@end

//
//  BaseTableViewController.m
//  ShotEyesiPAD
//
//  Created by kita on 14-5-19.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import "BaseTableViewController.h"
#import <libextobjc/EXTScope.h>

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self.viewModel;

    self.refreshControl = [[UIRefreshControl alloc]init];
    
    @weakify(self);
    [RACObserve(self.viewModel,list) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self);
        [[[self.viewModel reloadSignal] finally:^{
            [self.refreshControl endRefreshing];
        }] subscribeCompleted:^{
            
        }];
    }];
    
    // TODO loadMore
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

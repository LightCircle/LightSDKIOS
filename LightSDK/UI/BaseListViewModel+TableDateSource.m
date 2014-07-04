//
//  BaseListViewModel+TableDateSource.m
//  ShotEyesiPAD
//
//  Created by kita on 14-5-19.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import "BaseListViewModel+TableDateSource.h"
#import <objc/runtime.h>
@interface BaseListViewModel()

@end

static const void *CellIdentifierKey = &CellIdentifierKey;
static const void *ConfigureCellBlockKey = &ConfigureCellBlockKey;

@implementation BaseListViewModel (TableDateSource)


- (id)initWithViewModelClass:(Class) modelClass
                     APIPath:(NSString *)path
              cellIdentifier:(NSString *)cellIdentifier
          configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    self = [self initWithViewModelClass:modelClass APIPath:path];
    self.cellIdentifier = cellIdentifier;
    self.configureCellBlock = configureCellBlock;
    
    return self;
}

-(NSString *)cellIdentifier
{
    return objc_getAssociatedObject(self, CellIdentifierKey);
}

-(void)setCellIdentifier:(NSString *)cellIdentifier
{
    objc_setAssociatedObject(self, CellIdentifierKey, cellIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TableViewCellConfigureBlock)configureCellBlock
{
    return objc_getAssociatedObject(self, ConfigureCellBlockKey);
}

-(void)setConfigureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    objc_setAssociatedObject(self, ConfigureCellBlockKey, configureCellBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.list[(NSUInteger) indexPath.row];
}
#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.list count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}
@end

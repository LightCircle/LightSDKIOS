//
//  BaseListViewModel.h
//  ShotEyesiPAD
//
//  Created by kita on 14-5-13.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface BaseListViewModel : NSObject
@property NSArray *list;
@property int start;
@property int limit;
@property NSString *APIPath;
@property Class modelClass;
@property NSDictionary *listCondition;

- (id)initWithViewModelClass:(Class)modelClass
                     APIPath:(NSString *)path;

- (RACSignal *)reloadSignal;

- (RACSignal *)loadMoreSignal;

- (RACSignal *)loadSignal;
@end

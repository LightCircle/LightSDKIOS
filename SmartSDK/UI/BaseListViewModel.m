//
//  BaseListViewModel.m
//  ShotEyesiPAD
//
//  Created by kita on 14-5-13.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import "BaseListViewModel.h"
#import <SmartSDK/RestHTTPRequestManager.h>
#import <Underscore.h>
#import "DAEntity.h"
#import <RestHelper.h>


typedef id(^RACSignalErrorBlock)(NSError *);

@implementation BaseListViewModel


- (id)initWithViewModelClass:(Class)modelClass
                     APIPath:(NSString *)path {
    self = [super init];
    self.APIPath = path;
    self.modelClass = modelClass;
    self.start = 0;
    self.limit = 20;
    self.list = [[NSArray alloc] init];

    [[self reloadSignal] subscribeCompleted:^{

    }];

    return self;

}

- (RACSignalErrorBlock)errorBlock {
    return ^(NSError *error) {
        NSLog(@"%@", error);
        return [RACSignal empty];
    };
}


- (RACSignal *)reloadSignal {
    self.start = 0;
    return [self loadSignal];
}

- (RACSignal *)loadMoreSignal {
    self.start += self.limit;
    return [self loadSignal];
}


- (RACSignal *)loadSignal {
    if (_listCondition == nil) {
        _listCondition = [[NSDictionary alloc] init];
    }

    NSDictionary *params = Underscore.extend(_listCondition, @{@"start" : [NSNumber numberWithInt:self.start], @"limit" : [NSNumber numberWithInt:self.limit]});
    RACSignal *sig = [[[RestHTTPRequestManager sharedManager] getPath:self.APIPath parameters:params] map:^id(id result) {

        NSArray *tmp = [self.modelClass multiObjectFromArray:[result valueForKeyPath:@"data.items"]];
        if (self.start == 0) {
            self.list = [NSArray arrayWithArray:tmp];
        } else {
            self.list = [self.list arrayByAddingObjectsFromArray:tmp];
        }
        return result;
    }];
    return [sig catch:self.errorBlock];
    
    
//    if ([RestHelper hasLoginSession] ) {
//        return [sig catch:self.errorBlock];
//    } else {
//        RestHelper *helper = [RestHelper sharedInstance];
//        return [[[[helper authorizeWithUrl:@"/login"] catch:self.errorBlock] concat:sig] catch:self.errorBlock];
//    }

}

@end

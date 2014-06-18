//
//  RestHelper.h
//  RestApi
//
//  Created by kita on 14-5-8.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RestHelper : NSObject
+ (RestHelper *)sharedInstance;

+ (BOOL)hasLoginSession;

+ (NSString *)getServerAddress;

+ (NSString *)getServerHost;

- (RACSignal *)authorizeInView:(UIView *)view;

- (RACSignal *)authorizeWithUrl:(NSString *)path;
@end

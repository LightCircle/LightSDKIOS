//
//  RestHTTPRequestManager.m
//  RestApi
//
//  Created by kita on 14-5-12.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import "RestHTTPRequestManager.h"
#import "RestHelper.h"

@implementation RestHTTPRequestManager
+(RestHTTPRequestManager *)sharedManager
{
    static RestHTTPRequestManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[RestHTTPRequestManager alloc] initWithBaseURL:[NSURL URLWithString:[RestHelper getServerAddress]]];
    });
    
    return _sharedManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

- (RACSignal *)getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return [self rac_GET:path parameters:parameters];
}

- (RACSignal *)fethImage:(NSString *)path parameters:(NSDictionary *)parameters
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFImageResponseSerializer serializer];
    return [self rac_GET:path parameters:parameters];
}

- (RACSignal *)postPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return [self rac_POST:path parameters:parameters];
}

- (RACSignal *)putPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return [self rac_PUT:path parameters:parameters];
}

- (RACSignal *)deletePath:(NSString *)path parameters:(NSDictionary *)parameters
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return [self rac_DELETE:path parameters:parameters];
}



@end

//
//  DALoggerAFNetwork.m
//  ShotEyes
//
//  Created by 罗浩 on 14-5-12.
//  Copyright (c) 2014年 DreamArts. All rights reserved.
//

#import "DALoggerAFNetwork.h"
#import "AFURLConnectionOperation.h"
#import "AFURLSessionManager.h"
#import <objc/runtime.h>
#import "DALogger.h"

static int ddLogLevel;

@implementation DALoggerAFNetwork

+ (instancetype)sharedLogger {
    static DALoggerAFNetwork *_sharedLogger = nil;
    ddLogLevel = [DALogger currentLevel];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLogger = [[self alloc] init];
    });

    return _sharedLogger;
}

- (void)startLogging {
    [self stopLogging];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidStart:) name:AFNetworkingOperationDidStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingOperationDidFinishNotification object:nil];

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidStart:) name:AFNetworkingTaskDidResumeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
#endif
}

- (void)stopLogging {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

static void *AFNetworkRequestStartDate = &AFNetworkRequestStartDate;

- (void)networkRequestDidStart:(NSNotification *)notification {
    NSURLRequest *request = AFNetworkRequestFromNotification(notification);

    if (!request) {
        return;
    }

    if (request && self.filterPredicate && [self.filterPredicate evaluateWithObject:request]) {
        return;
    }

    objc_setAssociatedObject(notification.object, AFNetworkRequestStartDate, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    NSString *body = nil;


    if ([DALogger matchLevel:LOG_FLAG_VERBOSE] || [DALogger matchLevel:LOG_FLAG_DEBUG]) {
        if ([request HTTPBody]) {
            body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
        }
        DDLogDebug(@"%@ '%@': %@ %@", [request HTTPMethod], [[request URL] absoluteString], [request allHTTPHeaderFields], body);
    } else if ([DALogger matchLevel:LOG_FLAG_INFO]) {
        DDLogInfo(@"%@ '%@'", [request HTTPMethod], [[request URL] absoluteString]);
    }

}

- (void)networkRequestDidFinish:(NSNotification *)notification {
    NSURLRequest *request = AFNetworkRequestFromNotification(notification);
    NSURLResponse *response = [notification.object response];
    NSError *error = [notification.object error];

    if (!request && !response) {
        return;
    }

    if (request && self.filterPredicate && [self.filterPredicate evaluateWithObject:request]) {
        return;
    }

    NSUInteger responseStatusCode = 0;
    NSDictionary *responseHeaderFields = nil;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseStatusCode = [(NSHTTPURLResponse *) response statusCode];
        responseHeaderFields = [(NSHTTPURLResponse *) response allHeaderFields];
    }

    NSString *responseString = nil;
    if ([[notification object] respondsToSelector:@selector(responseString)]) {
        responseString = [[notification object] responseString];
    }

    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(notification.object, AFNetworkRequestStartDate)];

    if (error) {
        if ([DALogger matchLevel:LOG_FLAG_WARN] || [DALogger matchLevel:LOG_FLAG_ERROR]) {
            DDLogError(@"[Error] %@ '%@' (%ld) [%.04f s]: %@", [request HTTPMethod], [[response URL] absoluteString], (long) responseStatusCode, elapsedTime, error);
        }
    } else {
        if ([DALogger matchLevel:LOG_FLAG_VERBOSE ]|| [DALogger matchLevel:LOG_FLAG_DEBUG]) {
            DDLogDebug(@"%ld '%@' [%.04f s]: %@ %@", (long) responseStatusCode, [[response URL] absoluteString], elapsedTime, responseHeaderFields, responseString);
        } else if ([DALogger matchLevel:LOG_FLAG_INFO]) {
            DDLogInfo(@"%ld '%@' [%.04f s]", (long) responseStatusCode, [[response URL] absoluteString], elapsedTime);
        }
    }
}

static NSURLRequest *AFNetworkRequestFromNotification(NSNotification *notification) {
    NSURLRequest *request = nil;
    if ([[notification object] isKindOfClass:[AFURLConnectionOperation class]]) {
        request = [(AFURLConnectionOperation *) [notification object] request];
    } else if ([[notification object] respondsToSelector:@selector(originalRequest)]) {
        request = [[notification object] originalRequest];
    }

    return request;
}

@end

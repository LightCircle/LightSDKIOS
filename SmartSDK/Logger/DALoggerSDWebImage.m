//
//  DALoggerAFNetwork.m
//  ShotEyes
//
//  Created by 罗浩 on 14-5-12.
//  Copyright (c) 2014年 DreamArts. All rights reserved.
//

#import "DALoggerSDWebImage.h"
#import <objc/runtime.h>
#import "DALogger.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageDownloaderOperation.h"

static int ddLogLevel;

@implementation DALoggerSDWebImage

+ (instancetype)sharedLogger {
    static DALoggerSDWebImage *_sharedLogger = nil;
    ddLogLevel = [DALogger currentLevel];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLogger = [[self alloc] init];
    });

    return _sharedLogger;
}

- (void)startLogging {
    [self stopLogging];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageDownloadDidStart:) name:SDWebImageDownloadStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageDownloadDidFinish:) name:SDWebImageDownloadStopNotification object:nil];

}

- (void)stopLogging {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)imageDownloadDidStart:(NSNotification *)notification {

    SDWebImageDownloaderOperation *obj = notification.object;
    if (obj.request && self.filterPredicate && [self.filterPredicate evaluateWithObject:obj.request]) {
        return;
    }
    if ([DALogger matchLevel:LOG_FLAG_VERBOSE] || [DALogger matchLevel:LOG_FLAG_DEBUG]) {
        DDLogDebug(@"%@ '%@': %@", [obj.request HTTPMethod], [[obj.request URL] absoluteString], [obj.request allHTTPHeaderFields]);
    } else if ([DALogger matchLevel:LOG_FLAG_INFO]) {
        DDLogInfo(@"%@ '%@'", [obj.request HTTPMethod], [[obj.request URL] absoluteString]);
    }

}

- (void)imageDownloadDidFinish:(NSNotification *)notification {
    return;
}


@end

//
//  DALogger.h
//  ShotEyes
//
//  Created by 罗浩 on 14-5-12.
//  Copyright (c) 2014年 DreamArts. All rights reserved.
//


//==========将下列代码添加到到 APPNAME-Prefix.pch 中==========
//    #import "DALogger.h"
//    #ifdef DEBUG
//        static const int ddLogLevel = LOG_LEVEL_VERBOSE;
//    #else
//        static const int ddLogLevel = LOG_LEVEL_WARN;
//    #endif
//=========================End============================

#import <Foundation/Foundation.h>
#import "DALoggerHeader.h"


@interface DALogger : NSObject

+ (void)initWithLoggerType:(DALoggerType)type logLevel:(int)level;

+ (BOOL)matchLevel:(int)level;

+ (int)currentLevel;
@end

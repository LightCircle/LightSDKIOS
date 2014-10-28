//
//  DALoggerHeader.h
//  ShotEyes
//
//  Created by 罗浩 on 14-5-12.
//

#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "ABLoggerFormatter.h"

/**
 * 改写 DDLog 的头文件,添加 OPERATION 这个 loglevel
 * 并添加 DDLogOPERATION 宏
 **/

#define LOG_FLAG_OPERATION   (1 << 5)  // 0...100000

#define LOG_LEVEL_OPERATION (LOG_FLAG_OPERATION)

#define LOG_OPERATION   (LOG_LEVEL_OFF | LOG_FLAG_OPERATION )

#define DDLogOperation(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(LOG_FLAG_OPERATION, LOG_FLAG_OPERATION,  0, frmt, ##__VA_ARGS__)
#define DDLogCOperation(frmt, ...)  ASYNC_LOG_C_MAYBE(LOG_FLAG_OPERATION, LOG_FLAG_OPERATION,  0, frmt, ##__VA_ARGS__)


typedef NS_ENUM(NSUInteger, ABLoggerType) {

    ABLogToNone = 0,
    
    //向系统日志写log
    ABLogToASL = 1 << 0,

    //向Xcode控制台写log
    ABLogToCLI = 1 << 1,

    //向文件写log
    ABLogToFile = 1 << 2,
};



//
//  DALogger.m
//  ShotEyes
//
//  Created by 罗浩 on 14-5-12.
//

#import "ABLogger.h"

static int DALOG_LEVEL;

@implementation ABLogger

+ (void)initWithLoggerType:(ABLoggerType)type logLevel:(int)level {

    DALOG_LEVEL = level;

    ABLoggerFormatter *formatter = [[ABLoggerFormatter alloc] init];

    if (type & ABLogToASL) {
        [DDTTYLogger sharedInstance].logFormatter = formatter;
        [DDLog addLogger:[DDASLLogger sharedInstance] withLogLevel:level | LOG_LEVEL_OPERATION];
    }
    if (type & ABLogToCLI) {
        [DDTTYLogger sharedInstance].logFormatter = formatter;
        [DDLog addLogger:[DDTTYLogger sharedInstance] withLogLevel:level | LOG_LEVEL_OPERATION];
    }
    if (type & ABLogToFile) {
        // init default logger
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"Logs"];
        DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc] initWithLogsDirectory:logsDirectory]];
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        fileLogger.logFormatter = [[ABLoggerFormatter alloc] init];
        [DDLog addLogger:fileLogger withLogLevel:LOG_LEVEL_VERBOSE];

        // init operation logger
        NSString *operationLogsDirectory = [baseDir stringByAppendingPathComponent:@"Operationlogs"];
        DDFileLogger *operationLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc] initWithLogsDirectory:operationLogsDirectory]];
        operationLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        operationLogger.logFileManager.maximumNumberOfLogFiles = 7;
        operationLogger.logFormatter = [[ABLoggerFormatter alloc] init];
        [DDLog addLogger:operationLogger withLogLevel:LOG_LEVEL_OPERATION];
    }

//    [[DALoggerAFNetwork sharedLogger] startLogging];
//    [[DALoggerSDWebImage sharedLogger] startLogging];
}

+ (BOOL)matchLevel:(int)level {
    return (level & DALOG_LEVEL) == level;
}

+ (int)currentLevel {
    return DALOG_LEVEL;
}

@end

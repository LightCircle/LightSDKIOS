//
//  DALoggerFormatter.m
//  ShotEyes
//
//  Created by 罗浩 on 14-5-12.
//

#import "ABLoggerFormatter.h"

@implementation ABLoggerFormatter
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *timestamp = [self stringFromDate:(logMessage->timestamp)];
    NSString *queueThreadLabel = [self queueThreadLabelForLogMessage:logMessage];

    NSString *logLevel;
    switch (logMessage->logFlag) {
        case LOG_FLAG_ERROR   :
            logLevel = @"E";
            break;
        case LOG_FLAG_WARN    :
            logLevel = @"W";
            break;
        case LOG_FLAG_INFO    :
            logLevel = @"I";
            break;
        case LOG_FLAG_DEBUG   :
            logLevel = @"D";
            break;
        case LOG_FLAG_VERBOSE :
            logLevel = @"V";
            break;
        default               :
            logLevel = @"O";
            break; //LOG_FLAG_OPERATION
    }

    return [NSString stringWithFormat:@"[%@] %@ [%@] %@", logLevel, timestamp, queueThreadLabel, logMessage->logMsg];
}
@end

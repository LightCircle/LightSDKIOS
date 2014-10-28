//
//  ABHelper.m
//  ChainStore
//
//  Created by LI LIN on 14-9-17.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import "ABHelper.h"
#import "ABDefine.h"
#import "ABConfigManager.h"

@implementation ABHelper

+ (void)initialize {
    [ABConfigManager initWithPlistFile:nil];
}

+ (void)showError:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"错误"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}

+ (void)showInfo:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@""
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}

+ (void)showConfirm:(NSString *)message delegate:(id)delegate {
    [[[UIAlertView alloc] initWithTitle:@""
                                message:message
                               delegate:delegate
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"OK", nil] show];
}


+ (NSString *)url:(NSString *)path params:(NSString *)params {
    // TODO: get from define
    NSString *host = [ABConfigManager.defaults objectForKey:kConfigManagerServerName];
    NSString *port = [ABConfigManager.defaults objectForKey:kConfigManagerServerPort];

    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@", host, port, path];
    if (params) {
        url = [NSString stringWithFormat:@"http://%@:%@%@?%@", host, port, path, params];
    }

    return url;
}

+ (NSString *)urlWithToken:(NSString *)path params:(NSString *)params {
    // TODO: get from define
    NSString *host = [ABConfigManager.defaults objectForKey:kConfigManagerServerName];
    NSString *port = [ABConfigManager.defaults objectForKey:kConfigManagerServerPort];
    NSString *token = [ABHelper encode:[ABConfigManager.defaults objectForKey:kConfigManagerCsrfToken]];

    NSString *url = [NSString stringWithFormat:@"http://%@:%@%@?_csrf=%@", host, port, path, token];
    if (params) {
        url = [[url stringByAppendingString:@"&"] stringByAppendingString:params];
    }

    return url;
}

+ (NSString *)encode:(NSString *)string {
    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
            (__bridge CFStringRef) string,
            NULL,
            (CFStringRef) @"!*'();:@&=+$,./?%#[]",
            kCFStringEncodingUTF8);
}

+ (NSDate *)dateFromISODateString:(NSString *)isodate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"];
    return [dateFormatter dateFromString:isodate];
}

+ (NSString *)stringFromISODate:(NSDate *)isodate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd HH:mm"];
    return [format stringFromDate:isodate];
}

+ (NSString *)stringFromISODateString:(NSString *)isodate {
    NSDate *date = [ABHelper dateFromISODateString:isodate];
    return [ABHelper stringFromISODate:date];
}

+ (NSDate *)dateFromString:(NSString *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:date];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringFromDateString:(NSString *)date out:(NSString *)out in:(NSString *)in
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:in];
    
    return [ABHelper stringFromDate:[dateFormatter dateFromString:date] format:out];
}

+ (NSDate *)dateWithOutTime:(NSDate *)date
{
    if( date == nil ) {
        date = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (void)setTextViewBorder:(UITextView *)textView {
    [textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [textView.layer setBorderWidth:0.5];
//    textView.layer.cornerRadius = 5;
    textView.clipsToBounds = YES;
}

@end

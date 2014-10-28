//
//  ABHelper.h
//  ChainStore
//
//  Created by LI LIN on 14-9-17.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Template;

@interface ABHelper : NSObject

+ (void)initialize;

+ (void)showError:(NSString *)message;

+ (void)showInfo:(NSString *)message;

+ (void)showConfirm:(NSString *)message delegate:(id)delegate;

+ (NSString *)url:(NSString *)path params:(NSString *)params;

+ (NSString *)urlWithToken:(NSString *)path params:(NSString *)params;

+ (NSString *)encode:(NSString *)string;

+ (void)setTextViewBorder:(UITextView *)textView;

#pragma mark - 日期 相关

+ (NSDate *)dateFromISODateString:(NSString *)isodate;

+ (NSString *)stringFromISODate:(NSDate *)isodate;

+ (NSString *)stringFromISODateString:(NSString *)isodate;

+ (NSDate *)dateFromString:(NSString *)date format:(NSString *)format;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

+ (NSString *)stringFromDateString:(NSString *)date out:(NSString *)out in:(NSString *)in;

+ (NSDate *)dateWithOutTime:(NSDate *)date;

@end

//
//  NSString+DAUtil.h
//  Pods
//
//  Created by 罗浩 on 14-5-13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (ABUtil)

// 文字列がnilまたは空文字か
+ (BOOL)isEmpty:(NSString *)str;

// 文字列がnil・空文字でない
+ (BOOL)isNotEmpty:(NSString *)str;

- (NSDate *)toDate;

@end

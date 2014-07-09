//
//  DAConfigManager.h
//  ShotEyes
//
//  Created by 罗浩 on 14-5-15.
//

#import <Foundation/Foundation.h>

@interface DAConfigManager : NSUserDefaults


/*
 *等同于[NSUserDefaults standardUserDefaults]
 */
+ (NSUserDefaults *)defaults;


/*
 *将指定plist中的值存入 NSUserDefaults.
 *如果 path 为 nil,则存入 APPNAME-Info.plist 中的值
 */
+ (void)initWithPlistFile:(NSString *)path;
@end

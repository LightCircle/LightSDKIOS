//
//  DAConfigManager.m
//  ShotEyes
//
//  Created by 罗浩 on 14-5-15.
//  Copyright (c) 2014年 DreamArts. All rights reserved.
//

#import "DAConfigManager.h"

@implementation DAConfigManager

+ (NSUserDefaults *)defaults{
   return [self standardUserDefaults];
}

+ (void)initWithPlistFile:(NSString *)path{
    NSDictionary *data;
    if(path){
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:path ofType:@"plist"];
        data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }else{
        data = [[NSBundle mainBundle] infoDictionary];
    }
    
    NSMutableDictionary *filtered = [[NSMutableDictionary alloc]init];
    for (NSString *key in [data allKeys]) {
        if([data[key] isKindOfClass:[NSString class]]
           ||[data[key] isKindOfClass:[NSArray class]]
           ||[data[key] isKindOfClass:[NSDictionary class]]
           ||[data[key] isKindOfClass:[NSNumber class]]
           )
           
        [filtered setObject:data[key] forKey:key];
    }
    
    [[self standardUserDefaults] registerDefaults:filtered];
}
@end

//
//  ABStorable.m
//
//  Created by 罗浩 on 14-5-13.
//
//

#import "ABStorable.h"
#import "ABLogger.h"
#import "NSString+ABUtil.h"

static int ddLogLevel;

@implementation ABStorable

+ (instancetype)sharedManager {
    static ABStorable *_sharedManager = nil;
    ddLogLevel = [ABLogger currentLevel];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] initWithCacher:[[NSCache alloc] init]];
    });
    return _sharedManager;
}

- (id)loadByKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }
    NSObject *cacheData = [_cacher objectForKey:key];

    if (cacheData) {
        DDLogDebug(@"get obj form cache by key: %@", key);
        return cacheData;
    } else {
        
        NSString *path = [self filePathByKey:key];
        NSObject *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(data){
            [_cacher setObject:data forKey:key];
            DDLogDebug(@"get obj form file: %@", path);
            return data;
        }else{
            DDLogDebug(@"can not get obj by key:[%@]",key);
            return nil;
        }
    }
}

+ (id)loadByKey:(NSString *)key {
    return [[self sharedManager] loadByKey:key];
}

- (BOOL)store:(id)obj withKey:(NSString *)key {
    [_cacher setObject:obj forKey:key];
    if ([NSString isEmpty:self.storeDir]) {
        self.storeDir = [self defaultDir];
        DDLogDebug(@"use default store location:%@", self.storeDir);
    }
    return [NSKeyedArchiver archiveRootObject:obj toFile:[self filePathByKey:key]];
}

+ (BOOL)store:(id)obj withKey:(NSString *)key {
    return [[self sharedManager] store:obj withKey:key];
}


- (void)deleteByKey:(NSString *)key{
    [_cacher removeObjectForKey:key];
    NSString *path = [self filePathByKey:key];
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}
+ (void)deleteByKey:(NSString *)key{
    [[self sharedManager] deleteByKey:key];
}

- (instancetype)initWithCacher:(NSCache *)cacher {
    if ((self = [super init])) {
        _cacher = cacher;
    }
    return self;
}

- (NSString *)defaultDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:@"Store"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"error create dir [%@] ,error:%@", sContentsDir, [error description]);
        }
    }
    return sContentsDir;
}

- (NSString *)filePathByKey:(NSString*)key{
    if ([NSString isEmpty:self.storeDir]) {
        self.storeDir = [self defaultDir];
        DDLogDebug(@"use default store location:%@", self.storeDir);
    }
    NSCharacterSet *illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [self.storeDir stringByAppendingPathComponent:
                          [[key componentsSeparatedByCharactersInSet
                            :illegalFileNameCharacters] componentsJoinedByString:@""]];
    
}
@end

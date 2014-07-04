//
//  DAStorable.h
//
//  Created by 罗浩 on 14-5-13.
//
//

#import <Foundation/Foundation.h>

@interface DAStorable : NSObject {
    NSCache *_cacher;
}

/**
 init with NSCache
 */
- (instancetype)initWithCacher:(NSCache *)cacher;

/**
 Returns the shared storable instance.
 */
+ (instancetype)sharedManager;

/**
 从存储获取对象
 */

- (id)loadByKey:(NSString *)key;
+ (id)loadByKey:(NSString *)key;
/**
 存储对象
 */
- (BOOL)store:(id)obj withKey:(NSString *)key;
+ (BOOL)store:(id)obj withKey:(NSString *)key;

/**
 删除存储的对象
 */
- (void)deleteByKey:(NSString *)key;
+ (void)deleteByKey:(NSString *)key;
/**
 存储文件的路径
 */
@property(nonatomic, strong) NSString *storeDir;


@end

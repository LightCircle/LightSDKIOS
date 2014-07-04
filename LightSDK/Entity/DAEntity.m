#import "DAEntity.h"

@implementation DAEntity

- (NSArray *) multiInitWithArray:(NSArray *)array{
    
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:[array count]];
    for (NSDictionary *dic in array) {
        [result addObject:[[self.class alloc] initWithDictionary: dic]];
    }
    return result;
}

+ (NSArray *) multiObjectFromArray:(NSArray *)array{
    return [[self alloc] multiInitWithArray:array];
}
@end
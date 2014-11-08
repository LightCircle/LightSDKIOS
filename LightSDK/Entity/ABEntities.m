
#import "ABEntities.h"

@implementation LightModel
@end

@implementation User
@end

@implementation UserList
@end

@implementation Tag
@end

@implementation TagList
@end

@implementation Options
@end

@implementation Device
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description": @"description_"}];
}
@end

@implementation DeviceList
@end

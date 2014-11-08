#import <JSONModel.h>
#import "ABHelper.h"

@implementation JSONValueTransformer (CustomTransformer)
- (NSDate *)NSDateFromNSString:(NSString *)string {
    return [ABHelper dateFromISODateString:string];
}
@end


@interface LightModel : JSONModel
@property(retain, nonatomic) NSString       <Optional> *_id;
@property(retain, nonatomic) NSDate         <Optional> *createAt;
@property(retain, nonatomic) NSString       <Optional> *createBy;
@property(retain, nonatomic) NSDate         <Optional> *updateAt;
@property(retain, nonatomic) NSString       <Optional> *updateBy;
@property(retain, nonatomic) NSNumber       <Optional> *valid;
@end


@protocol User
@end
@interface User : LightModel
@property(retain, nonatomic) NSString       *id;
@property(retain, nonatomic) NSString       *name;
@property(retain, nonatomic) NSString       *type;
@property(retain, nonatomic) NSString       <Optional> *outer;
@property(retain, nonatomic) NSString       <Optional> *password;
@property(retain, nonatomic) NSArray        <Optional> *groups;
@property(retain, nonatomic) NSArray        <Optional> *roles;
@property(retain, nonatomic) NSString       <Optional> *email;
@property(retain, nonatomic) NSString       <Optional> *lang;
@property(retain, nonatomic) NSString       <Optional> *timezone;
@property(retain, nonatomic) NSString       <Optional> *status;
@property(retain, nonatomic) NSDictionary   <Optional> *extend;
@end
@interface UserList : JSONModel
@property(retain, nonatomic) NSArray        <User> *items;
@end


@protocol Tag
@end
@interface Tag : LightModel
@property(retain, nonatomic) NSString       *type;
@property(retain, nonatomic) NSString       *name;
@property(retain, nonatomic) NSString       *counter;
@end
@interface TagList : JSONModel
@property(retain, nonatomic) NSArray        <Tag> *items;
@end


@protocol Options
@end
@interface Options : JSONModel
@property(retain, nonatomic) NSDictionary   <Optional> *category;
@property(retain, nonatomic) NSDictionary   <Optional> *group;
@property(retain, nonatomic) NSDictionary   <Optional> *user;
@property(retain, nonatomic) NSDictionary   <Optional> *file;
@end


@protocol Device
@end
@interface Device : LightModel
@property(retain, nonatomic) NSString       *token;
@property(retain, nonatomic) NSString       <Optional> *qrcode;
@property(retain, nonatomic) NSString       <Optional> *identifier;
@property(retain, nonatomic) NSString       <Optional> *type;
@property(retain, nonatomic) NSString       <Optional> *user;
@property(retain, nonatomic) NSDate         <Optional> *active;
@property(retain, nonatomic) NSString       <Optional> *status;
@property(retain, nonatomic) NSString       <Optional> *description_;
@property(retain, nonatomic) NSDictionary   <Optional> *extend;
@end
@interface DeviceList : JSONModel
@property(retain, nonatomic) NSArray        <Device> *items;
@end

//
//  DALoggerAFNetwork.h
//  ShotEyes
//
//  Created by 罗浩 on 14-5-19.
//

#import <Foundation/Foundation.h>

@interface DALoggerSDWebImage : NSObject

/**
 Only log requests conforming to the specified predicate, if specified. `nil` by default.
 
 @discussion Each notification has an associated `NSURLRequest`. To filter out request and response logging, such as all network activity made to a particular domain, this predicate can be set to match against the appropriate URL string pattern.
 */
@property(nonatomic, strong) NSPredicate *filterPredicate;

/**
 Returns the shared logger instance.
 */
+ (instancetype)sharedLogger;

/**
 Start logging requests and responses.
 */
- (void)startLogging;

/**
 Stop logging requests and responses.
 */
- (void)stopLogging;

@end
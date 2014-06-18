//
//  DAWebSocket.m
//  ShotEyes
//
//  Created by 罗浩 on 14-5-15.
//  Copyright (c) 2014年 DreamArts. All rights reserved.
//

#import "DAWebSocket.h"
#import "DALogger.h"

static int ddLogLevel;

@interface DAWebSocket ()
@property (retain,nonatomic) SRWebSocket *socketer;
@end

@implementation DAWebSocket

+ (instancetype)sharedManager {
    static DAWebSocket *_sharedManager = nil;
    ddLogLevel = [DALogger currentLevel];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

// Open it with this
- (void)open{
    
    self.socketer.delegate = nil;
    self.socketer = nil;
    
    NSString *urlString = @"ws://10.2.3.39:8080";
    SRWebSocket *newWebSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    self.socketer = newWebSocket;
    self.socketer.delegate = self;
    
    [self.socketer open];
}

// Close it with this
- (void)close{
    [self.socketer close];
    self.socketer.delegate = nil;
    self.socketer = nil;
    
}

// Send a UTF8 String or Data
- (void)send:(id)data{
    [self.socketer send:data];
}


// Open it with this
+ (void)open{
    [[self sharedManager] open];
}

// Close it with this
+ (void)close{
    [[self sharedManager] close];
}

// Send a UTF8 String or Data
+ (void)send:(id)data{
    [[self sharedManager]send:data];
}

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    DDLogInfo(@"socket io opened.");
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:nfSocketConnOpened object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    DDLogInfo(@"socket io error.");
    
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:nfSocketErrorOccured object:error];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
    
    [self open];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    DDLogInfo(@"socket io closed.");
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:nfSocketConnClosed object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:nfSocketMsgReceived object:message];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}
@end

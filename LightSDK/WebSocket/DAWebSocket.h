//
//  DAWebSocket.h
//  ShotEyes
//
//  Created by 罗浩 on 14-5-15.
//  Copyright (c) 2014年 DreamArts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"

#define nfSocketConnOpened    @"nf_socketio_conn_opened"
#define nfSocketErrorOccured  @"nf_socketio_error_occured"
#define nfSocketConnClosed    @"nf_socketio_conn_closed"
#define nfSocketMsgReceived   @"nf_socketio_msg_received"

@interface DAWebSocket : NSObject<SRWebSocketDelegate>

/**
 Returns the websocket manager instance.
 */
+ (instancetype)sharedManager;

// Open it with this
- (void)open;

// Close it with this
- (void)close;

// Send a UTF8 String or Data
- (void)send:(id)data;

// Open it with this
+ (void)open;

// Close it with this
+ (void)close;

// Send a UTF8 String or Data
+ (void)send:(id)data;

@end

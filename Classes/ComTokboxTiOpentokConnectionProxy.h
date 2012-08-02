/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <Opentok/OTConnection.h>

@interface ComTokboxTiOpentokConnectionProxy : TiProxy {

@private
    OTConnection *_connection;    
}

- (id)initWithConnection:(OTConnection *)existingConnection;

// Properties
@property (readonly) NSString *connectionId;
@property (readonly) NSDate *creationTime;

@end

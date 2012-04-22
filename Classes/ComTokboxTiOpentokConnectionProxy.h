/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
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

/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokConnectionProxy.h"
#import <Opentok/OTConnection.h>

@implementation ComTokboxTiOpentokConnectionProxy

#pragma mark - Initialization

// This is NOT meant to be called from javascript land, only for native code use.
// TODO: store weak reference to session proxy?
- (id)initWithConnection:(OTConnection *)existingConnection {
    
    self = [super init];
    if (self) {
        // Initializations
        _connection = [existingConnection retain];
    }
    
    return self;
}

// Overriding designated initializer in order to prevent instantiation from javascript land (hopefully)
- (id)init {
    return nil;
}

#pragma mark - Deallocation

- (void)dealloc {
    [_connection release];
    
    [super dealloc];
}

#pragma mark - Properties

-(id)connectionId
{
    return _connection.connectionId;
}

-(id)creationTime
{
    return _connection.creationTime;
}

@end

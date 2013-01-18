//
//  ComTokboxTiOpentokStreamProxy.m
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/21/12.
//  Copyright (c) 2012 TokBox, Inc.
//  Please see the LICENSE included with this distribution for details.
//

#import "TiUtils.h"
#import "ComTokboxTiOpentokStreamProxy.h"
#import "ComTokboxTiOpentokSessionProxy.h"
#import "ComTokboxTiOpentokConnectionProxy.h"
#import <Opentok/OTStream.h>

@implementation ComTokboxTiOpentokStreamProxy

#pragma mark - Helpers

- (void)requireStreamInitializationWithLocation:(NSString *)codeLocation andMessage:(NSString *)message {
    if (_stream == nil) {
        [self throwException:TiExceptionInternalInconsistency 
                   subreason:message
                    location:codeLocation];
    }
}

- (void)requireStreamInitializationWithLocation:(NSString *)codeLocation {
    [self requireStreamInitializationWithLocation:codeLocation andMessage:@"This stream was not properly initialized"];
}

#pragma mark - Initialization

// This is NOT meant to be called from javascript land, only for native code use.
- (id)initWithStream:(OTStream *)existingStream sessionProxy:(ComTokboxTiOpentokSessionProxy *)sessionProxy{
    
    self = [super init];
    if (self) {
        // Initializations
        _stream = [existingStream retain];
        _connectionProxy = nil;
        
        // Not retained, weak reference, be careful
        _sessionProxy = sessionProxy;
    }
    
    return self;
}

// Overriding designated initializer in order to prevent instantiation from javascript land (hopefully)
- (id)init {
    return nil;
}

#pragma mark - Deallocation

- (void)dealloc {
    [_stream release];
    [_connectionProxy release];
    
    [super dealloc];
}

#pragma mark - Properties

- (ComTokboxTiOpentokConnectionProxy *)connection
{
    if (_connectionProxy == nil) {
        _connectionProxy = [[ComTokboxTiOpentokConnectionProxy alloc] initWithConnection:_stream.connection];
    }
    return _connectionProxy;
}

- (id)creationTime {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.creationTime;
}

- (id)hasAudio {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return NUMBOOL(_stream.hasAudio);
}

- (NSNumber *)hasVideo {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return NUMBOOL(_stream.hasVideo);
}

- (NSString *)name {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.name;
}

- (ComTokboxTiOpentokSessionProxy *)session {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    // TODO: debug this, could be returning a dangling pointer if the session proxy can go away.
    return _sessionProxy;
}

- (NSString *)streamId {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.streamId;
}

- (NSString *)type {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.type;
}

#pragma mark - Opentok Object Proxy

- (id) backingOpentokObject
{
    return _stream;
}

@end

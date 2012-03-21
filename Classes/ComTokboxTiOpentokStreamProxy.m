//
//  ComTokboxTiOpentokStreamProxy.m
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiUtils.h"
#import "ComTokboxTiOpentokStreamProxy.h"
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
- (id)initWithStream:(OTStream *)existingStream {
    NSLog(@"Thread: %@", [[NSThread currentThread] name]);
    NSLog(@"Stream Proxy is about to call super init.");
    
    self = [super init];
    if (self) {
        // Initializations
        _stream = [existingStream retain];
    }
    
    NSLog(@"Thread: %@", [[NSThread currentThread] name]);
    NSLog(@"Stream Proxy created: %@", self.streamId);
    
    return self;
}

// Overriding designated initializer in order to prevent instantiation from javascript land (hopefully)
- (id)init {
    return nil;
}

#pragma mark - Deallocation

- (void)dealloc {
    [_stream release];
    
    [super dealloc];
}

#pragma mark - Properties

// TODO: implement this with another proxy object
//@property (nonatomic, readonly, assign)  *connection;

- (NSDate *)creationTime {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.creationTime;
}

- (NSNumber *)hasAudio {
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
    
    // TODO: any idea how to get a reference to the existing proxy object?
    // possibly need to do some caching of object when they are initialized, perform a look up
    return nil;
}

- (NSString *)streamId {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.streamId;
}

- (NSString *)type {
    [self requireStreamInitializationWithLocation:CODELOCATION];
    
    return _stream.type;
}

@end

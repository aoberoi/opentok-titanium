//
//  ComTokboxTiOpentokSessionProxy.m
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComTokboxTiOpentokSessionProxy.h"
#import "TiUtils.h"

@implementation ComTokboxTiOpentokSessionProxy

#pragma mark - Helpers

- (void)requireSessionInitializationWithLocation:(NSString *)codeLocation andMessage:(NSString *)message {
    if (_session == nil) {
        [self throwException:TiExceptionInternalInconsistency 
                   subreason:message
                    location:codeLocation];
    }
}

- (void)requireSessionInitializationWithLocation:(NSString *)codeLocation {
    [self requireSessionInitializationWithLocation:codeLocation andMessage:@"This session was not properly initialized"];
}

#pragma mark - Initialization


- (id)init {
    self = [super init];
    if (self) {
        // Initializations
        
        // We would normally alloc/init the backing session here, but since we can't yet access its
        // sessionId we will delay initialization of _session until that property is set.
        _session = nil;
    }
    return self;
}

#pragma mark - Deallocation

- (void)dealloc {
    [_session release];
    
    [super dealloc];
}

#pragma mark - Public Properties

- (void)setSessionId:(NSString *)sessionId {
    // We cannot change the session id once a session has been created, go allocate a new one if needed
    if (_session == nil) {
        NSString *stringSessionId = [TiUtils stringValue:sessionId];
        
        // Lazy initialization of backing session
        _session = [[OTSession alloc] initWithSessionId:stringSessionId delegate:self];
        
        // Manage dynprops for Titanium
        [self replaceValue:stringSessionId forKey:@"sessionId" notification:NO];
    } else {
        // Throw error
        // TODO: no idea if this actually works, exception handling isn't documented well for titanium.
        // http://developer.appcelerator.com/question/130582/how-to-catch-errors
        
        [self throwException:TiExceptionInternalInconsistency 
                   subreason:@"Once a Session has been given a sessionId, it cannot be changed." 
                    location:CODELOCATION];
    }
}

- (NSString *)sessionId {
    return [self valueForKey:@"sessionId"];
}

#pragma mark - Public Methods

- (void)connect:(id)args {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    // Validate arguments
    NSArray *argumentArray = (NSArray *)args;
    NSString *apiKey = [TiUtils stringValue:[argumentArray objectAtIndex:0]];
    NSString *token = [TiUtils stringValue:[argumentArray objectAtIndex:1]];
    if (apiKey == nil || token == nil) THROW_INVALID_ARG(@"Must call this method with a valid string 'apiKey' and string 'token'.");
    
    // Call method on backing session
    [_session connectWithApiKey:apiKey token:token];
    
}

#pragma mark - Session Delegate Protocol

- (void)sessionDidConnect:(OTSession*)session {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    if ([self _hasListeners:@"sessionConnected"]) {
        [self fireEvent:@"sessionConnected"];
    }
}


- (void)sessionDidDisconnect:(OTSession*)session {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    if ([self _hasListeners:@"sessionDisconnected"]) {
        [self fireEvent:@"sessionDisconnected"];
    }
}


- (void)session:(OTSession*)session didFailWithError:(OTError*)error {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    // TODO: convert OTError into a dictonary that can be passed as event parameter
    // Can this map to some known error object in the javascript world?
    
    if ([self _hasListeners:@"sessionFailed"]) {
        [self fireEvent:@"sessionFailed" withObject:nil];
    }
}


- (void)session:(OTSession*)session didReceiveStream:(OTStream*)stream {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    // TODO: create a stream proxy object, initialze an instance here, use it
    NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:nil forKey:@"stream"];
    
    if ([self _hasListeners:@"streamCreated"]) {
        [self fireEvent:@"streamCreated" withObject:eventParameters];
    }
}


- (void)session:(OTSession*)session didDropStream:(OTStream*)stream {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    // TODO: create a stream proxy object, initialze an instance here, use it
    NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:nil forKey:@"stream"];
    
    if ([self _hasListeners:@"streamDestroyed"]) {
        [self fireEvent:@"streamDestroyed" withObject:eventParameters];
    }
}


@end

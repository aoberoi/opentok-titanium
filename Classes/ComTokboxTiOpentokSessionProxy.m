//
//  ComTokboxTiOpentokSessionProxy.m
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComTokboxTiOpentokSessionProxy.h"
#import "ComTokboxTiOpentokStreamProxy.h"
#import "TiUtils.h"
#import <Opentok/OTError.h>

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

// TODO: Localization
+ (NSDictionary *)dictionaryForOTError:(OTError *)error {
    NSString *message;
    switch ([error code]) {
        case OTAuthorizationFailure:
            message = @"An invalid API key or token was provided";
            break;
            
        case OTInvalidSessionId:
            message = @"An invalid session ID was provided";
            break;
        
        case OTConnectionFailed:
            message = @"There was an error connecting to OpenTok services";
            break;
            
        case OTNoMessagingServer:
            message = @"No messaging server is available for this session";
            break;
        
        default:
            message = @"An unknown error occurred";
            break;
    }
    
    return [NSDictionary dictionaryWithObject:message forKey:@"message"];
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

- (NSArray *)streams {
    NSLog(@"Thread: %@", [[NSThread currentThread] name]);
    NSLog(@"streams property of Session Proxy was accessed.");
    
    // Create an empty mutable array to hold the stream proxy objects
    NSMutableArray *streamsArray = [[NSMutableArray alloc] initWithCapacity:[_session.streams count]];
    
    // Iterate through streams in the _session.streams dictionary while creating a new stream proxy for each
    NSArray *allValues = [_session.streams allValues];
    for( id streamObj in allValues ) {
        NSLog(@"creating new proxy object... not");
//        ComTokboxTiOpentokStreamProxy *newStreamProxy = [[ComTokboxTiOpentokStreamProxy alloc] initWithStream:streamObj];
//        [streamsArray addObject:newStreamProxy];
//        [newStreamProxy release];
//        NSLog(@"finished creating new proxy object");
    }
    
    // TODO: Consider using dynprops to cache the array that is returned. In that case, instead of regenerating
    //       the array on each call, we can check for the cached version and avoid creating all these objects
    
    NSLog(@"Thread: %@", [[NSThread currentThread] name]);
    NSLog(@"streamsArray is about to be returned with count %d", [streamsArray count]);
    
    return [streamsArray autorelease];
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
    
    NSDictionary *errorObject = [ComTokboxTiOpentokSessionProxy dictionaryForOTError:error];
    NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:errorObject forKey:@"error"];
    
    if ([self _hasListeners:@"sessionFailed"]) {
        [self fireEvent:@"sessionFailed" withObject:eventParameters];
    }
}


- (void)session:(OTSession*)session didReceiveStream:(OTStream*)stream {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    if ([self _hasListeners:@"streamCreated"]) {
    
        // create a stream proxy object
        ComTokboxTiOpentokStreamProxy *streamProxy = [[ComTokboxTiOpentokStreamProxy alloc] initWithStream:stream];
        
        // put the stream proxy object in the event parameters
        NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:streamProxy forKey:@"stream"];
        [streamProxy release];
        
        // fire event
        [self fireEvent:@"streamCreated" withObject:eventParameters];
    }
}


- (void)session:(OTSession*)session didDropStream:(OTStream*)stream {
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    if ([self _hasListeners:@"streamDestroyed"]) {
    
        // create a stream proxy object
        ComTokboxTiOpentokStreamProxy *streamProxy = [[ComTokboxTiOpentokStreamProxy alloc] initWithStream:stream];
        
        // put the stream proxy object in the event parameters
        NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:nil forKey:@"stream"];
        [streamProxy release];
        
        // fire event
        [self fireEvent:@"streamDestroyed" withObject:eventParameters];
    }
}


@end

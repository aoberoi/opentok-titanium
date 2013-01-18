//
//  ComTokboxTiOpentokSessionProxy.m
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/19/12.
//  Copyright (c) 2012 TokBox, Inc.
//  Please see the LICENSE included with this distribution for details.
//

#import "ComTokboxTiOpentokSessionProxy.h"
#import "ComTokboxTiOpentokStreamProxy.h"
#import "ComTokboxTiOpentokConnectionProxy.h"
#import "ComTokboxTiOpentokPublisherProxy.h"
#import "ComTokboxTiOpentokSubscriberProxy.h"
#import "ComTokboxTiOpentokModule.h"
#import "TiUtils.h"
#import <Opentok/OTError.h>

NSString * const kSessionStatusConnected = @"connected";
NSString * const kSessionStatusConnecting = @"connecting";
NSString * const kSessionStatusDisconnected = @"disconnected";
NSString * const kSessionStatusFailed = @"failed";

@implementation ComTokboxTiOpentokSessionProxy

#pragma mark - Helpers

- (void)requireSessionInitializationWithLocation:(NSString *)codeLocation andMessage:(NSString *)message
{
    if (_session == nil) {
        [self throwException:TiExceptionInternalInconsistency 
                   subreason:message
                    location:codeLocation];
    }
}

- (void)requireSessionInitializationWithLocation:(NSString *)codeLocation
{
    [self requireSessionInitializationWithLocation:codeLocation andMessage:@"This session was not properly initialized"];
}

+ (BOOL)validBool:(id)object fallback:(BOOL)fallback
{
    if (![object isKindOfClass:[NSNumber class]]) {
        return fallback;
    } else {
        return [(NSNumber *)object boolValue];
    }
}

+ (NSString *)validString:(id)object
{
    if (![object isKindOfClass:[NSString class]]) {
        return nil;
    } else {
        return (NSString *)object;
    }
}

// TODO: Localization
+ (NSDictionary *)dictionaryForOTError:(OTError *)error
{
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


- (id)init
{
    self = [super init];
    if (self) {
        // Initializations
        NSLog(@"[DEBUG] init called on session proxy");
        
        // We would normally alloc/init the backing session here, but since we can't yet access its
        // sessionId we will delay initialization of _session until that property is set.
        _session = nil;
        _streamProxies = nil;
        _connectionProxy = nil;
        _publisherProxy = nil;
        _subscriberProxies = nil;
    }
    return self;
}

#pragma mark - Deallocation

- (void)dealloc
{
    NSLog(@"[DEBUG] dealloc called on session proxy");
    [_session release];
    [_streamProxies release];
    [_connectionProxy release];
    [_publisherProxy release];
    [_subscriberProxies release];
    
    [super dealloc];
}

#pragma mark - Objective-C only Methods

-(void)removeSubscriber:(ComTokboxTiOpentokSubscriberProxy *)subscriber
{
    [_subscriberProxies removeObject:subscriber];
    NSLog(@"[DEBUG] session removing subscriber proxy");
}

#pragma mark - Public Properties

- (void)setSessionId:(id)value
{
    // We cannot change the session id once a session has been created, go allocate a new one if needed
    if (_session == nil) {
        NSString *stringSessionId = [TiUtils stringValue:value];
        
        // Lazy initialization of backing session
        _session = [[OTSession alloc] initWithSessionId:stringSessionId delegate:self];
        
        NSLog(@"[DEBUG] session initialized with id: %@", stringSessionId);
        
    } else {
        // Throw error
        // TODO: no idea if this actually works, exception handling isn't documented well for titanium.
        // http://developer.appcelerator.com/question/130582/how-to-catch-errors
        
        [self throwException:TiExceptionInternalInconsistency 
                   subreason:@"Once a Session has been given a sessionId, it cannot be changed." 
                    location:CODELOCATION];
    }
}

- (NSString *)sessionId
{
    return _session.sessionId;
}

- (NSArray *)streams
{
    // Lazily instantiate _streamProxies if it doesn't already exist
    if (_streamProxies == nil) {
        _streamProxies = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    
    // Add a stream proxy for any streams who don't already have one in _streamProxies dictionary
    [_session.streams enumerateKeysAndObjectsUsingBlock:^(id streamId, id stream, BOOL *stop) {
        ComTokboxTiOpentokStreamProxy *streamProxy = [_streamProxies objectForKey:streamId];
        if(streamProxy == nil) {
            streamProxy = [[ComTokboxTiOpentokStreamProxy alloc] initWithStream:(OTStream *)stream sessionProxy:self];
            [_streamProxies setObject:streamProxy forKey:streamId];
            [streamProxy release];
        }
    }];
    
    // Return an array of just the stream proxies
    return [_streamProxies allValues];
}

- (NSString *)sessionConnectionStatus
{
    switch (_session.sessionConnectionStatus) {
        case OTSessionConnectionStatusConnected:
            return kSessionStatusConnected;
            break;
        case OTSessionConnectionStatusConnecting:
            return kSessionStatusConnecting;
            break;
        case OTSessionConnectionStatusDisconnected:
            return kSessionStatusDisconnected;
            break;
        case OTSessionConnectionStatusFailed:
            return kSessionStatusFailed;
            break;
    }
}

-(NSNumber *)connectionCount
{
    return NUMINT(_session.connectionCount);
}

-(ComTokboxTiOpentokConnectionProxy *)connection
{
    if (_connectionProxy == nil) {
        _connectionProxy = [[ComTokboxTiOpentokConnectionProxy alloc] initWithConnection:_session.connection];
    }
    
    return _connectionProxy;
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
    
    NSLog(@"[DEBUG] session connect called");
    
}

- (void)disconnect:(id)args
{
    [self requireSessionInitializationWithLocation:CODELOCATION];
    
    [_session disconnect];
    NSLog(@"[DEBUG] session disconnect called");
}

// takes one argument which is a dictionary of options
- (id)publish:(id)args
{
    NSString *name = nil;
    BOOL publishAudio = YES, publishVideo = YES;
    
    if (_publisherProxy != nil) {
        NSLog(@"[DEBUG] Publisher already exists, cannot create more than one publisher");
        // TODO: not sure if returning the existing publisher proxy is a good idea
        // Maybe we should also verify that not only does it exist, but that it is publishing?
        // unpublish looks like it does the right thing (makes _publisher = nil) but when a publisher fails
        // or if a publisher stops streaming, _publisher probably still points to a valid object
    } else {
        
        // parse options
        id firstArg = [args count] > 0 ? [args objectAtIndex:0] : nil;
        if (firstArg != nil && [firstArg isKindOfClass:[NSDictionary class]]) {
            NSDictionary *options = (NSDictionary *)firstArg;
            name = [ComTokboxTiOpentokSessionProxy validString:[options objectForKey:@"name"]];
            publishAudio = [ComTokboxTiOpentokSessionProxy validBool:[options objectForKey:@"publishAudio"] fallback:YES];
            publishVideo = [ComTokboxTiOpentokSessionProxy validBool:[options objectForKey:@"publishVideo"] fallback:YES];
        }
        
        // Create a publisher proxy from the backing session
        _publisherProxy = [[ComTokboxTiOpentokPublisherProxy alloc] initWithSessionProxy:self 
                                                                                    name:name 
                                                                                   audio:publishAudio 
                                                                                   video:publishVideo];
        
        // Begin publishing
        [_session publish:[_publisherProxy backingOpentokObject]];
        NSLog(@"[DEBUG] session publishing");
    }
    return _publisherProxy;
}

-(void)unpublish:(id)args
{
    if (_publisherProxy != nil) {
        [_session unpublish:[_publisherProxy backingOpentokObject]];
        NSLog(@"[DEBUG] session unpublishing");
        [_publisherProxy _invalidate];
        [_publisherProxy release];
        _publisherProxy = nil;
    } else {
        NSLog(@"[DEBUG] There is no publisher to unpublish");
    }
}

- (id)subscribe:(id)args
{
    BOOL subscribeToAudio = YES, subscribeToVideo = YES;
    // TODO: can we do more than one subscriber for the same stream? probably.
    
    if ([args count] < 1) {
        return nil;
    }
    
    // parse args
    id firstArg = [args objectAtIndex:0];
    if (![firstArg isKindOfClass:[ComTokboxTiOpentokStreamProxy class]]) {
        NSLog(@"[DEBUG] Invalid stream proxy given");
        return nil;
    }
    ComTokboxTiOpentokStreamProxy *stream = (ComTokboxTiOpentokStreamProxy *)firstArg;
    
    id secondArg = [args count] > 1 ? [args objectAtIndex:1] : nil;
    if (secondArg != nil && [secondArg isKindOfClass:[NSDictionary class]]) {
        NSDictionary *options = (NSDictionary *)secondArg;
        subscribeToAudio = [ComTokboxTiOpentokSessionProxy validBool:[options objectForKey:@"subscribeToAudio"] fallback:YES];
        subscribeToVideo = [ComTokboxTiOpentokSessionProxy validBool:[options objectForKey:@"subscribeToVideo"] fallback:YES];
    }
    
    // create subscriber proxy
    if (_subscriberProxies == nil) {
        _subscriberProxies = [[NSMutableArray alloc] initWithCapacity:4];
    }
    ComTokboxTiOpentokSubscriberProxy *subscriber = [[ComTokboxTiOpentokSubscriberProxy alloc] initWithSessionProxy:self 
                                                                                                             stream:stream
                                                                                                              audio:subscribeToAudio 
                                                                                                              video:subscribeToVideo];
    [_subscriberProxies addObject:subscriber];
    NSLog(@"[DEBUG] session adding subscriber proxy");
    [subscriber release];
    
    return subscriber;
}

#pragma mark - Session Delegate Protocol

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"[DEBUG] session connected");
    if ([self _hasListeners:@"sessionConnected"]) {
        [self fireEvent:@"sessionConnected"];
    }
}


- (void)sessionDidDisconnect:(OTSession*)session
{
    NSLog(@"[DEBUG] session disconnected");
    if ([self _hasListeners:@"sessionDisconnected"]) {
        [self fireEvent:@"sessionDisconnected"];
    }
}


- (void)session:(OTSession*)session didFailWithError:(OTError*)error
{
    NSLog(@"[DEBUG] session failed with error: %@", [error description]);
    NSDictionary *errorObject = [ComTokboxTiOpentokSessionProxy dictionaryForOTError:error];
    NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:errorObject forKey:@"error"];
    
    if ([self _hasListeners:@"sessionFailed"]) {
        NSLog(@"[DEBUG] session failed event firing");
        [self fireEvent:@"sessionFailed" withObject:eventParameters];
    }
}


- (void)session:(OTSession*)session didReceiveStream:(OTStream*)stream
{
    NSLog(@"[DEBUG] session recieved stream");
    if ([self _hasListeners:@"streamCreated"]) {
        
        // Create a stream proxy object
        ComTokboxTiOpentokStreamProxy *streamProxy = [[ComTokboxTiOpentokStreamProxy alloc] initWithStream:stream sessionProxy:self];
        
        // Manage the _streamProxies dictionary
        [_streamProxies setObject:streamProxy forKey:streamProxy.streamId];
        
        // Put the stream proxy object in the event parameters
        NSDictionary *eventProperties = [NSDictionary dictionaryWithObject:streamProxy forKey:@"stream"];
        
        // Clean up
        [streamProxy release];
        
        // fire event
        [self fireEvent:@"streamCreated" withObject:eventProperties];
    }
}


- (void)session:(OTSession*)session didDropStream:(OTStream*)stream
{
    NSLog(@"[DEBUG] session dropped stream");
    if ([self _hasListeners:@"streamDestroyed"]) {
        
        // Find and remove the stream proxy in _streamProxies
        ComTokboxTiOpentokStreamProxy *deadStreamProxy = [[_streamProxies objectForKey:stream.streamId] retain];
        [_streamProxies removeObjectForKey:deadStreamProxy.streamId];
        
        // If the stream proxy is not found, create one for the event properties
        if (deadStreamProxy == nil) {
            NSLog(@"[DEBUG] Could not find stream proxy during drop, initializing new one here");
            deadStreamProxy = [[ComTokboxTiOpentokStreamProxy alloc] initWithStream:stream sessionProxy:self];
        }
        
        // put the stream proxy object in the event parameters
        NSDictionary *eventProperties = [NSDictionary dictionaryWithObject:deadStreamProxy forKey:@"stream"];
        [deadStreamProxy release];
        
        // fire event
        [self fireEvent:@"streamDestroyed" withObject:eventProperties];
    }
}

#pragma mark - Opentok Object Proxy

- (id) backingOpentokObject
{
    return _session;
}

#pragma mark - TiProxy

-(void)_listenerAdded:(NSString*)type count:(int)count
{
    NSLog(@"[DEBUG] Session Listener of type %@ added", type);
    [super _listenerAdded:type count:count];
}

-(void)_listenerRemoved:(NSString*)type count:(int)count
{
    NSLog(@"[DEBUG] Session Listener of type %@ removed", type);
    [super _listenerRemoved:type count:count];
}

@end

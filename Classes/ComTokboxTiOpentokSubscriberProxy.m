/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokSessionProxy.h"
#import "ComTokboxTiOpentokSubscriberProxy.h"
#import "ComTokboxTiOpentokStreamProxy.h"
#import <Opentok/OTSubscriber.h>

@implementation ComTokboxTiOpentokSubscriberProxy

#pragma mark - Helpers

- (void)requireSubscriberInitializationWithLocation:(NSString *)codeLocation andMessage:(NSString *)message {
    if (_subscriber == nil) {
        [self throwException:TiExceptionInternalInconsistency
                   subreason:message
                    location:codeLocation];
    }
}

- (void)requireSubscriberInitializationWithLocation:(NSString *)codeLocation {
    [self requireSubscriberInitializationWithLocation:codeLocation andMessage:@"This subscriber was not properly initialized"];
}

// TODO: Localization
+ (NSDictionary *)dictionaryForOTError:(OTError *)error
{
    NSString *message;
    switch ([error code]) {
        case OTConnectionTimedOut:
            message = @"Subscriber timed out while attempting to connect to stream. Can reattempt connection.";
            break;
            
        case OTSubscriberSessionDisconnected:
            message = @"Subscriber failed because the session was disconnected";
            break;
            
        case OTSubscriberWebRTCError:
            message = @"Subscriber failed in the WebRTC stack";
            break;
            
        case OTSubscriberInternalError:
            message = @"Thread dispatch failure, out of memory, etc.";
            break;
            
        default:
            message = @"An unknown error occurred";
            break;
    }
    
    return [NSDictionary dictionaryWithObject:message forKey:@"message"];
}

#pragma mark - Initialization

// Overriding designated initializer in order to prevent instantiation from javascript land (hopefully)
- (id)initWithSessionProxy:(ComTokboxTiOpentokSessionProxy *)sessionProxy 
                    stream:(ComTokboxTiOpentokStreamProxy *)streamProxy
                     audio:(BOOL)subscribeToAudio 
                     video:(BOOL)subscribeToVideo;
{
    
    self = [super init];
    
    if (self) {
        // unretained, unsafe reference. be careful
        _sessionProxy = sessionProxy;
        _streamProxy = streamProxy;
        
        _subscriber = [[OTSubscriber alloc] initWithStream:[streamProxy backingOpentokObject] delegate:self];
        _subscriber.subscribeToAudio = subscribeToAudio;
        _subscriber.subscribeToVideo = subscribeToVideo;
        
        _videoViewProxy = nil;
        
    }
    
    return self;
}

#pragma mark - Deallocation

- (void)dealloc {
    // TODO: This is unsafe, but it must be done
    [_sessionProxy _removeSubscriber:self];
    
    [_subscriber release];
    [_videoViewProxy _invalidate];
    [_videoViewProxy release];
    
    [super dealloc];
}

#pragma mark - Properties

-(id)session
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    
    // TODO: this could return a dangling pointer
    return _sessionProxy;
}

-(id)stream
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    
    // TODO: this could return a dangling pointer
    return _streamProxy;
}

-(ComTokboxTiOpentokVideoViewProxy *)view
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    
    // TODO: Probably not the best way to return a view, should somehow indicate that createView should
    //       be called first
    if (_videoViewProxy) return _videoViewProxy;
    return nil;
}

-(id)subscribeToAudio
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    return NUMBOOL(_subscriber.subscribeToAudio);
}

-(id)subscribeToVideo
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    return NUMBOOL(_subscriber.subscribeToVideo);
}

#pragma mark - Methods

-(void)close:(id)args
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    
    [_subscriber close];
    _subscriber = nil;
    
    [_sessionProxy _removeSubscriber:self];
    
    [_videoViewProxy _invalidate];
    [_videoViewProxy release];
    _videoViewProxy = nil;
}

-(ComTokboxTiOpentokVideoViewProxy *)createView:(id)args
{
    [self requireSubscriberInitializationWithLocation:CODELOCATION];
    
    NSLog(@"[DEBUG] creating a video view proxy");
    if (!_videoViewProxy) {
        ENSURE_SINGLE_ARG(args, NSDictionary);
        _videoViewProxy = [[ComTokboxTiOpentokVideoViewProxy alloc] initWithProxy:self andProperties:args];
        NSLog(@"[DEBUG] video view proxy instance created: %@", _videoViewProxy.description);
    }
    // TODO: assign properties to existing videoViewProxy?
    return _videoViewProxy;
}

#pragma mark - Subscriber Delegate

- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    if ([self _hasListeners:@"subscriberConnected"]) {
        [self fireEvent:@"subscriberConnected"];
    }
}

- (void)subscriber:(OTSubscriber*)subscriber didFailWithError:(OTError*)error
{
    if ([self _hasListeners:@"subscriberFailed"]) {
        
        NSDictionary *errorObject = [ComTokboxTiOpentokSubscriberProxy dictionaryForOTError:error];
        NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:errorObject forKey:@"error"];
        
        [self fireEvent:@"subscriberFailed" withObject:eventParameters];
    }
}

- (void)subscriberVideoDataReceived:(OTSubscriber*)subscriber
{
    if ([self _hasListeners:@"subscriberStarted"]) {
        [self fireEvent:@"subscriberStarted"];
    }
}

#pragma mark - Opentok Object Proxy

- (id) backingOpentokObject
{
    return _subscriber;
}


@end

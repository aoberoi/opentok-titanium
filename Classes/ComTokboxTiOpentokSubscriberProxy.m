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

// TODO: Localization
+ (NSDictionary *)dictionaryForOTError:(OTError *)error
{
    NSString *message;
    switch ([error code]) {
        case OTFailedToConnect:
            message = @"Subscriber failed to connect to stream. Can reattempt connection.";
            break;
            
        case OTConnectionTimedOut:
            message = @"Subscriber timed out while attempting to connect to stream. Can reattempt connection.";
            break;
            
        case OTNoStreamMedia:
            message = @"The stream has no audio or video to subscribe to.";
            break;
            
        case OTInitializationFailure:
            message = @"Subscriber failed to initialize.";
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
    [_subscriber release];
    [_videoViewProxy _invalidate];
    [_videoViewProxy release];
    
    [super dealloc];
}

#pragma mark - Properties

-(id)session
{
    // TODO: this could return a dangling pointer
    return _sessionProxy;
}

-(id)stream
{
    // TODO: this could return a dangling pointer
    return _streamProxy;
}

-(ComTokboxTiOpentokVideoViewProxy *)view
{
    // TODO: Probably not the best way to return a view, should somehow indicate that createView should
    //       be called first
    if (_videoViewProxy) return _videoViewProxy;
    return nil;
}

-(id)subscribeToAudio
{
    return NUMBOOL(_subscriber.subscribeToAudio);
}

-(id)subscribeToVideo
{
    return NUMBOOL(_subscriber.subscribeToVideo);
}

#pragma mark - Methods

-(void)close:(id)args
{
    [_subscriber close];
    [_sessionProxy removeSubscriber:self];
}

-(ComTokboxTiOpentokVideoViewProxy *)createView:(id)args
{
    NSLog(@"[INFO] creating a video view proxy");
    if (!_videoViewProxy) {
        ENSURE_SINGLE_ARG(args, NSDictionary);
        _videoViewProxy = [[ComTokboxTiOpentokVideoViewProxy alloc] initWithProxy:self andProperties:args];
        NSLog(@"[INFO] video view proxy instance created: %@", _videoViewProxy.description);
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

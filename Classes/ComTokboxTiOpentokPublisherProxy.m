/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokPublisherProxy.h"
#import "ComTokboxTiOpentokSessionProxy.h"
#import <Opentok/OTPublisher.h>

@implementation ComTokboxTiOpentokPublisherProxy

@synthesize publisher = _publisher;

#pragma mark - Error Handling

// TODO: Localization
+ (NSDictionary *)dictionaryForOTError:(OTError *)error
{
    NSString *message;
    switch ([error code]) {
        case OTNoMediaPublished:
            message = @"Attempting to publish a stream with no audio or video";
            break;
            
        case OTUserDeniedCameraAccess:
            message = @"The user denied access to the camera during publishing";
            break;
            
        case OTAlreadyPublishing:
            message = @"Already publishing";
            break;
            
        case OTSessionDisconnected:
            message = @"Attempting to publish to a disconnected session";
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
                      name:(NSString *)name
                     audio:(BOOL)publishAudio 
                     video:(BOOL)publishVideo
{
    
    self = [super init];
    
    if (self) {
        // unretained, unsafe reference. be careful
        _sessionProxy = sessionProxy;
        
        if (name != nil) {
            _publisher = [[OTPublisher alloc] initWithDelegate:self name:name];
        } else {
            _publisher = [[OTPublisher alloc] initWithDelegate:self];
        }
        
        _publisher.publishAudio = publishAudio;
        _publisher.publishVideo = publishVideo;
    }
    
    return self;
}

#pragma mark - Deallocation

- (void)dealloc {
    [_publisher release];
    
    [super dealloc];
}

#pragma mark - Properties

-(id)publishAudio
{
    return NUMBOOL(_publisher.publishAudio);
}

-(id)publishVideo
{
    return NUMBOOL(_publisher.publishVideo);
}

-(id)name
{
    return _publisher.name;
}

-(id)cameraPosition
{
    
}

#pragma mark - Methods


#pragma mark - Publisher Delegate Protocol

- (void)publisher:(OTPublisher *)publisher didFailWithError:(OTError *)error
{
    if ([self _hasListeners:@"publisherFailed"]) {
        
        NSDictionary *errorObject = [ComTokboxTiOpentokPublisherProxy dictionaryForOTError:error];
        NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:errorObject forKey:@"error"];
        
        [self fireEvent:@"publisherFailed"];
    }
}

- (void)publisherDidStartStreaming:(OTPublisher *)publisher
{
    if ([self _hasListeners:@"publisherStarted"]) {
        [self fireEvent:@"publisherStarted"];
    }
}

- (void)publisherDidStopStreaming:(OTPublisher *)publisher
{
    if ([self _hasListeners:@"publisherStopped"]) {
        [self fireEvent:@"publisherStopped"];
    }
}

@end

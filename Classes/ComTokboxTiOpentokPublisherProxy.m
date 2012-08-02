/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokPublisherProxy.h"
#import "ComTokboxTiOpentokSessionProxy.h"
#import <Opentok/OTPublisher.h>

NSString * const kPublisherCameraPositionFront = @"cameraFront";
NSString * const kPublisherCameraPositionBack = @"cameraBack";

@implementation ComTokboxTiOpentokPublisherProxy

@synthesize publisher = _publisher;

#pragma mark - Helpers

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
            
        case OTSessionDisconnected:
            message = @"Attempting to publish to a disconnected session";
            break;
            
        default:
            message = @"An unknown error occurred";
            break;
    }
    
    return [NSDictionary dictionaryWithObject:message forKey:@"message"];
}

+ (NSString *)captureDevicePositionToString:(AVCaptureDevicePosition)position
{
    switch (position) {
        case AVCaptureDevicePositionBack:
            return kPublisherCameraPositionBack;
            break;
        case AVCaptureDevicePositionFront:
            return kPublisherCameraPositionFront;
            break;
    }
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

-(id)session
{
    return _sessionProxy;
}

-(id)cameraPosition
{
    return [ComTokboxTiOpentokPublisherProxy captureDevicePositionToString:_publisher.cameraPosition];
}

-(void)setCameraPosition:(NSString *)cameraPosition
{
    if ([cameraPosition isEqualToString:kPublisherCameraPositionBack]) {
        _publisher.cameraPosition = AVCaptureDevicePositionBack;
    } else if ([cameraPosition isEqualToString:kPublisherCameraPositionFront]) {
        _publisher.cameraPosition = AVCaptureDevicePositionFront;
    }
}

-(id)view
{
    // TODO: Probably not the best way to return a view, should somehow indicate that createView should
    //       be called first
    if (_publisherViewProxy) return _publisherViewProxy;
    return [NSNull null];
}


#pragma mark - Methods

// TODO: this needs to run on a UI thread?
//       ENSURE_UI_THREAD_1(arg) would not work because the method returns non-void
-(ComTokboxTiOpentokPublisherViewProxy *)createView:(id)args
{
    NSLog(@"[INFO] creating a publisher view proxy");
    if (!_publisherViewProxy) {
        ENSURE_SINGLE_ARG(args, NSDictionary);
        _publisherViewProxy = [[ComTokboxTiOpentokPublisherViewProxy alloc] initWithPublisherProxy:self andProperties:args];
        NSLog(@"[INFO] publisher view proxy instance created: %@", _publisherViewProxy.description);
    }
    // TODO: assign properties to existing subscriberViewProxy?
    return _publisherViewProxy;
}

#pragma mark - Publisher Delegate Protocol

- (void)publisher:(OTPublisher *)publisher didFailWithError:(OTError *)error
{
    if ([self _hasListeners:@"publisherFailed"]) {
        
        NSDictionary *errorObject = [ComTokboxTiOpentokPublisherProxy dictionaryForOTError:error];
        NSDictionary *eventParameters = [NSDictionary dictionaryWithObject:errorObject forKey:@"error"];
        
        [self fireEvent:@"publisherFailed" withObject:eventParameters];
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

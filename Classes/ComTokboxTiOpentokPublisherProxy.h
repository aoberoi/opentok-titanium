/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <Opentok/OTPublisher.h>
#import "ComTokboxTiOpentokPublisherViewProxy.h"

extern NSString * const kPublisherCameraPositionFront;
extern NSString * const kPublisherCameraPositionBack;

@class ComTokboxTiOpentokSessionProxy;

@interface ComTokboxTiOpentokPublisherProxy : TiProxy <OTPublisherDelegate> {

@private
    // Owned
    OTPublisher *_publisher;
    ComTokboxTiOpentokPublisherViewProxy *_publisherViewProxy;
    // Unsafe unretained
    ComTokboxTiOpentokSessionProxy *_sessionProxy;
}

- (id)initWithSessionProxy:(ComTokboxTiOpentokSessionProxy *)sessionProxy 
                      name:(NSString *)name 
                     audio:(BOOL)publishAudio 
                     video:(BOOL)publishVideo;

// Objective-C only Property
@property (readonly) OTPublisher *publisher;

// Properties
@property (readonly) NSNumber *publishAudio;
@property (readonly) NSNumber *publishVideo;
@property (readonly) NSString *name;
@property (readonly) ComTokboxTiOpentokSessionProxy *session;
@property (nonatomic, assign) NSString *cameraPosition;
@property (readonly) id view;

// Methods
-(ComTokboxTiOpentokPublisherViewProxy *)createView:(id)args;

@end

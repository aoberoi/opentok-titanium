/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "OTObjectProxy.h"
#import <Opentok/OTSubscriber.h>
#import "ComTokboxTiOpentokVideoViewProxy.h"

@class ComTokboxTiOpentokSessionProxy, ComTokboxTiOpentokStreamProxy;

@interface ComTokboxTiOpentokSubscriberProxy : TiProxy <OTSubscriberDelegate, OTObjectProxy> {

@private
    // Owned
    OTSubscriber *_subscriber;
    ComTokboxTiOpentokVideoViewProxy *_videoViewProxy;
    // Unsafe unretained
    ComTokboxTiOpentokSessionProxy *_sessionProxy;
    ComTokboxTiOpentokStreamProxy *_streamProxy;
}

- (id)initWithSessionProxy:(ComTokboxTiOpentokSessionProxy *)sessionProxy 
                    stream:(ComTokboxTiOpentokStreamProxy *)stream 
                     audio:(BOOL)subscribeToAudio 
                     video:(BOOL)subscribeToVideo;

// Properties
@property (readonly, assign) ComTokboxTiOpentokSessionProxy *session;
@property (readonly, assign) ComTokboxTiOpentokStreamProxy *stream;
@property (readonly) NSNumber *subscribeToAudio;
@property (readonly) NSNumber *subscribeToVideo;
@property (readonly) ComTokboxTiOpentokVideoViewProxy *view;

// Methods
-(void)close:(id)args;
-(ComTokboxTiOpentokVideoViewProxy *)createView:(id)args;

@end

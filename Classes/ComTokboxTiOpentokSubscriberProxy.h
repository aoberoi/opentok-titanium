/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <Opentok/OTSubscriber.h>

@class ComTokboxTiOpentokSessionProxy, ComTokboxTiOpentokStreamProxy;

@interface ComTokboxTiOpentokSubscriberProxy : TiProxy <OTSubscriberDelegate> {

@private
    OTSubscriber *_subscriber;
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

// Methods
-(void)close;

@end

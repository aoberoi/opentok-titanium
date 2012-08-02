/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import <Opentok/OTPublisher.h>

@interface ComTokboxTiOpentokPublisherView : TiUIView {
    UIView *_publisherView;
}

// Obj-C only Methods
- (void)_invalidatePublisher;

@end

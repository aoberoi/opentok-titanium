/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import <Opentok/OTSubscriber.h>

@interface ComTokboxTiOpentokSubscriberView : TiUIView {
    UIView *_subscriberView;
}

// Obj-C only Methods
- (void)_invalidateSubscriber;

@end

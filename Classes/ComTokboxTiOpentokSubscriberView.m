/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokSubscriberView.h"

@implementation ComTokboxTiOpentokSubscriberView

// need to get a message from the SubscriberProxy when it is about to die so that the
// subscriberView and subscriber can be invalidated (set to nil).
- (void)invalidateSubscriberProxy
{
    _subscriber = nil;
    _subscriberView = nil;
}

- (void)dealloc
{
    RELEASE_TO_NIL(_subscriberView);
    [super dealloc];
}

- (UIView *)subscriberView
{
    if (_subscriberView == nil) {
        if (_subscriber == nil) {
            NSLog(@"Subscriber View cannot be initialized without valid Subscriber object");
            return nil;
        }
        
        // TODO: check if there are any memory management issues here with cycles
        _subscriberView = [_subscriber.view retain];
    }
    
    return _subscriberView;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (_subscriberView != nil) {
        [TiUtils setView:_subscriberView positionRect:bounds];
    }
}

@end

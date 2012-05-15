/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokSubscriberView.h"
#import "ComTokboxTiOpentokSubscriberViewProxy.h"
#import "ComTokboxTiOpentokSubscriberProxy.h"

@implementation ComTokboxTiOpentokSubscriberView

// need to get a message from the SubscriberProxy when it is about to die so that the
// subscriberView can be invalidated (set to nil).
- (void)_invalidateSubscriberProxy
{
    [_subscriberView release];
    _subscriberView = nil;
}

- (void)dealloc
{
    RELEASE_TO_NIL(_subscriberView);
    [super dealloc];
}

- (UIView *)subscriberView
{
    NSLog(@"[INFO] subscriber view being created");
    if (_subscriberView == nil) {
        ComTokboxTiOpentokSubscriberViewProxy *proxy = (ComTokboxTiOpentokSubscriberViewProxy *)self.proxy;
        // TODO: check if there are any memory management issues here with cycles
        _subscriberView = [[[proxy _subscriberProxy] _subscriber].view retain];
        NSLog(@"[INFO] subscriber view instance created: %@", _subscriberView.description);
    }
    
    return _subscriberView;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (_subscriberView != nil) {
        NSLog(@"[INFO] laying out subscriber view");
        [TiUtils setView:_subscriberView positionRect:bounds];
    }
}

@end

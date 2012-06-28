/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokPublisherView.h"
#import "ComTokboxTiOpentokPublisherViewProxy.h"
#import "ComTokboxTiOpentokPublisherProxy.h"

@implementation ComTokboxTiOpentokPublisherView

// need to get a message from the PublisherProxy when it is about to die so that the
// publisherView can be invalidated (set to nil).
- (void)_invalidatePublisher
{
    [_publisherView release];
    _publisherView = nil;
}

- (void)dealloc
{
    RELEASE_TO_NIL(_publisherView);
    [super dealloc];
}

- (UIView *)publisherView
{
    NSLog(@"[INFO] publisher view being created");
    if (_publisherView == nil) {
        ComTokboxTiOpentokPublisherViewProxy *proxy = (ComTokboxTiOpentokPublisherViewProxy *)self.proxy;
        // TODO: check if there are any memory management issues here with cycles
        _publisherView = [[[proxy _publisherProxy] publisher].view retain];
        [self addSubview:_publisherView];
        NSLog(@"[INFO] publisher view instance created: %@", _publisherView.description);
    }
    
    return _publisherView;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (_publisherView == nil) {
        [self publisherView];
    }
    NSLog(@"[INFO] laying out publisher view");
    [TiUtils setView:_publisherView positionRect:bounds];
}


@end

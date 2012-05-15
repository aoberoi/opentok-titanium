/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokSubscriberViewProxy.h"
#import "TiUtils.h"

@implementation ComTokboxTiOpentokSubscriberViewProxy

@synthesize subscriberProxy = _subscriberProxy;

- (id)initWithSubscriberProxy:(ComTokboxTiOpentokSubscriberProxy *)proxy
{
    self = [super init];
    if (self) {
        _subscriberProxy = proxy;
    }
    return self;
}

- (void)_invalidate
{
    ComTokboxTiOpentokSubscriberView *subscriberView = (ComTokboxTiOpentokSubscriberView *)self.view;
    [subscriberView _invalidateSubscriberProxy];
}


@end
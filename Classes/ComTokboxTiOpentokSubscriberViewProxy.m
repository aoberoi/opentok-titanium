/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokSubscriberViewProxy.h"
#import "TiUtils.h"

@implementation ComTokboxTiOpentokSubscriberViewProxy

- (id)initWithSubscriberProxy:(ComTokboxTiOpentokSubscriberProxy *)proxy
{
    self = [super init];
    if (self) {
        _proxy = proxy;
    }
    return self;
}

- (void)invalidate
{
    ComTokboxTiOpentokSubscriberView *subscriberView = (ComTokboxTiOpentokSubscriberView *)self.view;
    [subscriberView invalidateSubscriberProxy];
}


@end
/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiViewProxy.h"
#import "ComTokboxTiOpentokSubscriberView.h"

@class ComTokboxTiOpentokSubscriberProxy;

@interface ComTokboxTiOpentokSubscriberViewProxy : TiViewProxy {
    ComTokboxTiOpentokSubscriberProxy *_proxy;
}

- (id)initWithSubscriberProxy:(ComTokboxTiOpentokSubscriberProxy *)proxy;
- (void)invalidate;

@end

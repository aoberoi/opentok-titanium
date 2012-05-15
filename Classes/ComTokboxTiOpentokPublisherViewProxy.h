/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiViewProxy.h"

@class ComTokboxTiOpentokPublisherProxy;

@interface ComTokboxTiOpentokPublisherViewProxy : TiViewProxy {
    ComTokboxTiOpentokPublisherProxy *_publisherProxy;
}

- (id)initWithPublisherProxy:(ComTokboxTiOpentokPublisherProxy *)proxy 
                andProperties:(NSDictionary *)props;

// Obj-C only Methods
- (ComTokboxTiOpentokPublisherProxy *)_publisherProxy;
- (void)_invalidate;

@end

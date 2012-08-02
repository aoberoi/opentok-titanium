/**
 * Copyright (c) 2012 TokBox, Inc.
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

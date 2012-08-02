/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiViewProxy.h"

@class ComTokboxTiOpentokSubscriberProxy;

@interface ComTokboxTiOpentokSubscriberViewProxy : TiViewProxy {
    ComTokboxTiOpentokSubscriberProxy *_subscriberProxy;
}

- (id)initWithSubscriberProxy:(ComTokboxTiOpentokSubscriberProxy *)proxy 
                andProperties:(NSDictionary *)props;

// Obj-C only Methods
- (ComTokboxTiOpentokSubscriberProxy *)_subscriberProxy;
- (void)_invalidate;

@end

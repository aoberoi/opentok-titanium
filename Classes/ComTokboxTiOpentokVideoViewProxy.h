/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiViewProxy.h"

@interface ComTokboxTiOpentokVideoViewProxy : TiViewProxy {
    TiProxy *_proxy;
}

- (id)initWithProxy:(TiProxy *)proxy
      andProperties:(NSDictionary *)props;

// Obj-C only Methods
- (TiProxy *)_proxy;
- (void)_invalidate;

@end

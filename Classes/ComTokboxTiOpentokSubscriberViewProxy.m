/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokSubscriberViewProxy.h"
#import "ComTokboxTiOpentokSubscriberView.h"
#import "TiUtils.h"

@implementation ComTokboxTiOpentokSubscriberViewProxy


- (id)initWithSubscriberProxy:(ComTokboxTiOpentokSubscriberProxy *)proxy 
                andProperties:(NSDictionary *)props
{
    NSLog(@"[INFO] initializing subscriber view proxy beginning: %@", self.description);
    self = [super init];
    if (self) {
        [self _initWithProperties:props];
        _subscriberProxy = proxy;
    }
    NSLog(@"[INFO] initializing subscriber view proxy complete: %@", self.description);
    return self;
}

- (ComTokboxTiOpentokSubscriberProxy *)_subscriberProxy
{
    return _subscriberProxy;
}

- (void)_invalidate
{
    ComTokboxTiOpentokSubscriberView *subscriberView = (ComTokboxTiOpentokSubscriberView *)self.view;
    [subscriberView _invalidateSubscriber];
}


@end
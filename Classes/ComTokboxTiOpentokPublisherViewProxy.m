/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokPublisherViewProxy.h"
#import "ComTokboxTiOpentokPublisherView.h"
#import "TiUtils.h"

@implementation ComTokboxTiOpentokPublisherViewProxy

- (id)initWithPublisherProxy:(ComTokboxTiOpentokPublisherProxy *)proxy 
                andProperties:(NSDictionary *)props
{
    NSLog(@"[INFO] initializing publisher view proxy beginning: %@", self.description);
    self = [super init];
    if (self) {
        [self _initWithProperties:props];
        _publisherProxy = proxy;
    }
    NSLog(@"[INFO] initializing publisher view proxy complete: %@", self.description);
    return self;
}

- (ComTokboxTiOpentokPublisherProxy *)_publisherProxy
{
    return _publisherProxy;
}

- (void)_invalidate
{
    ComTokboxTiOpentokPublisherView *publisherView = (ComTokboxTiOpentokPublisherView *)self.view;
    [publisherView _invalidatePublisher];
}

@end

/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokVideoViewProxy.h"
#import "ComTokboxTiOpentokVideoView.h"
#import "TiUtils.h"

@implementation ComTokboxTiOpentokVideoViewProxy


- (id)initWithProxy:(TiProxy *)proxy
      andProperties:(NSDictionary *)props
{
    NSLog(@"[DEBUG] initializing video view proxy beginning: %@", self.description);
    self = [super init];
    if (self) {
        [self _initWithProperties:props];
        _proxy = proxy;
    }
    NSLog(@"[DEBUG] initializing video view proxy complete: %@", self.description);
    return self;
}

- (TiProxy *)_proxy
{
    return _proxy;
}

- (void)_invalidate
{
    ComTokboxTiOpentokVideoView *videoView = (ComTokboxTiOpentokVideoView *)self.view;
    [videoView _invalidate];
}


@end
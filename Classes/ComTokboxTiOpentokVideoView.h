/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import <Opentok/OTVideoView.h>

@interface ComTokboxTiOpentokVideoView : TiUIView {
    OTVideoView *_videoView;
}

// Obj-C only Methods
- (void)_invalidate;

@end

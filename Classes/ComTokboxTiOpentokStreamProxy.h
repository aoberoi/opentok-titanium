//
//  ComTokboxTiOpentokStreamProxy.h
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/21/12.
//  Copyright (c) 2012 TokBox, Inc.
//  Please see the LICENSE included with this distribution for details.
//

#import "TiProxy.h"
#import <Opentok/OTStream.h>

@class ComTokboxTiOpentokSessionProxy;
@class ComTokboxTiOpentokConnectionProxy;

@interface ComTokboxTiOpentokStreamProxy : TiProxy {
    
@private
    OTStream *_stream;
    ComTokboxTiOpentokSessionProxy *_sessionProxy;
    ComTokboxTiOpentokConnectionProxy *_connectionProxy;
}

- (id)initWithStream:(OTStream *)existingStream sessionProxy:(ComTokboxTiOpentokSessionProxy *)sessionProxy;

// Objective-C only Property
@property (readonly) OTStream *stream;

// Properties
@property (readonly) ComTokboxTiOpentokConnectionProxy *connection;
@property (readonly) NSDate *creationTime;
@property (readonly) NSNumber *hasAudio;
@property (readonly) NSNumber *hasVideo;
@property (readonly) NSString *name;
@property (readonly) ComTokboxTiOpentokSessionProxy *session;
@property (readonly) NSString *streamId;
@property (readonly) NSString *type;

@end

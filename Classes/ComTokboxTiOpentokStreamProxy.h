//
//  ComTokboxTiOpentokStreamProxy.h
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import <Opentok/OTStream.h>

@class ComTokboxTiOpentokSessionProxy;
@class ComTokboxTiOpentokConnectionProxy;

@interface ComTokboxTiOpentokStreamProxy : TiProxy {
    
@private
    OTStream *_stream;
    ComTokboxTiOpentokSessionProxy *_sessionProxy;
}

- (id)initWithStream:(OTStream *)existingStream sessionProxy:(ComTokboxTiOpentokSessionProxy *)sessionProxy;

@property (readonly) ComTokboxTiOpentokConnectionProxy *connection;
@property (readonly) NSDate *creationTime;
@property (readonly) NSNumber *hasAudio;
@property (readonly) NSNumber *hasVideo;
@property (readonly) NSString *name;
@property (readonly) ComTokboxTiOpentokSessionProxy *session;
@property (readonly) NSString *streamId;
@property (readonly) NSString *type;

@end

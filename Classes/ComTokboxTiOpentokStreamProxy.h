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

@interface ComTokboxTiOpentokStreamProxy : TiProxy {
    
@private
    OTStream *_stream;
}

- (id)initWithStream:(OTStream *)existingStream;

//@property (nonatomic, readonly, assign)  *connection;
@property (nonatomic, readonly, assign) NSDate *creationTime;
@property (nonatomic, readonly, assign) NSNumber *hasAudio;
@property (nonatomic, readonly, assign) NSNumber *hasVideo;
@property (nonatomic, readonly, assign) NSString *name;
@property (nonatomic, readonly, assign) ComTokboxTiOpentokSessionProxy *session;
@property (nonatomic, readonly, assign) NSString *streamId;
@property (nonatomic, readonly, assign) NSString *type;

@end

//
//  ComTokboxTiOpentokSessionProxy.h
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import "ComTokboxTiOpentokConnectionProxy.h"
#import "ComTokboxTiOpentokPublisherProxy.h"
#import <Opentok/OTSession.h>

extern NSString * const kSessionStatusConnected;
extern NSString * const kSessionStatusConnecting;
extern NSString * const kSessionStatusDisconnected;
extern NSString * const kSessionStatusFailed;

extern NSString * const kSessionEnvironmentStaging;
extern NSString * const kSessionEnvironmentProduction;

@interface ComTokboxTiOpentokSessionProxy : TiProxy <OTSessionDelegate> {

@private
    OTSession *_session;
    NSMutableDictionary *_streamProxies;
    ComTokboxTiOpentokConnectionProxy *_connectionProxy;
    ComTokboxTiOpentokPublisherProxy *_publisherProxy;
}

// Properties
@property (nonatomic, readwrite, assign) NSString *sessionId;
@property (readonly) NSArray *streams;
@property (readonly) NSString *sessionConnectionStatus;
@property (readonly) NSNumber *connectionCount;
@property (readonly) ComTokboxTiOpentokConnectionProxy *connection;
@property (nonatomic, readwrite, assign) NSString *environment;

// Methods
- (void)connect:(id)args;
- (void)disconnect:(id)args;
- (id)publish:(id)args;


@end

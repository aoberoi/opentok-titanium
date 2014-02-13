//
//  ComTokboxTiOpentokSessionProxy.h
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/19/12.
//  Copyright (c) 2012 TokBox, Inc.
//  Please see the LICENSE included with this distribution for details.
//

#import "TiProxy.h"
#import "OTObjectProxy.h"
#import <Opentok/OTSession.h>

extern NSString * const kSessionStatusConnected;
extern NSString * const kSessionStatusConnecting;
extern NSString * const kSessionStatusDisconnected;
extern NSString * const kSessionStatusFailed;

@class ComTokboxTiOpentokConnectionProxy, 
       ComTokboxTiOpentokPublisherProxy, 
       ComTokboxTiOpentokSubscriberProxy;

@interface ComTokboxTiOpentokSessionProxy : TiProxy <OTSessionDelegate, OTObjectProxy> {

// Owning strong references
@private
    OTSession *_session;
    NSMutableDictionary *_streamProxies;
    ComTokboxTiOpentokConnectionProxy *_connectionProxy;
    ComTokboxTiOpentokPublisherProxy *_publisherProxy;
    NSMutableArray *_subscriberProxies;
    
}

// Obj-C only Methods
-(void)_removeSubscriber:(ComTokboxTiOpentokSubscriberProxy *)subscriberProxy;

// Properties
@property (nonatomic, readwrite, assign) NSString *sessionId;
@property (readonly) NSArray *streams;
@property (readonly) NSString *sessionConnectionStatus;
@property (readonly) NSNumber *connectionCount;
@property (readonly) ComTokboxTiOpentokConnectionProxy *connection;

// Methods
- (void)connect:(id)args;
- (void)disconnect:(id)args;
- (id)publish:(id)args;
- (void)unpublish:(id)args;
- (id)subscribe:(id)args;
- (void)unsubscribe:(id)args;
// TODO add signaling methods


@end

//
//  ComTokboxTiOpentokSessionProxy.h
//  opentok-titanium
//
//  Created by Ankur Oberoi on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiProxy.h"
#import <Opentok/OTSession.h>

@interface ComTokboxTiOpentokSessionProxy : TiProxy <OTSessionDelegate> {

@private
    OTSession *_session;
}

// Properties
@property (nonatomic, readwrite, assign) NSString *sessionId;


// Methods
- (void)connect:(id)args;

@end

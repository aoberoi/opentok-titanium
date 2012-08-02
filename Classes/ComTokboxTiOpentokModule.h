/**
 * Copyright (c) 2012 TokBox, Inc.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiModule.h"
#import <Opentok/OTSession.h>

@interface ComTokboxTiOpentokModule : TiModule 
{
    OTSession *_session;
}

+(ComTokboxTiOpentokModule *)sharedModule;

@property (nonatomic, retain) OTSession *session;

@end

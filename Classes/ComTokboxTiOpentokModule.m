/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComTokboxTiOpentokModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"


static ComTokboxTiOpentokModule *_sharedModule;

@implementation ComTokboxTiOpentokModule

@synthesize session;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"aebd1afb-75f8-4b05-a50f-e5861cfb0b7e";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.tokbox.ti.opentok";
}

// return the singleton of this module object
+(ComTokboxTiOpentokModule *)sharedModule {
    return _sharedModule;
}

// don't let session be assigned more than once
-(void)setSession:(OTSession *)newSession
{
    if (_session == nil) {
        _session = [newSession retain];
    } else {
        NSLog(@"Cannot set session because one already exists");
    }
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
    _sharedModule = self;
    _session = nil;
    
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
    [_session release];
    _sharedModule = nil;
    
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end

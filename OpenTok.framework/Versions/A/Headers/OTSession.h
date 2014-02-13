//
//  OTSession.h
//
//  Copyright (c) 2013 Tokbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenTok/OpenTokObjC.h>

@class OTError, OTConnection, OTPublisherKit, OTSubscriberKit, OTStream;

@protocol OTSessionDelegate;

/**
 * @enum OTSessionConnectionStatus
 *
 * @abstract
 * The connection status codes, available through OTSession.sessionConnectionStatus.
 *
 * @constant   OTSessionConnectionStatusConnected
 * The session is connected.
 * @constant   OTSessionConnectionStatusConnecting
 * The session is connecting.
 * @constant   OTSessionConnectionStatusDisconnected
 * The session is not connected.
 * @constant   OTSessionConnectionStatusFailed
 * The attempt to connect to the session failed.
 */
typedef enum {
    OTSessionConnectionStatusConnected,
    OTSessionConnectionStatusConnecting,
    OTSessionConnectionStatusDisconnected,
    OTSessionConnectionStatusFailed,
} OTSessionConnectionStatus;

/**
 * The first step in using the OpenTok iOS SDK is to initialize
 * an OTSession object with a valid
 * [session ID]( http://tokbox.com/opentok/tutorials/create-session )
 * Use the OTSession object to connect to OpenTok using your developer
 * [API key](https://dashboard.tokbox.com/projects) and a valid
 * [token]( http://tokbox.com/opentok/tutorials/create-token )
 */
@interface OTSession : NSObject

/** @name Getting information about the session */

/**
 * The status of this OTSession instance. Useful for ad-hoc queries about session status.
 *
 * Valid values are defined in OTSessionConnectionStatus:
 *
 * - `OTSessionConnectionStatusConnected` - The session is connected.
 * - `OTSessionConnectionStatusConnecting` - The session is connecting.
 * - `OTSessionConnectionStatusDisconnected` - The session is not connected.
 * - `OTSessionConnectionStatusFailed` - The attempt to connect to the session failed.
 *
 * On instantiation, expect the `sessionConnectionStatus` to have the value `OTSessionConnectionStatusDisconnected`.
 *
 * You can use a key-value observer to monitor this property. However, the <[OTSessionDelegate sessionDidConnect:]>
 * and <[OTSessionDelegate sessionDidDisconnect:]> messages are sent to the session's delegate when the session
 * connects and disconnects.
 */
@property(readonly) OTSessionConnectionStatus sessionConnectionStatus;

/**
 * The [session ID]( http://tokbox.com/opentok/tutorials/create-session )
 * of this instance. Once initialized, this is an immutable value.
 */
@property(readonly) NSString* sessionId;

/**
 * The number of discrete clients connected to this session. Individual iOS clients
 * connect to a session by sending the <[OTSession connectWithApiKey:token:]> message.
 */
@property(readonly) int connectionCount;

/**
 * The streams that are a part of this session, keyed by streamId.
 */
@property(readonly) NSDictionary* streams;

/**
 * The <OTConnection> object for this session. The connection property is only available
 * once the <[OTSessionDelegate sessionDidConnect:]> message is sent. If the session fails to connect,
 * this property shall remain nil.
 */
@property(readonly) OTConnection* connection;

/**
 * The <OTSessionDelegate> object that serves as a delegate object for this OTSession object,
 * handling messages on behalf of this session.
 */
@property(nonatomic, assign) id<OTSessionDelegate> delegate;

/**
 * The delegate callback queue is application-definable. The GCD queue for
 * issuing callbacks to the delegate may be overridden to allow integration with
 * XCTest (new in XCode 5) or other frameworks that need the to operate in the
 * main thread.
 */
@property(nonatomic, assign) dispatch_queue_t apiQueue;

/** @name Initializing and connecting to a session */

/**
 * Initialize this session with a given [session ID]( http://tokbox.com/opentok/tutorials/create-session )
 * and delegate before connecting to OpenTok. Send the <[OTSession connectWithApiKey:token:]> message
 * to connect to the session.
 *
 *
 * @param sessionId The session ID of this instance.
 * @param delegate The delegate (OTSessionDelegate) that handles messages on behalf of this session.
 *
 * @return The OTSession object, or nil if initialization fails.
 */
- (id)initWithSessionId:(NSString*)sessionId
               delegate:(id<OTSessionDelegate>)delegate;


/**
 * Once your application has a valid [token]( http://tokbox.com/opentok/tutorials/create-token ),
 * connect with your [API key](https://dashboard.tokbox.com/projects) to begin participating in an OpenTok session.
 *
 * When the session connects successfully, the <[OTSessionDelegate sessionDidConnect:]> message is sent to
 * the session's delegate.
 *
 * If the session cannot connect, the <[OTSessionDelegate session:didFailWithError:]> message is sent to
 * the session's delegate.
 *
 * When the session disconnects, the <[OTSessionDelegate sessionDidDisconnect:]> message is sent to the
 * session's delegate.
 *
 * Note that sessions automatically disconnect when the app is suspended.
 *
 * Be sure to set up a delegate method for the [OTSessionDelegate session:didFailWithError:] message. See the
 * OTSessionErrorCode emum defined in OTError.h. It defines code values for the error. An error with code
 * OTSDKUpdateRequired indicates that the OpenTok iOS SDK used to compile the app is not longer compatible
 * with the OpenTok infrastructure.
 *
 * @param apiKey Your OpenTok API key.
 * @param token The token generated for this connection.
 */
- (void)connectWithApiKey:(NSString*)apiKey
                    token:(NSString*)token;

/**
 * Disconnect from an active OpenTok session.
 *
 * This method tears down all OTPublisher and OTSubscriber objects that have been initialized.
 *
 * When the session disconnects, the <[OTSessionDelegate sessionDidDisconnect:]> message is sent to the
 * session's delegate.
 */
- (void)disconnect;

/** @name Publishing audio-video streams to a session */

/**
 * Adds a publisher to the session.
 *
 * When the publisher begins streaming data, the <[OTSessionDelegate session:streamCreated:]> message
 * is sent to the session's delegate. You can compare the `connection.connectionId` property of the
 * OTSession object with the `connection.connectionId` property of the OTStream object. If they match,
 * the stream is published from your connection.
 *
 * Also, when the publisher begins streaming data the <[OTPublisherDelegate publisherDidStartStreaming:]>
 * message is sent to the publisher's delegate.
 *
 * If publishing fails, the [OTPublisherDelegate publisher:didFailWithError:] is sent to the publisher's
 * delegate.
 *
 * When running in the XCode iOS Simulator, the <[OTPublisher initWithDelegate:]> and
 * <[OTPublisher initWithDelegate:name:]> methods return `nil`. Sending the [OTSession publish:] message to
 * `nil` results in no operation.
 *
 * Note that multiple publishers are not supported.
 *
 * @param publisher The <OTPublisher> object for the stream to be published.
 */
- (void)publish:(OTPublisherKit*) publisher;

/**
 * Removes a publisher from the session.
 *
 * Upon removing the publisher, the <[OTPublisherDelegate publisherDidStopStreaming:]> message is sent
 * to the publisher's delegate. The publisher's view is removed from its superview. Also, the
 * <[OTSessionDelegate session:connectionDestroyed:]> message is sent to the session's delegate.
 *
 * @param publisher The <OTPublisher> object to remove from the session.
 */
- (void)unpublish:(OTPublisherKit*) publisher;

- (void)subscribe:(OTSubscriberKit*)subscriber;
- (void)unsubscribe:(OTSubscriberKit*)subscriber;

/** @name Sending and receiving signals in a session */

/**
 * Sends a signal to one or more clients in a session.
 *
 * For information on charges for signaling, see the
 * [OpenTok pricing](http://tokbox.com/pricing) page.
 *
 * See <[OTSessionDelegate session:receivedSignalType:fromConnection:withString:>.
 *
 *
 * @param type The type of the signal. The type is also set in the
 * <[OTSessionDelegate session:receivedSignalType:fromConnection:withString:>
 * message.
 * @param string The data to send. The limit to the size of data is 8kB. In this
 * method, the data is specified as a string.
 * @param connections An array of OTConnection objects. Each OTConnection object
 * represents the connection of a client to the session. These are the clients
 * to which the message is sent. (See
 * <[OTSessionDelegate session:connectionCreated:]> and <OTConnection>.) Set
 * this parameter to nil to signal all participants in the session.
 * @param error If sending a signal fails, this value is set to an OTError
 * object. The OTSessionErrorCode enum (in OTError.h) includes
 * OTSessionInvalidSignalType and OTSessionSignalDataTooLong constants for these
 * errors. Note that success indicates that the options passed into the method
 * are valid and the signal was sent. It does not indicate that the signal was
 * sucessfully received by any of the intended recipients.
 */
- (void)signalWithType:(NSString*) type
                string:(NSString*)string
           connections:(NSArray*)connections
                 error:(OTError**)error;

@end

/**
 * Used to send messages for an OTSession instance. The OTSession class includes a
 * `delegate` property. When you send the <[OTSession initWithSessionId:delegate:]> message,
 * you specify an OTSessionDelegate object.
 */
@protocol OTSessionDelegate <NSObject>

/** @name Connecting to a session */

/**
 * Sent when the client connects to the session.
 *
 * @param session The <OTSession> instance that sent this message.
 */
- (void)sessionDidConnect:(OTSession*)session;

/**
 * Sent when the client disconnects from the session.
 *
 * When a session disconnects, all <OTSubscriber> and <OTPublisher> objects' views are
 * removed from their superviews.
 *
 * @param session The <OTSession> instance that sent this message.
 */
- (void)sessionDidDisconnect:(OTSession*)session;

/**
 * Sent if the session fails to connect, some time after your applications sends the
 * [OTSession connectWithApiKey:token:] message.
 *
 * @param session The <OTSession> instance that sent this message.
 * @param error An <OTError> object describing the issue. The `OTSessionErrorCode` enum
 * (defined in the OTError class) defines values for the `code` property of this object.
 */
- (void)session:(OTSession*)session didFailWithError:(OTError*)error;

/** @name Monitoring streams in a session */

/**
 * Sent when a new stream is created in this session.
 *
 * Note that if your application successfuly publishes to this session, its session delegate is sent
 * an [OTSessionDelegate session:streamCreated:] message for its own published stream.
 * You can compare the `stream.connection.connectionId` property with the `session.connection.connectionId`
 * property. (If they matches, the stream is published from your connection.)
 *
 * @param session The OTSession instance that sent this message.
 * @param stream The stream associated with this event.
 */
- (void)session:(OTSession*)session streamCreated:(OTStream*)stream;

/**
 * Sent when a stream is no longer published to the session.
 *
 * Note that if your application stops publishing a stream to the session, its session delegate is
 * sent an [OTSessionDelegate session:connectionDestroyed:] message for its own published stream.
 * You can check the stream.connection.connectionId property to see if it matches
 * the `session.connection.connectionId` property. (If it matches, the stream was
 * published from your connection.)
 *
 * When a stream is dropped, the view for any <OTSubscriber> object for the stream is
 * removed from its superview. If the stream corresponds to an <OTPublisher> object,
 * the <OTPublisher> object's view is removed from its superview.
 *
 * @param session The <OTSession> instance that sent this message.
 * @param stream The stream associated with this event.
 */
- (void)session:(OTSession*)session streamDestroyed:(OTStream*)stream;

@optional

/** @name Monitoring connections in a session */

/**
 * Sent when other client connects to the session. The `connection` object represents the client's
 * connection to the session.
 *
 * This message is not sent when your own client connects to the session. The <[OTSessionDelegate sessionDidConnect:]>
 * message is sent when your own client connects to the session.
 *
 * @param session The <OTSession> instance that sent this message.
 * @param connection The new <OTConnection> object.
 */
- (void)session:(OTSession*) session connectionCreated:(OTConnection*) connection;

/**
 * Sent when another client disconnects from the session. The `connection` object represents the connection
 * that the client had to the session.
 *
 * This message is not sent when your own client disconnects from the session. The <[OTSessionDelegate sessionDidDisconnect:]>
 * message is sent when your own client connects to the session.
 *
 * @param session The <OTSession> instance that sent this message.
 * @param connection The <OTConnection> object for the client that disconnected from the session.
 */
- (void)session:(OTSession*) session connectionDestroyed:(OTConnection*) connection;

/**
 * Sent when this client starts publishing a stream to the session.
 *
 * @param session The <OTSession> instance that sent this message.
 * @param publisher The <OTPublsiherKit> object that defines the stream being 
 * sent.
 */
- (void)session:(OTSession*)session didAddPublisher:(OTPublisherKit*)publisher;
/**
 * Sent when this client stops publishing a stream to the session.
 *
 * @param session The <OTSession> instance that sent this message.
 * @param publisher The <OTPublsiherKit> object that defines the stream that
 * stopped being sent.
 */
- (void)session:(OTSession*)session didRemovePublisher:(OTPublisherKit*)publisher;

/**
 * Sent when a message is received in the session.
 * @param session The <OTSession> instance that sent this message.
 * @param type The type string of the signal.
 * @param connection The connection identifying the client that sent the
 * message.
 * @param string The signal data.
 */
- (void)   session:(OTSession*)session
receivedSignalType:(NSString*)type
    fromConnection:(OTConnection*)connection
        withString:(NSString*)string;

@end

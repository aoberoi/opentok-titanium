# Subscriber

You can use a Subscriber object to stream audio and video from a stream in OpenTok to this device. A Subscriber is constructed by calling
[Session.subscribe(_stream_, _props_)](session.md#subscribestream-props). The Subscriber only represents the control of streaming that data,
not the UI. In order to present a view of this data, use a [VideoView](videoview.md#videoview) which can
be constructed using the [createView(_props_)](#createview_props_) method here.

<nav>
  <table>
    <tr>
      <th>Methods</th>
      <th>Properties</th>
      <th>Events</th>
    </tr>
    <tr>
      <td>[createView(_props_)](#createviewprops)</td>
      <td>[stream](#stream)</td>
      <td>["subscriberStarted"](#subscriberstarted)</td>
    </tr>
    <tr>
      <td>[close()](#close)</td>
      <td>[subscribeToAudio](#subscribetoaudio)</td>
      <td>["subscriberConnected"](#subscriberconnected)</td>
    </tr>
    <tr>
      <td></td>
      <td>[subscribeToVideo](#subscribetovideo)</td>
      <td>["subscriberFailed"](#subscriberfailed)</td>
    </tr>
    <tr>
      <td></td>
      <td>[session](#session)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[view](#view)</td>
      <td></td>
    </tr>
  </table>
</nav>

## Methods

### createView(_props_)

A subscriber can subscribe to data without being displayed in the UI. In order to display the video of the subscriber, you must create a view from it. This method creates that view. It is a subtype of Ti.UI.View.

Parameters:
*  _props_ (Dictionary) _optional_ - Properties of Ti.UI.View that are inherited by the VideoView (See [Appcelerator Docs](http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.View))

Returns: (VideoView)

### close()

Disconnects the Subscriber from the Session. The SubscriberViews associated with this Subscriber will now be invalid and should be removed from the UI.

## Properties

### stream

(Stream) The stream that this subscriber is created from. _Read Only_

### subscribeToAudio

(Boolean) Whether or not the subscriber is subscribing to audio data in the stream. _Read Only_

### subscribeToVideo

(Boolean) Whether or not the subscriber is subscribing to video data in the stream. _Read Only_

### session

(Session) The session that this subscriber is streaming data from. _Read Only_

### view

(VideoView) If [createView(_props_)](#createview_props_) has been called on this Subscriber, this property will return a reference to that same VideoView. Otherwise it returns null.

## Events

### "subscriberStarted"

This event is fired when the first frame of video or audio data has been recieved and decoded.

### "subscriberConnected"

This event is fired when the subscriber sucessfully connects to the stream.

### "subscriberFailed"

This event is fired when an error is encountered.

Event Properties:
*   _error_ (Error) - Use event.error.message to see the reason for the subscriber failing.

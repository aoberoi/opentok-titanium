# Subscriber

A Subscriber object is used to stream audio and video from a Stream in an OpenTok Session to this device. A Subscriber is constructed by calling
[Session.subscribe(_stream_, _props_)](session.md#subscribestream-props). The Subscriber only represents the control of streaming that data,
not the UI. In order to present a view of this data, use a [VideoView](videoview.md#videoview) which can be constructed using the
[createView(_props_)](#createviewprops) method of a Subscriber.

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
      <td></td>
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

A Subscriber can subscribe to data without being displayed in the UI. In order to display the video of the subscriber, you must create a
view from it. This method creates that view. It is a subtype of [Titanium.UI.View](http://docs.appcelerator.com/titanium/3.0/#!/api/Titanium.UI.View).

Parameters:
*  _props_ (Dictionary) _optional_ - Properties to be set on the view when it is created. You can set any properties you
   would on any instance of Titanium.UI.View

Returns: ([VideoView](videoview.md#videoview))

## Properties

### stream

(Stream) The Stream that this Subscriber is created from. _Read Only_

### subscribeToAudio

(Boolean) Whether or not the Subscriber is subscribing to audio data in the Stream. _Read Only_

### subscribeToVideo

(Boolean) Whether or not the Subscriber is subscribing to video data in the Stream. _Read Only_

### session

(Session) The Session that this Subscriber is streaming data from. _Read Only_

### view

(VideoView) If [createView(_props_)](#createviewprops) has been called on this Subscriber, this property
will return a reference to that same VideoView. Otherwise it returns null.

## Events

### "subscriberStarted"

This event is fired when the first frame of video or audio data has been recieved and decoded.

### "subscriberConnected"

This event is fired when the Subscriber sucessfully connects to the Stream.

### "subscriberFailed"

This event is fired when an error is encountered.

Event Properties:
*  _error_ (Dictionary):
  *  _message_ (String) - The reason for the Subscriber failing.

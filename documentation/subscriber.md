# Subscriber

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

*  Parameters:
    *  __props__ (Object) _optional_ - Properties of Ti.UI.View that are inherited by the SubscriberView (See <http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.View>)
*  Return - (SubscriberView)

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

(SubscriberView) If _subscriber.createView(props)_ has been called on this Subscriber, this property will return a reference to that same view. Otherwise it returns null.

## Events

### "subscriberStarted"

This event is fired when the first frame of video or audio data has been recieved and decoded.

### "subscriberConnected"

This event is fired when the subscriber sucessfully connects to the stream.

### "subscriberFailed"

This event is fired when an error is encountered.

*  Event Properties:
    *  event.error (Error) - Use event.error.message to see the reason for the subscriber failing.

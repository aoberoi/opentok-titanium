# Publisher

You can use a Publisher object to stream audio and video from a device to Opentok. A Publisher is constructed by calling
[Session.publish(_props_)](session.md#publishprops). The Publisher only represents the control of streaming that data,
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
      <td>[publishAudio](#publishaudio)</td>
      <td>["publisherStarted"](#publisherstarted)</td>
    </tr>
    <tr>
      <td></td>
      <td>[publishVideo](#publishvideo)</td>
      <td>["publisherStopped"](#publisherstopped)</td>
    </tr>
    <tr>
      <td></td>
      <td>[name](#name)</td>
      <td>["publisherFailed"](#publisherfailed)</td>
    </tr>
    <tr>
      <td></td>
      <td>[session](#session)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[cameraPosition](#cameraposition)</td>
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

A publisher can stream data without being displayed in the UI. In order to display the video of the publisher, you must create a view from it. This method creates that view. It is a subtype of Ti.UI.View.

Parameters:
*  _props_ (Dictionary) _optional_ - Properties of Ti.UI.View that are inherited by the PublisherView. (See [Appcelerator Docs](http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.View))

Returns: (VideoView)

## Properties

### publishAudio

(Boolean) Whether or not the publisher is publishing audio data to the session. _Read Only_

### publishVideo

(Boolean) Whether or not the publisher is publishing video data to the session. _Read Only_

### name

(String) The name that was assigned to the publisher when it was created. _Read Only_

### session

(Session) The session that this publisher is streaming data to. _Read Only_

### cameraPosition

(String) If the device contains more than one camera, this option lets you set which one the publisher should stream from. Possible values are "cameraFront" or "cameraBack".

### view

(VideoView) If [createView(_props_)](#createview_props_) has been called on the Publisher, this property will return a reference to that same VideoView. Otherwise it returns null.

## Events

### "publisherStarted"

This event is fired when the publisher begins streaming data to the session. Note that the Session will also fire the "streamCreated" event for the resulting stream.

### "publisherStopped"

This event is fired when the publisher stops streaming data to the session. Note that the Session will also fire the "streamDestroyed" event for the stream that is being removed from the Session.

### "publisherFailed"

This event is fired when an error is encountered.

Event Properties:
*   _error_ (Error) - Use _error_.message to see the reason for the publisher failing.

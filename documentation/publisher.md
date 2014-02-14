# Publisher

You can use a Publisher object to stream audio and video from a device to an OpenTok Session. A Publisher is constructed
by calling [Session.publish(_props_)](session.md#publishprops). The Publisher only represents the control of streaming that data,
not the UI. In order to present a view of this data, use a [VideoView](videoview.md#videoview) which can
be constructed using the [createView(_props_)](#createviewprops) method of a Publisher.

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

A publisher can stream data without being displayed in the UI. In order to display the video of the Publisher, you must
create a view from it. This method creates that view. It is a subtype of
[Titanium.UI.View](http://docs.appcelerator.com/titanium/3.0/#!/api/Titanium.UI.View).

Parameters:
*  _props_ (Dictionary) _optional_ - Properties to be set on the view when it is created. You can set any properties you
   would on any instance of Titanium.UI.View

Returns: ([VideoView](videoview.md#videoview))

## Properties

### publishAudio

(Boolean) Whether or not the Publisher is publishing audio data to the Session. _Read Only_

### publishVideo

(Boolean) Whether or not the Publisher is publishing video data to the Session. _Read Only_

### name

(String) The name that was assigned to the Publisher when it was created. _Read Only_

### session

(Session) The Session that this Publisher is streaming data to. _Read Only_

### cameraPosition

(String) If the device contains more than one camera, this option lets you set which one the Publisher should stream from.
Possible values are "cameraFront" or "cameraBack".

### view

(VideoView) If [createView(_props_)](#createviewprops) has been called on the Publisher, this property will return a reference
to that same VideoView. Otherwise it returns null.

## Events

### "publisherStarted"

This event is fired when the Publisher begins streaming data to the Session. Note that the Session will also fire the
"streamCreated" event for the resulting Stream.

### "publisherStopped"

This event is fired when the publisher stops streaming data to the session. Note that the Session will also fire the
"streamDestroyed" event for the stream that is being removed from the Session.

### "publisherFailed"

This event is fired when an error is encountered.

Event Properties:
*  _error_ (Dictionary):
  *  _message_ (String) - The reason for the Publisher failing.

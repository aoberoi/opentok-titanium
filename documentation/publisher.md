# Publisher

## Methods

### _publisher.createView(props)_

A publisher can stream data without being displayed in the UI. In order to display the video of the publisher, you must create a view from it. This method creates that view. It is a subtype of Ti.UI.View.

*  Parameters:
    *  __props__ (Object) _optional_ - Properties of Ti.UI.View that are inherited by the PublisherView (See <http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.View>)
*  Return - (PublisherView)

## Properties

### _publisher.publishAudio_

(Boolean) Whether or not the publisher is publishing audio data to the session. _Read Only_

### _publisher.publishVideo_

(Boolean) Whether or not the publisher is publishing video data to the session. _Read Only_

### _publisher.name_

(String) The name that was assigned to the publisher when it was created. _Read Only_

### _publisher.session_

(Session) The session that this publisher is streaming data to. _Read Only_

### _publisher.cameraPosition_

(String) If the device contains more than one camera, this option lets you set which one the publisher should stream from. Possible values are "cameraFront" or "cameraBack".

### _publisher.view_

(PublisherView) If _publisher.createView(props)_ has been called on the Publisher, this property will return a reference to that same view. Otherwise it returns null.

## Events

### _publisherStarted_

This event is fired when the publisher begins streaming data to the session. Note that the Session will also fire the "streamCreated" event for the resulting stream.

### _publisherStopped_

This event is fired when the publisher stops streaming data to the session. Note that the Session will also fire the "streamDestroyed" event for the stream that is being removed from the Session.

### _publisherFailed_

This event is fired when an error is encountered.

*  Event Properties:
    *  event.error (Error) - Use event.error.message to see the reason for the publisher failing.

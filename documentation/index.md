# opentok Module

## Description

Opentok is an API to stream live video to and from your App on mobile and on the web. [Find out more online](http://www.tokbox.com/opentok/api).

## Usage

### Accessing the module

To access this module from JavaScript, you would do the following:

```javascript
var opentok = require("com.tokbox.ti.opentok");
```

The opentok variable is a reference to the Opentok module object.	

### Connecting to a Session

In order to connect to a session, we must first create a Session object and then use it to connect. In order to configure this we need an [API Key](http://www.tokbox.com/opentok/api/tools/js/apikey), a [Token](http://www.tokbox.com/opentok/api/tools/js/documentation/overview/token_creation.html), and a [Session ID](http://www.tokbox.com/opentok/api/tools/js/documentation/overview/session_creation.html).

```javascript
var CONFIG = {
  apiKey    : '...',
  token     : '...',
  sessionId : '...'
};
var session = opentok.createSession(CONFIG.sessionId);
session.connect(CONFIG.apiKey, CONFIG.token);
```

### Publishing video to the Session

To start streaming video and audio to other users/devices in the session we must Publish. To start publishing we first create a Publisher. Then to see the video that we are publishing, we add a PublisherView to the current view. All of this can only be done once the session is connected, so we place it inside the connection handler.

```javascript
var publisher, publisherView;
session.addEventListener("sessionConnected", function(event) {
  publisher = session.publish();
  publisherView = publisher.createView({ width : 320, height : 240, top : 20 });
  // self is an instance of Ti.UI.View such as ApplicationView
  self.add(publisherView);
});
```

### Subscribing to video in a Session

To start playing a video stream from another user/device in the session we must Subscribe. To start subscribing we first create a Subscriber from the Stream. Then to see the video from that Stream, we add a SubscriberView to the current view. All of this can only be done once a Stream is created (and after the session is connected), so we place it inside the stream creation handler.

```javascript
var subscriber, subscriberView;
session.addEventListener("streamCreated", function(event) {
  var stream = event.stream;
  subscriber = session.subscribe(stream);
  subscriberView = subscriber.createView({ width : 320, height : 240, top : 20 });
  // self is an instance of Ti.UI.View such as ApplicationView
  self.add(subscriberView);
});
```

### Which Stream belongs to my device? Which Stream is coming from another device?

If you follow the example above, you will first subscribe to your own stream. It would be very useful to know when this Stream is coming from another device or from your own device. To do this, we compare the Connections of each Stream by their connectionId property.

```javascript
var subscriber, subscriberView;
session.addEventListener("streamCreated", function(event) {
  var stream = event.stream;
  // Filter out any stream that is coming from my own connection. I only want to subscribe to others
  if (stream.connection.connectionId === session.connection.connectionId) { return; }
  subscriber = session.subscriber(stream);
  subscriberView = subscriber.createView({ width : 320, height : 240, top : 20 });
  self.add(subscriberView);
});
```

## Reference

<table>
  <tr>
    <th>Module</th>
    <th>Objects</th>
    <th>Views</th>
  </tr>
  <tr>
    <td><a href="opentok.md">Opentok</a></td>
    <td><a href="session.md">Session</a></td>
    <td><a href="publisherview.md">PublisherView</a></td>
  </tr>
  <tr>
    <td></td>
    <td><a href="publisher.md">Publisher</a></td>
    <td><a href="subscriberview.md">SubscriberView</a></td>
  </tr>
  <tr>
    <td></td>
    <td><a href="subscriber.md">Subscriber</a></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td><a href="stream.md">Stream</a></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td><a href="connection.md">Connection</a></td>
    <td></td>
  </tr>
</table>

## License

Copyright (c) 2012 TokBox, Inc.
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

The software complies with Terms of Service for the OpenTok platform described 
in http://www.tokbox.com/termsofservice

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.


# Stream

A Stream represents the audio/video data coming from a Publisher on this device or on another device in the same OpenTok Session.

<nav>
  <table>
    <tr>
      <th>Methods</th>
      <th>Properties</th>
      <th>Events</th>
    </tr>
    <tr>
      <td></td>
      <td>[connection](#connection)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[creationTime](#creationtime)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[hasAudio](#hasaudio)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[hasVideo](#hasvideo)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[session](#session)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[streamId](#streamid)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[type](#type)</td>
      <td></td>
    </tr>
  </table>
</nav>

## Properties

### connection

(Connection) The Connection object that corresponds to the origin of this Stream. _Read Only_

### creationTime

(Date) The time when this Stream was created. _Read Only_

### hasAudio

(Boolean) Whether or not there is audio available in this stream. _Read Only_

### hasVideo

(Boolean) Whether or not there is video available in this stream. _Read Only_

### session

(Session) The Session object where this Stream is contained. _Read Only_

### streamId

(String) An identifier for this Stream. This is created automatically by OpenTok. _Read Only_

### type

(String) A Stream can be one of two types: "basic" or "archive". _Read Only_

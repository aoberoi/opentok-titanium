# Connection

A Connection represents one client that is connected to the [Session](session.md#session). Each device, whether it is publishing, subscribing, or just connected to a session is represented by a Connection object.

<nav>
  <table>
    <tr>
      <th>Methods</th>
      <th>Properties</th>
      <th>Events</th>
    </tr>
    <tr>
      <td></td>
      <td>[connectionId](#connectionid)</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>[creationTime](#creationtime)</td>
      <td></td>
    </tr>
  </table>
</nav>

## Properties

### connectionId

(String) An identifier for this Connection. This is created automatically by OpenTok. It is useful for comparing a `stream.connection.connectionId` to the `session.connection.connectionId`, if they are equal then the stream originates from this device. _Read Only_

### creationTime

(Date) The time the connection was created.

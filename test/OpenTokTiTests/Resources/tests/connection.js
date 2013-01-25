var opentok = require('com.tokbox.ti.opentok');

// Connects to a session
function testConnect(done, config, view) {
	var sessionId = config.sessionId,
		apiKey = config.apiKey,
		token = config.token;
	
	function sessionConnectedHandler(e) {
		done();
	}
	var session = opentok.createSession({
		sessionId: sessionId
	});
	session.addEventListener('sessionConnected', sessionConnectedHandler);
	session.connect(apiKey, token);
}

// Fires appropriate error when trying to connect to a P2P session

// Fires appropriate error when using bad apiKey or bad token

// Fires appropirate error when using a bad sessionId

// Fires appropriate error when connection fails

// Disconnects from a session
function testDisconnect(done, config, view) {
	var sessionId = config.sessionId,
		apiKey = config.apiKey,
		token = config.token;
	
	function sessionConnectedHandler(e) {
		session.disconnect();
	}
	function sessionDisconnectedHandler(e) {
		done();
	}
	var session = opentok.createSession({
		sessionId: sessionId
	});
	session.addEventListener('sessionConnected', sessionConnectedHandler);
	session.addEventListener('sessionDisconnected', sessionDisconnectedHandler);
	session.connect(apiKey, token);
}

exports.tests = [ testConnect ];

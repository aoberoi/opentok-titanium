var helloWorldUrl = "";

// Application Window Component Constructor
function ApplicationWindow() {
		
	// create component instance
	self = Ti.UI.createWindow({
		backgroundColor: '#ffffff',
		navBarHidden: true,
		exitOnClose: true,
		layout: 'vertical'
	});

  // Initialize Opentok
  var opentok = require('com.tokbox.ti.opentok');
  Ti.API.info("Opentok module is " + opentok);
  Ti.API.info("Hello World example project is available here: " + helloWorldUrl);
	return self;
}

// Treat this file as standalone application
self = ApplicationWindow();
self.open();

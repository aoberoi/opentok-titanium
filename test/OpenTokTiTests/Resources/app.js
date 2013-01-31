// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

if (Titanium.Platform.osname !== 'ipad') {
	
	// This app only works for the iPad
	var win = Titanium.UI.createWindow({
		backgroundColor: '#fff'
	});
	var label = Titanium.UI.createLabel({
		color: '#999',
		text: 'This App is meant for the iPad',
		font:{fontSize:20,fontFamily:'Helvetica Neue'},
		textAlign:'center',
		width:'auto'
	});
	win.add(label);
	win.open();
} else {
	// commonjs module inclusion
	var mocha = require('aoberoi-ti-mocha').mocha;
	
	mocha.addFile('tests/dummy');
	
	mocha.run();
	
	Titanium.API.info(mocha);
	
	// Initialize the application
	var MainWindow = require('ui/MainWindow');
	var win = new MainWindow();
	
	win.open();
}
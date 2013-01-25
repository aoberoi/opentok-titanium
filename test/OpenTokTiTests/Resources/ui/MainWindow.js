function MainWindow() {
	var ObjectTableWindow = require('ui/ObjectTableWindow'),
		objectTableWindow = new ObjectTableWindow();
	
	var blankWin = Titanium.UI.createWindow({
		backgroundColor: '#fff'
	});
	
	var self = Titanium.UI.iPad.createSplitWindow({
		detailView: blankWin,
		masterView: objectTableWindow
	});
	
	return self;
}

module.exports = MainWindow;

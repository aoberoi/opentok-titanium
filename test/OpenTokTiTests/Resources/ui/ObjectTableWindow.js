function ObjectTableWindow() {
	
	var self = Titanium.UI.createWindow();
	
	var headerView = Titanium.UI.createView({
		layout: 'vertical',
		height: Titanium.UI.SIZE
	});
	var label = Titanium.UI.createLabel({
		text: 'Repel',
		height: Titanium.UI.SIZE
	});
	var buttonContainerView = Titanium.UI.createView({
		layout: 'horizontal',
		height: Titanium.UI.SIZE
	});
	var startButton = Titanium.UI.createButton({
		title: 'Start Tests'
	});
	var stopButton = Titanium.UI.createButton({
		title: 'Stop Tests'
	});
	buttonContainerView.add(startButton);
	buttonContainerView.add(stopButton);
	headerView.add(label);
	headerView.add(buttonContainerView);
	
	var sessionSection = Titanium.UI.createTableViewSection({
		headerTitle: 'Session'
	});
	
	var streamsSection = Titanium.UI.createTableViewSection({
		headerTitle: 'Streams'
	});
	
	var connectionsSection = Titanium.UI.createTableViewSection({
		headerTitle: 'Connections'
	});
	
	var publisherSection = Titanium.UI.createTableViewSection({
		headerTitle: 'Publisher'
	});
	
	var subscribersSection = Titanium.UI.createTableViewSection({
		headerTitle: 'Subscribers'
	});
	
	var table = Titanium.UI.createTableView({
		sections: [ sessionSection, streamsSection, connectionsSection, publisherSection, subscribersSection ],
		style: Titanium.UI.iPhone.TableViewStyle.GROUPED,
		headerView: headerView
	});
	
	self.add(table);
	
	return self;
}

module.exports = ObjectTableWindow;

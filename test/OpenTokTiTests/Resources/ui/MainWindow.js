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
	
	/*
	// testing
	// TODO: does not pass any views in yet
	// TODO: config is hard-coded
	
	var config = {
		sessionId: '1_MX41MzI1MDUyfjEyNy4wLjAuMX5GcmkgSmFuIDI1IDE0OjQyOjA1IFBTVCAyMDEzfjAuNjczNTE3NX4',
		apiKey: '5325052',
		token: 'T1==cGFydG5lcl9pZD01MzI1MDUyJnNka192ZXJzaW9uPXRicnVieS10YnJiLXYwLjkxLjIwMTEtMDItMTcmc2lnPTMxYjQwMzcyZDAxMmRhNmZhYjdiYmFkMGZkMTJiYmIyMWRhOGQ3MjM6cm9sZT1wdWJsaXNoZXImc2Vzc2lvbl9pZD0xX01YNDFNekkxTURVeWZqRXlOeTR3TGpBdU1YNUdjbWtnU21GdUlESTFJREUwT2pReU9qQTFJRkJUVkNBeU1ERXpmakF1Tmpjek5URTNOWDQmY3JlYXRlX3RpbWU9MTM1OTE1MzczNyZub25jZT0wLjAxMzgxNzMzNzI0MjQ0MjYwNyZleHBpcmVfdGltZT0xMzYxNzQ1NzM3JmNvbm5lY3Rpb25fZGF0YT0='
	}
	
	function runTests(tests, cb) {
		var test, testCount, successCount = 0, failCount = 0, completionHandler, allCompleteCheck;
		
		// TODO: not handling timeout cases at all yet
		
		allCompleteCheck = function() {
			Titanium.API.error("checking for completion");
			if (successCount + failCount === testCount) {
				cb(successCount, failCount);
			}
		}
		
		completionHandler = function() {
			successCount++;
			allCompleteCheck();
		};
		
		for (var i = 0, testCount = tests.length; i < testCount; ++i) {
			test = tests[i];
			
			// run each test
			try {
				test(completionHandler, config);
			} catch (error) {
				Titanium.API.error(error.message);
				failCount++;
				allCompleteCheck();
			}
		}
		
		
	}
	
	var connectionTests = require('tests/connection');
	runTests(connectionTests.tests, function (numSuccess, numFailure) {
		Titanium.API.error("Tests complete:");
		Titanium.API.error("  "+numSuccess+" successes");
		Titanium.API.error("  "+numFailure+" failures");
	});
	*/
	
	return self;
}

module.exports = MainWindow;

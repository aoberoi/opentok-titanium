exports.injectContext = function (ctx) {
	with (ctx) {

		describe('Array#indexOf()', function() {
			it('should return -1 when the value is not present', function() {
				var temp;

				//console.log('running test now');

				if (( temp = [1, 2, 3] ).indexOf(5) !== -1) {
					console.error("[1,2,3].indexOf(5) returned " + temp);
					throw new Error("[1,2,3].indexOf(5) returned " + temp);
				}

				if (( temp = [1, 2, 3] ).indexOf(0) !== -1) {
					console.error("[1,2,3].indexOf(0) returned " + temp);
					throw new Error("[1,2,3].indexOf(0) returned " + temp);
				}

			});
		});

	}
}
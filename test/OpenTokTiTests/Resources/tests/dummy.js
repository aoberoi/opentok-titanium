exports.injectContext = function (ctx) {
	with (ctx) {
		
		
		
		describe('Array', function () {
			describe('#indexOf()', function () {
				it('should return -1 when the value is not present', function () {
					if ([1,2,3].indexOf(5) !== -1) throw new Error();
					if ([1,2,3].indexOf(0) !== -1) throw new Error();
				});
			});
		});
		
		
		
	}
}
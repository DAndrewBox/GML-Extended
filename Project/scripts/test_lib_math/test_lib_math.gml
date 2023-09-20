suite(function() {
	describe("round_dec", function() {
		it("Should round to nearest decimal", function() {
			expect(round_dec(1.125, 2)).toBe(1.13);
			expect(round_dec(1.16, 1)).toBe(1.2);
			expect(round_dec(0.49, 0)).toBe(0);
			expect(round_dec(0.51, 0)).toBe(1);
		});
	});
	
	
});
suite(function() {
	describe("round_dec", function() {
		it("Should round to nearest decimal", function() {
			expect(round_dec(1.16, 1)).toBe(1.2);
			expect(round_dec(0.49, 0)).toBe(0);
			expect(round_dec(0.51, 0)).toBe(1);
		});
	});
	
	describe("near", function() {
		it("Should return true since it's near range", function() {
			expect(near(1.50, 2, .50)).toBeTruthy();
			expect(near(500, 50, 515)).toBeTruthy();
			expect(near(1000, 50, 966)).toBeTruthy();
		});
		
		it("Should return false since it's not near range", function() {
			expect(near(3, 50, 10)).toBeFalsy();
			expect(near(8000, 10, 500)).toBeFalsy();
			expect(near(333, 335, 1.5)).toBeFalsy();
		});
	});
	
	describe("between", function() {
		it("Should return true since it's in range", function() {
			expect(between(1.50, 1, 2)).toBeTruthy();
			expect(between(500, 499.5, 500.5)).toBeTruthy();
			expect(between(6845, 0, 10000)).toBeTruthy();
		});
		
		it("Should return false since it's not in range", function() {
			expect(between(1.50, 0, 1)).toBeFalsy();
			expect(between(500, 300, 499.5)).toBeFalsy();
			expect(between(6845, 10000, 100000)).toBeFalsy();
		});
	});
	
	describe("choice_weighted", function() {
		it("Should return the selected option if weight is 100%", function() {
			var _arr_choices = ["mango", "apple", "pear"];
			var _arr_weights = [1.0, 0, 0];
			
			expect(choice_weighted(_arr_choices, _arr_weights)).toBe("mango");
			
			_arr_weights = [0.0, 0.0, 1.0];
			expect(choice_weighted(_arr_choices, _arr_weights)).toBe("pear");
		});
		
		it("Should return noone when choices or weights are not valid", function() {
			var _arr_choices = ["mango", "apple", "pear"];
			var _arr_weights = [1.0, 0, 0];
			// Feather ignore once all - This should fail and return noone
			expect(choice_weighted(_arr_choices, 1.0)).toBe(noone);
			// Feather ignore once all - This should fail and return noone
			expect(choice_weighted("mango", _arr_weights)).toBe(noone);
			expect(choice_weighted(_arr_choices, [.0, .0, .0])).toBe(noone);
		});
	});
	
	describe("range", function() {
		it("Should return a ranged array", function() {
			expect(range(10)).toBeEqual([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
			expect(range(5, 10)).toBeEqual([10, 9, 8, 7, 6, 5]);
			expect(range(10, 0, 2)).toBeEqual([0, 2, 4, 6, 8, 10]);
		});
	});
	
	describe("wrap", function() {
		it("Should return a wrapped number", function() {
			expect(wrap(10, 0, 5)).toBe(0);
			expect(wrap(200, 100, 150)).toBe(100);
			expect(wrap(-100, -200, -150)).toBe(-200);
			expect(wrap(300, 0, 255)).toBe(45);
			expect(wrap(361, 0, 360)).toBe(1);
		});
		
		it("Should return a the number without modifications", function() {
			expect(wrap(-192, -200, -150)).toBe(-192);
			expect(wrap(64, 0, 255)).toBe(64);
			expect(wrap(90, 0, 360)).toBe(90);
		});
	});
});

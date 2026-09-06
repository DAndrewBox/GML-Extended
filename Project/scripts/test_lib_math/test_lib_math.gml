suite(function() {
	describe("round_dec", function() {
		it("Should round to nearest decimal", function() {
			expect(round_dec(1.16, 1)).toBe(1.2);
			expect(round_dec(0.49, 0)).toBe(0);
			expect(round_dec(0.51, 0)).toBe(1);
		});

		it("Should default to 0 decimals", function() {
			expect(round_dec(1.49)).toBe(1);
			expect(round_dec(1.5)).toBe(2);
		});

		it("Should round negative numbers", function() {
			expect(round_dec(-1.16, 1)).toBe(-1.2);
			expect(round_dec(-0.51, 0)).toBe(-1);
		});

		it("Should keep an already rounded number as is", function() {
			expect(round_dec(5, 3)).toBe(5);
			expect(round_dec(0, 2)).toBe(0);
		});
	});

	describe("near", function() {
		it("Should return true since the value is inside the range", function() {
			expect(near(1.50, 2, .50)).toBeTruthy();
			expect(near(500, 50, 515)).toBeTruthy();
			expect(near(1000, 50, 966)).toBeTruthy();
		});

		it("Should return false since the value is outside the range", function() {
			expect(near(3, 50, 10)).toBeFalsy();
			expect(near(8000, 10, 500)).toBeFalsy();
			expect(near(333, 335, 1.5)).toBeFalsy();
		});

		it("Should treat the offset as an absolute value", function() {
			expect(near(9, 10, -2)).toBeTruthy();
			expect(near(9, 10, -0.5)).toBeFalsy();
		});

		it("Should include both bounds of the range", function() {
			expect(near(10, 15, 5)).toBeTruthy();
			expect(near(20, 15, 5)).toBeTruthy();
		});

		it("Should only match the exact value for an offset of 0", function() {
			expect(near(5, 5, 0)).toBeTruthy();
			expect(near(5.1, 5, 0)).toBeFalsy();
		});
	});

	describe("between", function() {
		it("Should return true since the value is in range", function() {
			expect(between(1.50, 1, 2)).toBeTruthy();
			expect(between(500, 499.5, 500.5)).toBeTruthy();
			expect(between(6845, 0, 10000)).toBeTruthy();
		});

		it("Should return false since the value is not in range", function() {
			expect(between(1.50, 0, 1)).toBeFalsy();
			expect(between(500, 300, 499.5)).toBeFalsy();
			expect(between(6845, 10000, 100000)).toBeFalsy();
		});

		it("Should include both bounds", function() {
			expect(between(0, 0, 10)).toBeTruthy();
			expect(between(10, 0, 10)).toBeTruthy();
		});

		it("Should return false when min is greater than max", function() {
			expect(between(5, 10, 0)).toBeFalsy();
		});

		it("Should work with negative ranges", function() {
			expect(between(-5, -10, -1)).toBeTruthy();
			expect(between(-15, -10, -1)).toBeFalsy();
		});
	});

	describe("rng", function() {
		it("Should never return true for a chance of 0", function() {
			var _hits = 0;
			repeat (250) {
				if (rng(0)) _hits++;
			}
			expect(_hits).toBe(0);
		});

		it("Should always return true for a chance of 1", function() {
			var _hits = 0;
			repeat (250) {
				if (rng(1)) _hits++;
			}
			expect(_hits).toBe(250);
		});

		it("Should stay close to the requested chance", function() {
			var _hits = 0;
			repeat (4000) {
				if (rng(0.5)) _hits++;
			}
			// A uniform roll gives ~2000 hits, a skewed one lands far outside this band.
			expect(near(_hits, 2000, 300)).toBeTruthy();
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

		it("Should return noone when both arrays have a different length", function() {
			expect(choice_weighted(["mango", "apple"], [1.0])).toBe(noone);
			expect(choice_weighted(["mango"], [0.5, 0.5])).toBe(noone);
		});

		it("Should return noone for empty arrays", function() {
			expect(choice_weighted([], [])).toBe(noone);
		});

		it("Should only ever return a value from the choices array", function() {
			var _choices = ["a", "b", "c"];
			var _weights = [0.2, 0.3, 0.5];

			repeat (250) {
				expect(contains(choice_weighted(_choices, _weights), _choices)).toBeTruthy();
			}
		});

		it("Should respect the weight distribution", function() {
			var _choices = ["a", "b"];
			var _weights = [0.8, 0.2];
			var _hits_a = 0;

			repeat (4000) {
				if (choice_weighted(_choices, _weights) == "a") _hits_a++;
			}
			expect(near(_hits_a, 3200, 300)).toBeTruthy();
		});
	});

	describe("range", function() {
		it("Should return a ranged array", function() {
			expect(range(10)).toBeEqual([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
			expect(range(5, 10)).toBeEqual([10, 9, 8, 7, 6, 5]);
			expect(range(10, 0, 2)).toBeEqual([0, 2, 4, 6, 8, 10]);
		});

		it("Should include a single value when from equals to", function() {
			expect(range(5, 5)).toBeEqual([5]);
		});

		it("Should work with negative bounds", function() {
			expect(range(-1, -4)).toBeEqual([-4, -3, -2, -1]);
			expect(range(-4, -1)).toBeEqual([-1, -2, -3, -4]);
		});

		it("Should stop before overshooting the end of the range", function() {
			expect(range(10, 0, 3)).toBeEqual([0, 3, 6, 9]);
		});

		it("Should return an empty array for a step of 0 or less", function() {
			expect(range(10, 0, 0)).toBeEqual([]);
			expect(range(10, 0, -1)).toBeEqual([]);
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

		it("Should wrap values below the minimum back to the top", function() {
			expect(wrap(-1, 0, 5)).toBe(4);
			expect(wrap(-6, 0, 5)).toBe(4);
		});

		it("Should treat max as exclusive", function() {
			expect(wrap(5, 0, 5)).toBe(0);
			expect(wrap(0, 0, 5)).toBe(0);
		});

		it("Should return min when min and max are equal", function() {
			expect(wrap(10, 3, 3)).toBe(3);
		});
	});

	describe("random_linear", function() {
		it("Should stay inside the 0 to n range", function() {
			repeat (250) {
				expect(between(random_linear(10), 0, 10)).toBeTruthy();
			}
		});

		it("Should default to a range of 0 to 1", function() {
			repeat (250) {
				expect(between(random_linear(), 0, 1)).toBeTruthy();
			}
		});
	});

	describe("random_range_linear", function() {
		it("Should stay inside the given range", function() {
			repeat (250) {
				expect(between(random_range_linear(10, 20), 10, 20)).toBeTruthy();
			}
		});

		it("Should accept the bounds in any order", function() {
			repeat (250) {
				expect(between(random_range_linear(20, 10), 10, 20)).toBeTruthy();
			}
		});

		it("Should stay inside a negative range", function() {
			repeat (250) {
				expect(between(random_range_linear(-20, -10), -20, -10)).toBeTruthy();
			}
		});
	});

	describe("percentage", function() {
		it("Should return the percentage of two values", function() {
			expect(percentage(50, 100)).toBe(50);
			expect(percentage(0, 100)).toBe(0);
			expect(percentage(100, 100)).toBe(100);
			expect(percentage(1, 4)).toBe(25);
		});

		it("Should round the result to 2 decimals", function() {
			expect(percentage(1, 3)).toBe(33.33);
			expect(percentage(2, 3)).toBe(66.67);
		});

		it("Should go over 100 when the value is bigger than the total", function() {
			expect(percentage(200, 100)).toBe(200);
		});

		it("Should return 0 when the total is 0", function() {
			expect(percentage(50, 0)).toBe(0);
		});

		it("Should return 0 when any argument is not a real", function() {
			// Feather ignore once all - This should fail and return 0
			expect(percentage("50", 100)).toBe(0);
			// Feather ignore once all - This should fail and return 0
			expect(percentage(50, "100")).toBe(0);
		});
	});

	describe("dec2hex", function() {
		it("Should convert a decimal to hex padded to 6 chars by default", function() {
			expect(dec2hex(0)).toBe("000000");
			expect(dec2hex(16)).toBe("000010");
			expect(dec2hex(255)).toBe("0000FF");
			expect(dec2hex(16777215)).toBe("FFFFFF");
		});

		it("Should honour the requested minimum length", function() {
			expect(dec2hex(255, 2)).toBe("FF");
			expect(dec2hex(255, 4)).toBe("00FF");
			expect(dec2hex(4095, 3)).toBe("FFF");
			expect(dec2hex(0, 1)).toBe("0");
		});

		it("Should not truncate a value longer than the minimum length", function() {
			expect(dec2hex(4096, 2)).toBe("1000");
			expect(dec2hex(16777215, 1)).toBe("FFFFFF");
		});

		it("Should clamp a negative value to 0", function() {
			expect(dec2hex(-1)).toBe("000000");
			expect(dec2hex(-16777215, 2)).toBe("00");
		});

		it("Should drop the decimals of the value", function() {
			expect(dec2hex(255.9)).toBe("0000FF");
			expect(dec2hex(15.5, 1)).toBe("F");
		});
	});

	describe("uuid_v4", function() {
		it("Should return a 36 char dashed string", function() {
			var _uuid = uuid_v4();

			expect(_uuid).toHaveLength(36);
			expect(string_char_at(_uuid, 9)).toBe("-");
			expect(string_char_at(_uuid, 14)).toBe("-");
			expect(string_char_at(_uuid, 19)).toBe("-");
			expect(string_char_at(_uuid, 24)).toBe("-");
		});

		it("Should carry the v4 version and variant nibbles", function() {
			repeat (25) {
				var _uuid = uuid_v4();
				expect(string_char_at(_uuid, 15)).toBe("4");
				expect(contains(string_char_at(_uuid, 20), "89ab")).toBeTruthy();
			}
		});

		it("Should return a different value on every call", function() {
			var _seen = [];
			repeat (50) {
				var _uuid = uuid_v4();
				expect(contains(_uuid, _seen)).toBeFalsy();
				array_push(_seen, _uuid);
			}
		});
	});
});

suite(function() {
	describe("easing endpoints", function() {
		it("Should return 0 at value 0 and 1 at value 1 for every easing", function() {
			var _names = [
				"easeInSine", "easeOutSine", "easeInOutSine",
				"easeInQuad", "easeOutQuad", "easeInOutQuad",
				"easeInCubic", "easeOutCubic", "easeInOutCubic",
				"easeInQuart", "easeOutQuart", "easeInOutQuart",
				"easeInQuint", "easeOutQuint", "easeInOutQuint",
				"easeInExpo", "easeOutExpo", "easeInOutExpo",
				"easeInCirc", "easeOutCirc", "easeInOutCirc",
				"easeInBack", "easeOutBack", "easeInOutBack",
				"easeInElastic", "easeOutElastic", "easeInOutElastic",
				"easeInBounce", "easeOutBounce", "easeInOutBounce",
			];
			var _len = array_length(_names);

			for (var i = 0; i < _len; i++) {
				var _fn = asset_get_index("anim_" + _names[i]);

				expect(near(script_execute(_fn, 0), 0, 0.000001)).toBeTruthy();
				expect(near(script_execute(_fn, 1), 1, 0.000001)).toBeTruthy();
			}
		});

		it("Should scale the value at 1 by the factor for every easing", function() {
			var _names = [
				"easeInSine", "easeOutSine", "easeInOutSine",
				"easeInQuad", "easeOutQuad", "easeInOutQuad",
				"easeInCubic", "easeOutCubic", "easeInOutCubic",
				"easeInQuart", "easeOutQuart", "easeInOutQuart",
				"easeInQuint", "easeOutQuint", "easeInOutQuint",
				"easeInExpo", "easeOutExpo", "easeInOutExpo",
				"easeInCirc", "easeOutCirc", "easeInOutCirc",
				"easeInBack", "easeOutBack", "easeInOutBack",
				"easeInElastic", "easeOutElastic", "easeInOutElastic",
				"easeInBounce", "easeOutBounce", "easeInOutBounce",
			];
			var _len = array_length(_names);

			for (var i = 0; i < _len; i++) {
				var _fn = asset_get_index("anim_" + _names[i]);

				expect(near(script_execute(_fn, 1, 2.5), 2.5, 0.000001)).toBeTruthy();
				expect(near(script_execute(_fn, 0, 2.5), 0, 0.000001)).toBeTruthy();
			}
		});

		it("Should default the factor to 1", function() {
			expect(anim_easeInQuad(0.5)).toBe(anim_easeInQuad(0.5, 1));
			expect(anim_easeOutBounce(0.5)).toBe(anim_easeOutBounce(0.5, 1));
		});
	});

	describe("sine", function() {
		it("Should return the expected midpoints", function() {
			expect(near(anim_easeInOutSine(0.5), 0.5, 0.000001)).toBeTruthy();
			expect(near(anim_easeInSine(0.5), 0.292893, 0.00001)).toBeTruthy();
			expect(near(anim_easeOutSine(0.5), 0.707107, 0.00001)).toBeTruthy();
		});
	});

	describe("polynomial", function() {
		it("Should return the expected midpoints", function() {
			expect(near(anim_easeInQuad(0.5), 0.25, 0.000001)).toBeTruthy();
			expect(near(anim_easeOutQuad(0.5), 0.75, 0.000001)).toBeTruthy();
			expect(near(anim_easeInOutQuad(0.5), 0.5, 0.000001)).toBeTruthy();

			expect(near(anim_easeInCubic(0.5), 0.125, 0.000001)).toBeTruthy();
			expect(near(anim_easeOutCubic(0.5), 0.875, 0.000001)).toBeTruthy();
			expect(near(anim_easeInOutCubic(0.5), 0.5, 0.000001)).toBeTruthy();

			expect(near(anim_easeInQuart(0.5), 0.0625, 0.000001)).toBeTruthy();
			expect(near(anim_easeOutQuart(0.5), 0.9375, 0.000001)).toBeTruthy();
			expect(near(anim_easeInOutQuart(0.5), 0.5, 0.000001)).toBeTruthy();

			expect(near(anim_easeInQuint(0.5), 0.03125, 0.000001)).toBeTruthy();
			expect(near(anim_easeOutQuint(0.5), 0.96875, 0.000001)).toBeTruthy();
			expect(near(anim_easeInOutQuint(0.5), 0.5, 0.000001)).toBeTruthy();
		});

		it("Should stay inside 0 and 1 across the whole curve", function() {
			for (var i = 0; i <= 20; i++) {
				var _t = i / 20;
				expect(between(anim_easeInQuad(_t), 0, 1)).toBeTruthy();
				expect(between(anim_easeOutCubic(_t), 0, 1)).toBeTruthy();
				expect(between(anim_easeInOutQuint(_t), 0, 1)).toBeTruthy();
			}
		});
	});

	describe("exponential", function() {
		it("Should return the expected midpoints", function() {
			expect(near(anim_easeInExpo(0.5), 0.03125, 0.000001)).toBeTruthy();
			expect(near(anim_easeOutExpo(0.5), 0.96875, 0.000001)).toBeTruthy();
			expect(near(anim_easeInOutExpo(0.5), 0.5, 0.000001)).toBeTruthy();
		});
	});

	describe("circ", function() {
		it("Should return the expected midpoints", function() {
			expect(near(anim_easeInCirc(0.5), 0.133975, 0.00001)).toBeTruthy();
			expect(near(anim_easeOutCirc(0.5), 0.866025, 0.00001)).toBeTruthy();
			expect(near(anim_easeInOutCirc(0.5), 0.5, 0.000001)).toBeTruthy();
		});
	});

	describe("back", function() {
		it("Should undershoot below 0 at the start of easeInBack", function() {
			expect(anim_easeInBack(0.3)).toBeLessThan(0);
		});

		it("Should overshoot above 1 near the end of easeOutBack", function() {
			expect(anim_easeOutBack(0.7)).toBeGreaterThan(1);
		});

		it("Should cross 0.5 at the midpoint of easeInOutBack", function() {
			expect(near(anim_easeInOutBack(0.5), 0.5, 0.000001)).toBeTruthy();
		});
	});

	describe("elastic", function() {
		it("Should follow the easings.net curve for easeInElastic", function() {
			expect(near(anim_easeInElastic(0.9), -0.25, 0.0001)).toBeTruthy();
			expect(near(anim_easeInElastic(1), 1, 0.000001)).toBeTruthy();
		});

		it("Should follow the easings.net curve for easeOutElastic", function() {
			expect(near(anim_easeOutElastic(0.1), 1.25, 0.0001)).toBeTruthy();
			expect(near(anim_easeOutElastic(1), 1, 0.000001)).toBeTruthy();
		});

		it("Should cross 0.5 at the midpoint of easeInOutElastic", function() {
			expect(near(anim_easeInOutElastic(0.5), 0.5, 0.000001)).toBeTruthy();
		});

		it("Should overshoot past 1 before settling on easeOutElastic", function() {
			expect(anim_easeOutElastic(0.2)).toBeGreaterThan(1);
		});
	});

	describe("bounce", function() {
		it("Should return the expected midpoints", function() {
			expect(near(anim_easeOutBounce(0.5), 0.765625, 0.000001)).toBeTruthy();
			expect(near(anim_easeInBounce(0.5), 0.234375, 0.000001)).toBeTruthy();
			expect(near(anim_easeInOutBounce(0.5), 0.5, 0.000001)).toBeTruthy();
		});

		it("Should mirror easeOutBounce in easeInBounce", function() {
			for (var i = 0; i <= 10; i++) {
				var _t = i / 10;
				expect(near(anim_easeInBounce(_t), 1 - anim_easeOutBounce(1 - _t), 0.000001)).toBeTruthy();
			}
		});

		it("Should stay inside 0 and 1 across the whole curve", function() {
			for (var i = 0; i <= 20; i++) {
				var _t = i / 20;
				expect(between(anim_easeOutBounce(_t), 0, 1)).toBeTruthy();
				expect(between(anim_easeInBounce(_t), 0, 1)).toBeTruthy();
				expect(between(anim_easeInOutBounce(_t), 0, 1)).toBeTruthy();
			}
		});
	});
});

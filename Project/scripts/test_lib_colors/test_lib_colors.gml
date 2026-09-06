suite(function() {
	describe("rgb", function() {
		it("Should return RGB color correctly", function() {
			expect(rgb(0, 0, 0)).toBe(make_color_rgb(0, 0, 0));
			expect(rgb(128, 128, 128)).toBe(make_colour_rgb(128, 128, 128));
			expect(rgb(255, 255, 255)).toBe(make_colour_rgb(255, 255, 255));
			expect(rgb(256, 257, 258)).toBe(make_colour_rgb(0, 1, 2));
		});

		it("Should wrap negative channels back into the 0 to 255 range", function() {
			expect(rgb(-1, -2, -3)).toBe(make_colour_rgb(255, 254, 253));
		});

		it("Should drop the decimals of a channel", function() {
			expect(rgb(10.9, 20.9, 30.9)).toBe(make_colour_rgb(10, 20, 30));
		});
	});

	describe("hsv", function() {
		it("Should return HSV color correctly", function() {
			expect(hsv(0, 0, 0)).toBe(make_color_hsv(0, 0, 0));
			expect(hsv(128, 128, 128)).toBe(make_colour_hsv(128, 128, 128));
			expect(hsv(255, 255, 255)).toBe(make_colour_hsv(255, 255, 255));
			expect(hsv(256, 257, 258)).toBe(make_colour_hsv(0, 1, 2));
		});

		it("Should wrap negative channels back into the 0 to 255 range", function() {
			expect(hsv(-1, -1, -1)).toBe(make_colour_hsv(255, 255, 255));
		});
	});

	describe("color_get_rgb", function() {
		it("Should return RGB arrays correctly", function() {
			expect(color_get_rgb(c_black)).toBe([0, 0, 0]);
			expect(color_get_rgb(c_white)).toBe([255, 255, 255]);
			expect(color_get_rgb(#FF0000)).toBe([255, 0, 0]);
			expect(color_get_rgb(#FF00FF)).toBe([255, 0, 255]);
		});

		it("Should read back the channels given to rgb", function() {
			expect(color_get_rgb(rgb(10, 20, 30))).toBe([10, 20, 30]);
		});
	});

	describe("color_get_hsv", function() {
		it("Should return HSV arrays correctly", function() {
			expect(color_get_hsv(c_black)).toBe([0, 0, 0]);
			expect(color_get_hsv(c_white)).toBe([0, 0, 255]);
			expect(color_get_hsv(#FF0000)).toBe([0, 255, 255]);
			expect(color_get_hsv(#FF00FF)).toBe([212.50, 255, 255]);
		});
	});

	describe("color_get_rgb_normalized", function() {
		it("Should return RGB arrays correctly", function() {
			expect(color_get_rgb_normalized(c_black)).toBe([0, 0, 0]);
			expect(color_get_rgb_normalized(c_white)).toBe([1, 1, 1]);
			expect(color_get_rgb_normalized(#FF0000)).toBe([1, 0, 0]);
			expect(color_get_rgb_normalized(#FF00FF)).toBe([1, 0, 1]);
		});

		it("Should divide every channel by 255", function() {
			var _normalized = color_get_rgb_normalized(rgb(51, 102, 153));

			expect(near(_normalized[0], 0.2, 0.0001)).toBeTruthy();
			expect(near(_normalized[1], 0.4, 0.0001)).toBeTruthy();
			expect(near(_normalized[2], 0.6, 0.0001)).toBeTruthy();
		});
	});

	describe("color_get_hsv_normalized", function() {
		it("Should return HSV arrays correctly", function() {
			expect(color_get_hsv_normalized(c_black)).toBe([0, 0, 0]);
			expect(color_get_hsv_normalized(c_white)).toBe([0, 0, 1]);
			expect(color_get_hsv_normalized(#FF0000)).toBe([0, 1, 1]);
			expect(color_get_hsv_normalized(#FF00FF)).toBe([0.83333333333, 1, 1]);
		});
	});

	describe("color_to_hex_rgb", function() {
		it("Should return HEX string of Decimal", function() {
			expect(color_to_hex_rgb(c_black)).toBe("000000");
			expect(color_to_hex_rgb(c_white)).toBe("FFFFFF");
			expect(color_to_hex_rgb(#FF0000)).toBe("FF0000");
		});

		it("Should keep the red, green and blue channels in order", function() {
			expect(color_to_hex_rgb(#00FF00)).toBe("00FF00");
			expect(color_to_hex_rgb(#0000FF)).toBe("0000FF");
			expect(color_to_hex_rgb(rgb(18, 52, 86))).toBe("123456");
		});
	});

	describe("color_to_hex_rgba", function() {
		it("Should return the HEX string of a RGBA decimal", function() {
			expect(color_to_hex_rgba(c_black)).toBe("000000FF");
			expect(color_to_hex_rgba(c_white, 1.0)).toBe("FFFFFFFF");
			expect(color_to_hex_rgba(#FF0000, 0.5)).toBe("FF00007F");
		});

		it("Should return a fully transparent alpha for 0", function() {
			expect(color_to_hex_rgba(c_white, 0)).toBe("FFFFFF00");
		});

		it("Should always return 8 chars", function() {
			expect(color_to_hex_rgba(c_black, 0.25)).toHaveLength(8);
			expect(color_to_hex_rgba(#123456, 0.75)).toHaveLength(8);
		});
	});

	describe("color_hex_rgba_to_abgr", function() {
		it("Should return an HEX RGBA input to an HEX RGB string", function() {
			expect(color_hex_rgba_to_abgr("AABBCCFF")).toBe("FFCCBBAA");
			expect(color_hex_rgba_to_abgr("001122FF")).toBe("FF221100");
			expect(color_hex_rgba_to_abgr("01234567")).toBe("67452301");
		});

		it("Should also reverse a 6 char RGB input", function() {
			expect(color_hex_rgba_to_abgr("AABBCC")).toBe("CCBBAA");
		});

		it("Should return an empty string for an empty input", function() {
			expect(color_hex_rgba_to_abgr("")).toBe("");
		});

		it("Should be its own inverse", function() {
			expect(color_hex_rgba_to_abgr(color_hex_rgba_to_abgr("AABBCCDD"))).toBe("AABBCCDD");
		});
	});

	describe("color_rgba_get_alpha", function() {
		it("Should return the alpha of a decimal value input", function() {
			expect(color_rgba_get_alpha($FFFFFFFF)).toBe(1.0);
		});

		it("The alpha value should be near 0.01", function() {
			expect(near(color_rgba_get_alpha($7F000000), 0.50, 0.01)).toBeTruthy();
		});

		it("Should return 0 when there is no alpha byte", function() {
			expect(color_rgba_get_alpha($00FFFFFF)).toBe(0);
			expect(color_rgba_get_alpha($FFFFFF)).toBe(0);
		});

		it("Should ignore the color channels", function() {
			expect(color_rgba_get_alpha($FF000000)).toBe(1.0);
			expect(color_rgba_get_alpha($FFFFFFFF)).toBe(color_rgba_get_alpha($FF000000));
		});
	});

	describe("dec_rgb2rgba", function() {
		it("Should add a full alpha byte by default", function() {
			expect(dec_rgb2rgba(#FFFFFF)).toBe($FFFFFFFF);
		});

		it("Should add the given normalized alpha", function() {
			expect(color_rgba_get_alpha(dec_rgb2rgba(#123456, 0))).toBe(0);
			expect(near(color_rgba_get_alpha(dec_rgb2rgba(#123456, 0.5)), 0.5, 0.01)).toBeTruthy();
		});

		it("Should keep the original color channels", function() {
			expect(dec_rgb2rgba(#123456, 0) & $FFFFFF).toBe(#123456);
		});
	});
});

suite(function() {
	describe("rgb", function() {
		it("Should return RGB color correctly", function() {
			expect(rgb(0, 0, 0)).toBe(make_color_rgb(0, 0, 0));
			expect(rgb(128, 128, 128)).toBe(make_colour_rgb(128, 128, 128));
			expect(rgb(255, 255, 255)).toBe(make_colour_rgb(255, 255, 255));
			expect(rgb(256, 257, 258)).toBe(make_colour_rgb(0, 1, 2));
		});
	});
	
	describe("hsv", function() {
		it("Should return HSV color correctly", function() {
			expect(hsv(0, 0, 0)).toBe(make_color_hsv(0, 0, 0));
			expect(hsv(128, 128, 128)).toBe(make_colour_hsv(128, 128, 128));
			expect(hsv(255, 255, 255)).toBe(make_colour_hsv(255, 255, 255));
			expect(hsv(256, 257, 258)).toBe(make_colour_hsv(0, 1, 2));
		});
	});
	
	describe("color_get_rgb", function() {
		it("Should return RGB arrays correctly", function() {
			expect(color_get_rgb(c_black)).toBe([0, 0, 0]);
			expect(color_get_rgb(c_white)).toBe([255, 255, 255]);
			expect(color_get_rgb(#FF0000)).toBe([255, 0, 0]);
			expect(color_get_rgb(#FF00FF)).toBe([255, 0, 255]);
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
	});
	
	describe("color_to_hex_rgba", function() {
		it("Should return the HEX string of a RGBA decimal", function() {
			expect(color_to_hex_rgba(c_black)).toBe("000000FF");
			expect(color_to_hex_rgba(c_white, 1.0)).toBe("FFFFFFFF");
			expect(color_to_hex_rgba(#FF0000, 0.5)).toBe("FF00007F");
		});
	});
	
	describe("color_hex_rgba_to_abgr", function() {
		it("Should return an HEX RGBA input to an HEX RGB string", function() {
			expect(color_hex_rgba_to_abgr("AABBCCFF")).toBe("FFCCBBAA");
			expect(color_hex_rgba_to_abgr("001122FF")).toBe("FF221100");
			expect(color_hex_rgba_to_abgr("01234567")).toBe("67452301");
		});
	});
	
	describe("color_rgba_get_alpha", function() {
		it("Should return the alpha of a decimal value input", function() {
			expect(color_rgba_get_alpha($FFFFFFFF)).toBe(1.0);
		});
		
		it("The alpha value should be near 0.01", function() {
			expect(near(color_rgba_get_alpha($7F000000), 0.50, 0.01)).toBeTruthy();
		});
	});
});
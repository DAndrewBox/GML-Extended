suite(function() {
	describe("string_contains", function() {
		it("Should find the substrings in the string", function() {
			var _str = "Hello World, this is a test!";
			expect(string_contains(_str, "World")).toBeTruthy();
			expect(string_contains(_str, "this")).toBeTruthy();
			expect(string_contains(_str, "test")).toBeTruthy();
			expect(string_contains(_str, "!")).toBeTruthy();
			expect(string_contains(_str, "ell")).toBeTruthy();
		});
		
		it("Should not find the substrings in the string", function() {
			var _str = "Hello World, this is a test!";
			expect(string_contains(_str, "testing")).toBeFalsy();
			expect(string_contains(_str, "average")).toBeFalsy();
			expect(string_contains(_str, "not")).toBeFalsy();
			expect(string_contains(_str, "?")).toBeFalsy();
		});
	});
	
	describe("string_title", function() {
		it("Should apply title format to string", function() {
			expect(string_title("hello world!")).toBe("Hello World!");
			expect(string_title("this is a test")).toBe("This Is A Test");
			expect(string_title("THIS SHOULD NOT CHANGE")).toBe("THIS SHOULD NOT CHANGE");
			expect(string_title("NeithER ThIs")).toBe("NeithER ThIs");
		});
	});
});
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
	
	describe("string_remove", function() {
		it("Should remove text from string", function() {
			var _str = "Hello World, this is a test!";
			expect(string_remove(_str, "World")).toBe("Hello , this is a test!");
			expect(string_remove(_str, "test")).toBe("Hello World, this is a !");
			expect(string_remove(_str, ", this is a test!")).toBe("Hello World");
			expect(string_remove(_str, ["Hello", "World", "!"])).toBe(" , this is a test");
		});
		
		it("Should not remove any text", function() {
			var _str = "Hello World, this is a test!";
			expect(string_remove(_str, "?")).toBe(_str);
			expect(string_remove(_str, "not in text")).toBe(_str);
		});
	});
	
	describe("string_pad_left", function() {
		it("Should add chars at the start", function() {
			expect(string_pad_left("Hello World", " ", 20)).toBe("         Hello World");
			expect(string_pad_left("Hello World", "X", 20)).toBe("XXXXXXXXXHello World");
			expect(string_pad_left("Hello World", "_", 15)).toBe("____Hello World");
			expect(string_pad_left("Hello World", "!", 25)).toBe("!!!!!!!!!!!!!!Hello World");
		});
		
		it("Should not add chars at the start", function() {
			expect(string_pad_left("Hello World", " ", 5)).toBe("Hello World");
			expect(string_pad_left("Hello World", "X", 10)).toBe("Hello World");
			expect(string_pad_left("Hello World", "", 20)).toBe("Hello World");
		});
	});
	
	describe("string_pad_right", function() {
		it("Should add chars at the start", function() {
			expect(string_pad_right("Hello World", " ", 20)).toBe("Hello World         ");
			expect(string_pad_right("Hello World", "X", 20)).toBe("Hello WorldXXXXXXXXX");
			expect(string_pad_right("Hello World", "_", 15)).toBe("Hello World____");
			expect(string_pad_right("Hello World", "!", 25)).toBe("Hello World!!!!!!!!!!!!!!");
		});
		
		it("Should not add chars at the start", function() {
			expect(string_pad_right("Hello World", " ", 5)).toBe("Hello World");
			expect(string_pad_right("Hello World", "X", 10)).toBe("Hello World");
			expect(string_pad_right("Hello World", "", 20)).toBe("Hello World");
		});
	});
});
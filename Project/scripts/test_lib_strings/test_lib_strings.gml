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

		it("Should be case sensitive", function() {
			expect(string_contains("Hello World", "hello")).toBeFalsy();
			expect(string_contains("Hello World", "Hello")).toBeTruthy();
		});

		it("Should match the whole string and the first character", function() {
			expect(string_contains("abc", "abc")).toBeTruthy();
			expect(string_contains("abc", "a")).toBeTruthy();
			expect(string_contains("abc", "c")).toBeTruthy();
		});

		it("Should not find anything in an empty string", function() {
			expect(string_contains("", "a")).toBeFalsy();
		});
	});

	describe("string_title", function() {
		it("Should apply title format to string", function() {
			expect(string_title("hello world!")).toBe("Hello World!");
			expect(string_title("this is a test")).toBe("This Is A Test");
			expect(string_title("THIS SHOULD NOT CHANGE")).toBe("THIS SHOULD NOT CHANGE");
			expect(string_title("NeithER ThIs")).toBe("NeithER ThIs");
		});

		it("Should capitalize after repeated spaces", function() {
			expect(string_title("a  b")).toBe("A  B");
			expect(string_title("one   two")).toBe("One   Two");
		});

		it("Should capitalize the word after a leading space", function() {
			expect(string_title(" hi there")).toBe(" Hi There");
		});

		it("Should only split words on spaces", function() {
			expect(string_title("hello-world")).toBe("Hello-world");
			expect(string_title("123 abc")).toBe("123 Abc");
		});

		it("Should return an empty string as is", function() {
			expect(string_title("")).toBe("");
		});

		it("Should capitalize a single character", function() {
			expect(string_title("a")).toBe("A");
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

		it("Should remove every occurrence of the substring", function() {
			expect(string_remove("aXbXcX", "X")).toBe("abc");
			expect(string_remove("aaa", "a")).toBe("");
		});

		it("Should return the string as is for an empty array", function() {
			expect(string_remove("Hello World", [])).toBe("Hello World");
		});

		it("Should be case sensitive", function() {
			expect(string_remove("Hello hello", "hello")).toBe("Hello ");
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

		it("Should not pad when the size already matches the string", function() {
			expect(string_pad_left("abc", "-", 3)).toBe("abc");
		});

		it("Should not pad for a size of 0 or less", function() {
			expect(string_pad_left("abc", "-", 0)).toBe("abc");
			expect(string_pad_left("abc", "-", -5)).toBe("abc");
		});

		it("Should convert a non string value before padding", function() {
			expect(string_pad_left(42, "0", 5)).toBe("00042");
		});

		it("Should pad an empty string", function() {
			expect(string_pad_left("", "0", 3)).toBe("000");
		});
	});

	describe("string_pad_right", function() {
		it("Should add chars at the end", function() {
			expect(string_pad_right("Hello World", " ", 20)).toBe("Hello World         ");
			expect(string_pad_right("Hello World", "X", 20)).toBe("Hello WorldXXXXXXXXX");
			expect(string_pad_right("Hello World", "_", 15)).toBe("Hello World____");
			expect(string_pad_right("Hello World", "!", 25)).toBe("Hello World!!!!!!!!!!!!!!");
		});

		it("Should not add chars at the end", function() {
			expect(string_pad_right("Hello World", " ", 5)).toBe("Hello World");
			expect(string_pad_right("Hello World", "X", 10)).toBe("Hello World");
			expect(string_pad_right("Hello World", "", 20)).toBe("Hello World");
		});

		it("Should not pad when the size already matches the string", function() {
			expect(string_pad_right("abc", "-", 3)).toBe("abc");
		});

		it("Should not pad for a size of 0 or less", function() {
			expect(string_pad_right("abc", "-", 0)).toBe("abc");
			expect(string_pad_right("abc", "-", -5)).toBe("abc");
		});

		it("Should convert a non string value before padding", function() {
			expect(string_pad_right(42, "0", 5)).toBe("42000");
		});

		it("Should pad an empty string", function() {
			expect(string_pad_right("", "0", 3)).toBe("000");
		});
	});

	describe("string_percentage", function() {
		it("Should return the percentage with a percent sign", function() {
			expect(string_percentage(50, 100)).toBe("50%");
			expect(string_percentage(0, 100)).toBe("0%");
			expect(string_percentage(100, 100)).toBe("100%");
			expect(string_percentage(1, 4)).toBe("25%");
		});

		it("Should go over 100% when the value is bigger than the total", function() {
			expect(string_percentage(300, 100)).toBe("300%");
		});

		it("Should return 0% when the total is 0", function() {
			expect(string_percentage(50, 0)).toBe("0%");
		});
	});
});

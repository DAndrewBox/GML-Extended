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

	describe("string_remove_duplicate_chars", function() {
		it("Should collapse repeated spaces by default", function() {
			expect(string_remove_duplicate_chars("a  b")).toBe("a b");
			expect(string_remove_duplicate_chars("one     two")).toBe("one two");
			expect(string_remove_duplicate_chars("  lead and trail  ")).toBe(" lead and trail ");
		});

		it("Should collapse any given character", function() {
			expect(string_remove_duplicate_chars("a..b", ".")).toBe("a.b");
			expect(string_remove_duplicate_chars("a.....b", ".")).toBe("a.b");
			expect(string_remove_duplicate_chars("x---y", "-")).toBe("x-y");
		});

		it("Should collapse every run in the string", function() {
			expect(string_remove_duplicate_chars("a  b   c    d")).toBe("a b c d");
			expect(string_remove_duplicate_chars("..a..b..", ".")).toBe(".a.b.");
		});

		it("Should leave a string without repeats untouched", function() {
			expect(string_remove_duplicate_chars("a b c")).toBe("a b c");
			expect(string_remove_duplicate_chars("no dots here", ".")).toBe("no dots here");
		});

		it("Should keep the other characters as they are", function() {
			expect(string_remove_duplicate_chars("aaa  bbb", " ")).toBe("aaa bbb");
		});

		it("Should collapse a multi character sequence", function() {
			expect(string_remove_duplicate_chars("aXYXYb", "XY")).toBe("aXYb");
			expect(string_remove_duplicate_chars("XYXYXY", "XY")).toBe("XY");
		});

		it("Should handle empty inputs", function() {
			expect(string_remove_duplicate_chars("", " ")).toBe("");
			expect(string_remove_duplicate_chars("a  b", "")).toBe("a  b");
		});

		it("Should collapse a string made only of the character", function() {
			expect(string_remove_duplicate_chars("     ")).toBe(" ");
		});

		it("Should convert a non string value first", function() {
			expect(string_remove_duplicate_chars(1100, "0")).toBe("110");
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

	describe("string_truncate", function() {
		it("Should leave a short enough string untouched", function() {
			expect(string_truncate("Hello", 10)).toBe("Hello");
			expect(string_truncate("Hello", 5)).toBe("Hello");
		});

		it("Should cut the string and add the suffix", function() {
			expect(string_truncate("Hello World", 8)).toBe("Hello...");
			expect(string_truncate("abcdefghij", 5)).toBe("ab...");
		});

		it("Should never return more than max_length chars", function() {
			expect(string_truncate("Hello World", 8)).toHaveLength(8);
			expect(string_truncate("Hello World", 4)).toHaveLength(4);
			expect(string_truncate("Hello World", 1)).toHaveLength(1);
		});

		it("Should use a custom suffix", function() {
			expect(string_truncate("Hello World", 7, "~")).toBe("Hello ~");
			expect(string_truncate("Hello World", 6, "")).toBe("Hello ");
		});

		it("Should cut the suffix when it does not fit", function() {
			expect(string_truncate("Hello World", 2)).toBe("..");
			expect(string_truncate("Hello World", 3)).toBe("...");
		});

		it("Should return an empty string for a max length of 0 or less", function() {
			expect(string_truncate("Hello", 0)).toBe("");
			expect(string_truncate("Hello", -5)).toBe("");
		});

		it("Should convert a non string value first", function() {
			expect(string_truncate(1234567, 5)).toBe("12...");
		});
	});

	describe("string_to_snake", function() {
		it("Should convert spaced words", function() {
			expect(string_to_snake("Hello World")).toBe("hello_world");
			expect(string_to_snake("this is a test")).toBe("this_is_a_test");
		});

		it("Should convert camelCase and PascalCase", function() {
			expect(string_to_snake("helloWorld")).toBe("hello_world");
			expect(string_to_snake("HelloWorld")).toBe("hello_world");
			expect(string_to_snake("myVariableName")).toBe("my_variable_name");
		});

		it("Should convert dashes and keep single underscores", function() {
			expect(string_to_snake("hello-world")).toBe("hello_world");
			expect(string_to_snake("hello_world")).toBe("hello_world");
		});

		it("Should collapse repeated separators", function() {
			expect(string_to_snake("hello   world")).toBe("hello_world");
			expect(string_to_snake("hello -_ world")).toBe("hello_world");
		});

		it("Should not start with a separator", function() {
			expect(string_to_snake("  hello")).toBe("hello");
			expect(string_to_snake("_hello")).toBe("hello");
		});

		it("Should keep digits as part of the word", function() {
			expect(string_to_snake("item2Name")).toBe("item2_name");
		});

		it("Should handle an empty string", function() {
			expect(string_to_snake("")).toBe("");
		});
	});

	describe("string_to_camel", function() {
		it("Should convert snake_case and spaced words", function() {
			expect(string_to_camel("hello_world")).toBe("helloWorld");
			expect(string_to_camel("hello world")).toBe("helloWorld");
			expect(string_to_camel("this is a test")).toBe("thisIsATest");
		});

		it("Should lowercase the first letter", function() {
			expect(string_to_camel("HelloWorld")).toBe("helloWorld");
			expect(string_to_camel("Hello World")).toBe("helloWorld");
		});

		it("Should convert dashes", function() {
			expect(string_to_camel("hello-world-again")).toBe("helloWorldAgain");
		});

		it("Should collapse repeated separators", function() {
			expect(string_to_camel("hello___world")).toBe("helloWorld");
			expect(string_to_camel("hello   world")).toBe("helloWorld");
		});

		it("Should ignore leading separators", function() {
			expect(string_to_camel("_hello_world")).toBe("helloWorld");
			expect(string_to_camel("  hello world")).toBe("helloWorld");
		});

		it("Should handle an empty string", function() {
			expect(string_to_camel("")).toBe("");
		});

		it("Should be reversible with string_to_snake", function() {
			expect(string_to_snake(string_to_camel("my_long_key_name"))).toBe("my_long_key_name");
		});
	});

	describe("string_slugify", function() {
		it("Should lowercase and join words with a dash", function() {
			expect(string_slugify("Hello World")).toBe("hello-world");
			expect(string_slugify("My Cool Game Title")).toBe("my-cool-game-title");
		});

		it("Should drop the special characters", function() {
			expect(string_slugify("Hello, World!")).toBe("hello-world");
			expect(string_slugify("what?? really!!")).toBe("what-really");
		});

		it("Should keep the allowed characters", function() {
			expect(string_slugify("hello_world", "_")).toBe("hello_world");
			expect(string_slugify("a.b.c", ".")).toBe("a.b.c");
			expect(string_slugify("keep_this.and-that", "_.")).toBe("keep_this.and-that");
		});

		it("Should keep digits", function() {
			expect(string_slugify("Level 42 Boss")).toBe("level-42-boss");
		});

		it("Should collapse runs of removed characters", function() {
			expect(string_slugify("a   b")).toBe("a-b");
			expect(string_slugify("a - ? - b")).toBe("a-b");
		});

		it("Should not start or end with a separator", function() {
			expect(string_slugify("  Hello World  ")).toBe("hello-world");
			expect(string_slugify("!!!Hello!!!")).toBe("hello");
		});

		it("Should use a custom separator", function() {
			expect(string_slugify("Hello World", "", "_")).toBe("hello_world");
			expect(string_slugify("Hello World", "", "")).toBe("helloworld");
		});

		it("Should return an empty string when nothing is kept", function() {
			expect(string_slugify("!!!")).toBe("");
			expect(string_slugify("")).toBe("");
		});
	});

});

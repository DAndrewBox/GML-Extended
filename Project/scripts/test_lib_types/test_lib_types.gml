suite(function() {
	describe("str", function() {
		it("Should return a string of a value", function() {
			expect(str(123456)).toBe("123456");
			expect(str("asdf")).toBe("asdf");
			expect(str([0, 1, 2])).toBe("[ 0,1,2 ]");
			expect(str({key: "value"})).toBe("{ key : \"value\" }");
		});

		it("Should return a string for undefined", function() {
			expect(str(undefined)).toBe("undefined");
		});

		it("Should return an empty string as is", function() {
			expect(str("")).toBe("");
		});
	});

	describe("int", function() {
		it("Should return a value as integer", function() {
			expect(int(100)).toBe(100);
			expect(int(33.25)).toBe(33);
			expect(int(10.66)).toBe(10);
		});

		it("Should return 0 for values below 1", function() {
			expect(int(0.99)).toBe(0);
			expect(int(0)).toBe(0);
		});

		it("Should convert a numeric string", function() {
			expect(int("33.9")).toBe(33);
			expect(int("100")).toBe(100);
		});

		it("Should truncate towards zero for negative values", function() {
			expect(int(-33.25)).toBe(-33);
			expect(int(-10.99)).toBe(-10);
			expect(int(-100)).toBe(-100);
			expect(int(-0.5)).toBe(0);
		});

		it("Should drop the same decimals on both signs", function() {
			expect(int(7.75)).toBe(-int(-7.75));
		});
	});

	describe("int8", function() {
		it("Should return a value as 8-bit integer", function() {
			expect(int8(64)).toBe(64);
			expect(int8(128)).toBe(128);
			expect(int8(255)).toBe(255);
			expect(int8(256)).toBe(0);
			expect(int8(-128)).toBe(128);
		});

		it("Should wrap the bounds of the range", function() {
			expect(int8(0)).toBe(0);
			expect(int8(-1)).toBe(255);
			expect(int8(257)).toBe(1);
			expect(int8(512)).toBe(0);
		});

		it("Should drop the decimals before wrapping", function() {
			expect(int8(64.9)).toBe(64);
		});
	});

	describe("int16", function() {
		it("Should return a value as 16-bit integer", function() {
			expect(int16(0)).toBe(0);
			expect(int16(128)).toBe(128);
			expect(int16(65536)).toBe(0);
			expect(int16(-32768)).toBe(32768);
			expect(int16(-65536)).toBe(0);
		});

		it("Should wrap the bounds of the range", function() {
			expect(int16(65535)).toBe(65535);
			expect(int16(-1)).toBe(65535);
			expect(int16(65537)).toBe(1);
		});
	});

	describe("int8s", function() {
		it("Should return a value as signed 8-bit integer", function() {
			expect(int8s(64)).toBe(64);
			expect(int8s(128)).toBe(-128);
			expect(int8s(256)).toBe(0);
			expect(int8s(-128)).toBe(-128);
			expect(int8s(-256)).toBe(0);
		});

		it("Should wrap the bounds of the range", function() {
			expect(int8s(127)).toBe(127);
			expect(int8s(-129)).toBe(127);
			expect(int8s(129)).toBe(-127);
		});
	});

	describe("int16s", function() {
		it("Should return a value as signed 16-bit integer", function() {
			expect(int16s(0)).toBe(0);
			expect(int16s(65536)).toBe(0);
			expect(int16s(-32768)).toBe(-32768);
			expect(int16s(32768)).toBe(-32768);
			expect(int16s(-65536)).toBe(0);
		});

		it("Should wrap the bounds of the range", function() {
			expect(int16s(32767)).toBe(32767);
			expect(int16s(-32769)).toBe(32767);
			expect(int16s(32769)).toBe(-32767);
		});
	});

	describe("is_type", function() {
		it("Should return true for numbers", function() {
			expect(is_type(123, gm_type_number)).toBeTruthy();
			expect(is_type(1.25, gm_type_number)).toBeTruthy();
			expect(is_type(-500, gm_type_number)).toBeTruthy();
		});

		it("Should return true for strings", function() {
			expect(is_type("Hello World", gm_type_string)).toBeTruthy();
			expect(is_type("Hello" + "World", gm_type_string)).toBeTruthy();
			expect(is_type($"{"Hello"} World", gm_type_string)).toBeTruthy();
		});

		it("Should return true for arrays", function() {
			expect(is_type([1, 2, 3, 4, 5], gm_type_array)).toBeTruthy();
			expect(is_type(["a", "b", "c"], gm_type_array)).toBeTruthy();
		});

		it("Should return true for bool", function() {
			expect(is_type(true, gm_type_bool)).toBeTruthy();
			expect(is_type(false, gm_type_bool)).toBeTruthy();
		});

		it("Should return true for structs", function() {
			expect(is_type({hello: "world"}, gm_type_struct)).toBeTruthy();
		});

		it("Should return true for method", function() {
			var _method = function () { _do = "_nothing" };
			expect(is_type(_method, gm_type_method)).toBeTruthy();
		});

		it("Should return true for undefined", function() {
			var _undefined = undefined;
			expect(is_type(_undefined, gm_type_undefined)).toBeTruthy();
		});

		it("Should return true for pointers", function() {
			var _variable = 12346;
			var _ptr = ptr(_variable);
			expect(is_type(_ptr, gm_type_pointer)).toBeTruthy();
		});

		it("Should return true for 64-bit integers", function() {
			expect(is_type(int64(500), gm_type_int64)).toBeTruthy();
		});

		it("Should return true for multiple types", function() {
			expect(is_type(123465, [gm_type_pointer, gm_type_number])).toBeTruthy();
			expect(is_type("asdf", [gm_type_string, gm_type_number])).toBeTruthy();
			expect(is_type("asdf", [gm_type_struct, gm_type_number])).toBeFalsy();
		});

		it("Should return false for a mismatched type", function() {
			expect(is_type(123, gm_type_string)).toBeFalsy();
			expect(is_type("123", gm_type_number)).toBeFalsy();
			expect(is_type([1], gm_type_struct)).toBeFalsy();
			expect(is_type({}, gm_type_array)).toBeFalsy();
			expect(is_type(true, gm_type_number)).toBeFalsy();
			expect(is_type(undefined, gm_type_number)).toBeFalsy();
		});

		it("Should return false for an empty array of types", function() {
			expect(is_type(123, [])).toBeFalsy();
		});
	});
});

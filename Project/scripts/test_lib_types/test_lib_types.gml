suite(function() {
	describe("str", function() {
		it("Should return a string of a value", function() {
			expect(str(123456)).toBe("123456");
			expect(str("asdf")).toBe("asdf");
			expect(str([0, 1, 2])).toBe("[ 0,1,2 ]");
			expect(str({key: "value"})).toBe("{ key : \"value\" }");
		});
	});
	
	describe("int", function() {
		it("Should return a value as integer", function() {
			expect(int(100)).toBe(100);
			expect(int(33.25)).toBe(33);
			expect(int(10.66)).toBe(10);
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
	});
	
	describe("int16", function() {
		it("Should return a value as 16-bit integer", function() {
			expect(int16(0)).toBe(0);
			expect(int16(128)).toBe(128);
			expect(int16(65536)).toBe(0);
			expect(int16(-32768)).toBe(32768);
			expect(int16(-65536)).toBe(0);
		});
	});
	
	describe("int8s", function() {
		it("Should return a value as 16-bit integer", function() {
			expect(int8s(64)).toBe(64);
			expect(int8s(128)).toBe(-128);
			expect(int8s(256)).toBe(0);
			expect(int8s(-128)).toBe(-128);
			expect(int8s(-256)).toBe(0);
		});
	});
	
	describe("int16s", function() {
		it("Should return a value as 16-bit integer", function() {
			expect(int16s(0)).toBe(0);
			expect(int16s(65536)).toBe(0);
			expect(int16s(-32768)).toBe(-32768);
			expect(int16s(32768)).toBe(-32768);
			expect(int16s(-65536)).toBe(0);
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
		
		it("Should return true for multiple types", function() {
			expect(is_type(123465, [gm_type_pointer, gm_type_number])).toBeTruthy();
			expect(is_type("asdf", [gm_type_string, gm_type_number])).toBeTruthy();
			expect(is_type("asdf", [gm_type_struct, gm_type_number])).toBeFalsy();
		});
	});
});
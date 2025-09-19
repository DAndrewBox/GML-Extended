suite(function() {
	describe("struct_keys", function() {
		it("Should return keys of struct", function() {
			var _struct = {
				testKey: 1,
				hi: "hello",
				aa: "bb"
			};
			
			expect(struct_keys(_struct)).toBe(variable_struct_get_names(_struct));
		});
	});
	
	describe("struct_merge", function() {
		it("Should merge 2 structs without overriding values", function() {
			var _struct_1 = {
				testKey1: 1,
				testKey2: 2,
			};
			var _struct_2 = {
				testKey2: 100,
				testKey3: 3,
			};
			var _struct_merged = struct_merge(_struct_1, _struct_2, false);
			
			expect(_struct_merged.testKey1).toBe(1);
			expect(_struct_merged.testKey2).toBe(2);
			expect(_struct_merged.testKey3).toBe(3);
		});
		
		it("Should merge 2 structs overriding values", function() {
			var _struct_1 = {
				testKey1: 1,
				testKey2: 2,
			};
			var _struct_2 = {
				testKey2: 100,
				testKey3: 3,
			};
			var _struct_merged = struct_merge(_struct_1, _struct_2, true);
			
			expect(_struct_merged.testKey1).toBe(1);
			expect(_struct_merged.testKey2).toBe(100);
			expect(_struct_merged.testKey3).toBe(3);
		});
	});
	
	describe("struct_key_exists", function() {
		it("Should get a valid key of an struct", function() {
			var _struct = {
				testKey: 1,
				hi: "hello",
				aa: "bb"
			};
			
			expect(struct_key_exists(_struct, "testKey")).toBeTruthy();
			expect(struct_key_exists(_struct, "hi")).toBeTruthy();
			expect(struct_key_exists(_struct, "aa")).toBeTruthy();
		});
		
		it("Should get an error for key not existing", function() {
			var _struct = {
				testKey: 1,
				hi: "hello",
				aa: "bb"
			};
			
			expect(struct_key_exists(_struct, "testKey1")).toBeFalsy();
			expect(struct_key_exists(_struct, "hello")).toBeFalsy();
			expect(struct_key_exists(_struct, "aaaa")).toBeFalsy();
		});
	});
	
	describe("struct_equal", function() {
		it("Should return true as 2 structs are equal", function() {
			var _struct_1 = {
				testKey1: 1,
				testKey2: 2,
			};
			var _struct_2 = {
				testKey2: 2,
				testKey1: 1,
			};
			
			expect(struct_equal(_struct_1, _struct_2)).toBeTruthy();
		});
		
		it("Should return false as 2 structs are different", function() {
			var _struct_1 = {
				testKey1: 1,
				testKey2: 2,
			};
			var _struct_2 = {
				testKey2: 100,
				testKey3: 3,
			};
			
			expect(struct_equal(_struct_1, _struct_2)).toBeFalsy();
		});
	});
	
	describe("struct_entries", function() {
		it("Should return all entries if the struct has elements", function() {
			var _struct = {
				testKey1: 1,
				testKey2: 2,
			};
			expect(struct_entries(_struct)).toBe([["testKey1", 1], ["testKey2", 2]]);
		});
		
		it("Should return all entries if the struct is empty", function() {
			var _struct = {};
			expect(struct_entries(_struct)).toBe([]);
		});
		
		it("Should return all entries if the struct has undefined elements", function() {
			var _struct = {
				testKey1: 1,
				testKey2: undefined,
				testKey3: 3,
			};
			expect(struct_entries(_struct)).toBe([["testKey1", 1], ["testKey3", 3]]);
		});
	});
});
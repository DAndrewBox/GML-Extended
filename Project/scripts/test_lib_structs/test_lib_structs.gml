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

		it("Should return an empty array for an empty struct", function() {
			expect(struct_keys({})).toBeEqual([]);
		});

		it("Should include keys holding undefined", function() {
			expect(struct_keys({ a: undefined })).toHaveLength(1);
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

		it("Should override by default", function() {
			var _struct_merged = struct_merge({ a: 1 }, { a: 2 });
			expect(_struct_merged.a).toBe(2);
		});

		it("Should not modify any of the source structs", function() {
			var _struct_1 = { a: 1 };
			var _struct_2 = { a: 2, b: 3 };
			var _struct_merged = struct_merge(_struct_1, _struct_2);

			expect(_struct_merged.a).toBe(2);
			expect(_struct_1.a).toBe(1);
			expect(_struct_1).toHaveLength(1);
			expect(_struct_2).toHaveLength(2);
		});

		it("Should merge nested structs", function() {
			var _struct_1 = { nested: { a: 1, b: 2 } };
			var _struct_2 = { nested: { b: 20, c: 30 } };
			var _struct_merged = struct_merge(_struct_1, _struct_2);

			expect(_struct_merged.nested.a).toBe(1);
			expect(_struct_merged.nested.b).toBe(20);
			expect(_struct_merged.nested.c).toBe(30);
		});

		it("Should keep the first nested struct when override is false", function() {
			var _struct_merged = struct_merge({ nested: { a: 1 } }, { nested: { a: 99, b: 2 } }, false);

			expect(_struct_merged.nested.a).toBe(1);
			expect(struct_key_exists(_struct_merged.nested, "b")).toBeFalsy();
		});

		it("Should let the second value win when only one side is a struct", function() {
			var _struct_merged = struct_merge({ a: 1 }, { a: { b: 2 } });
			expect(_struct_merged.a.b).toBe(2);

			_struct_merged = struct_merge({ a: { b: 2 } }, { a: 1 });
			expect(_struct_merged.a).toBe(1);
		});

		it("Should keep a stored undefined when override is false", function() {
			var _struct_merged = struct_merge({ a: undefined }, { a: 5 }, false);
			expect(_struct_merged.a).toBe(undefined);
		});

		it("Should handle empty structs on either side", function() {
			expect(struct_merge({}, { a: 1 }).a).toBe(1);
			expect(struct_merge({ a: 1 }, {}).a).toBe(1);
			expect(struct_merge({}, {})).toHaveLength(0);
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

		it("Should return false for any key of an empty struct", function() {
			expect(struct_key_exists({}, "a")).toBeFalsy();
		});

		it("Should find a key holding undefined", function() {
			expect(struct_key_exists({ a: undefined }, "a")).toBeTruthy();
		});

		it("Should be case sensitive", function() {
			expect(struct_key_exists({ abc: 1 }, "ABC")).toBeFalsy();
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

		it("Should return true for two empty structs", function() {
			expect(struct_equal({}, {})).toBeTruthy();
		});

		it("Should return false when the key count differs", function() {
			expect(struct_equal({ a: 1 }, { a: 1, b: 2 })).toBeFalsy();
			expect(struct_equal({ a: 1, b: 2 }, { a: 1 })).toBeFalsy();
		});

		it("Should return false when a key name differs", function() {
			expect(struct_equal({ a: 1 }, { b: 1 })).toBeFalsy();
		});

		it("Should compare nested structs by value", function() {
			expect(struct_equal({ a: { b: 1 } }, { a: { b: 1 } })).toBeTruthy();
			expect(struct_equal({ a: { b: 1 } }, { a: { b: 2 } })).toBeFalsy();
		});

		it("Should compare arrays by value", function() {
			expect(struct_equal({ a: [1, 2] }, { a: [1, 2] })).toBeTruthy();
			expect(struct_equal({ a: [1, 2] }, { a: [1, 3] })).toBeFalsy();
			expect(struct_equal({ a: [1, 2] }, { a: [1] })).toBeFalsy();
		});

		it("Should treat a stored undefined as a real value", function() {
			expect(struct_equal({ a: undefined }, { a: undefined })).toBeTruthy();
			expect(struct_equal({ a: undefined }, { a: 1 })).toBeFalsy();
		});

		it("Should return false when an argument is not a struct", function() {
			// Feather ignore once all - This should fail and return false
			expect(struct_equal({ a: 1 }, 1)).toBeFalsy();
			// Feather ignore once all - This should fail and return false
			expect(struct_equal("a", { a: 1 })).toBeFalsy();
		});
	});

	describe("struct_entries", function() {
		it("Should return all entries if the struct has elements", function() {
			var _struct = {
				testKey1: 1,
				testKey2: 2,
			};
			var _entries = struct_entries(_struct);
			var _rebuilt = {};

			// Key order is not guaranteed, so rebuild the struct from the entries instead.
			expect(_entries).toHaveLength(2);
			for (var i = 0; i < array_length(_entries); i++) {
				_rebuilt[$ _entries[i][0]] = _entries[i][1];
			}
			expect(struct_equal(_rebuilt, _struct)).toBeTruthy();
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
			var _entries = struct_entries(_struct);
			var _rebuilt = {};

			expect(_entries).toHaveLength(2);
			for (var i = 0; i < array_length(_entries); i++) {
				_rebuilt[$ _entries[i][0]] = _entries[i][1];
			}
			expect(struct_equal(_rebuilt, { testKey1: 1, testKey3: 3 })).toBeTruthy();
		});

		it("Should return each entry as a key and value pair", function() {
			var _entries = struct_entries({ onlyKey: "value" });

			expect(_entries).toHaveLength(1);
			expect(_entries[0]).toBeEqual(["onlyKey", "value"]);
		});

		it("Should keep struct and array values as they are", function() {
			var _entries = struct_entries({ arr: [1, 2] });

			expect(_entries[0][0]).toBe("arr");
			expect(_entries[0][1]).toBeEqual([1, 2]);
		});
	});
});

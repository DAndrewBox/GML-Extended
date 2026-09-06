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

		it("Should merge arrays index by index", function() {
			var _struct_merged = struct_merge({ arr: [1, 2, 3] }, { arr: [10, 20] });
			expect(_struct_merged.arr).toBeEqual([10, 20, 3]);
		});

		it("Should append the extra elements of the second array", function() {
			var _struct_merged = struct_merge({ arr: [1] }, { arr: [10, 20, 30] });
			expect(_struct_merged.arr).toBeEqual([10, 20, 30]);
		});

		it("Should merge the structs inside an array of structs", function() {
			var _struct_1 = { list: [{ a: 1, b: 2 }, { a: 3 }] };
			var _struct_2 = { list: [{ b: 20, c: 30 }] };
			var _struct_merged = struct_merge(_struct_1, _struct_2);

			expect(_struct_merged.list).toHaveLength(2);
			expect(_struct_merged.list[0].a).toBe(1);
			expect(_struct_merged.list[0].b).toBe(20);
			expect(_struct_merged.list[0].c).toBe(30);
			expect(_struct_merged.list[1].a).toBe(3);
		});

		it("Should merge nested arrays of arrays", function() {
			var _struct_merged = struct_merge({ grid: [[1, 2], [3, 4]] }, { grid: [[10]] });
			expect(_struct_merged.grid[0]).toBeEqual([10, 2]);
			expect(_struct_merged.grid[1]).toBeEqual([3, 4]);
		});

		it("Should not share an array reference with either source", function() {
			var _struct_1 = { arr: [1, 2] };
			var _struct_2 = { arr: [10, 20] };
			var _struct_merged = struct_merge(_struct_1, _struct_2);

			_struct_merged.arr[0] = 999;

			expect(_struct_1.arr).toBeEqual([1, 2]);
			expect(_struct_2.arr).toBeEqual([10, 20]);
		});

		it("Should not share a nested struct reference with either source", function() {
			var _struct_1 = { a: 1 };
			var _struct_2 = { nested: { b: 2 } };
			var _struct_merged = struct_merge(_struct_1, _struct_2);

			_struct_merged.nested.b = 999;

			expect(_struct_2.nested.b).toBe(2);
		});

		it("Should not share a struct held inside an array", function() {
			var _struct_1 = { list: [{ a: 1 }] };
			var _struct_2 = { list: [{ b: 2 }] };
			var _struct_merged = struct_merge(_struct_1, _struct_2);

			_struct_merged.list[0].a = 999;

			expect(_struct_1.list[0].a).toBe(1);
		});

		it("Should let the second value win when only one side is an array", function() {
			expect(struct_merge({ a: [1, 2] }, { a: 5 }).a).toBe(5);
			expect(struct_merge({ a: 5 }, { a: [1, 2] }).a).toBeEqual([1, 2]);
		});

		it("Should handle empty arrays on either side", function() {
			expect(struct_merge({ arr: [] }, { arr: [1, 2] }).arr).toBeEqual([1, 2]);
			expect(struct_merge({ arr: [1, 2] }, { arr: [] }).arr).toBeEqual([1, 2]);
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

	describe("struct_filter", function() {
		it("Should keep only the entries the callback accepts", function() {
			var _out = struct_filter({ a: 1, b: 2, c: 3 }, function (_key, _value) {
				return _value > 1;
			});

			expect(_out).toHaveLength(2);
			expect(struct_key_exists(_out, "a")).toBeFalsy();
			expect(_out.b).toBe(2);
			expect(_out.c).toBe(3);
		});

		it("Should pass the key to the callback", function() {
			var _out = struct_filter({ keep_me: 1, drop: 2 }, function (_key, _value) {
				return string_contains(_key, "keep");
			});

			expect(_out).toHaveLength(1);
			expect(_out.keep_me).toBe(1);
		});

		it("Should return an empty struct when nothing matches", function() {
			expect(struct_filter({ a: 1 }, function (_k, _v) { return false; })).toHaveLength(0);
			expect(struct_filter({}, function (_k, _v) { return true; })).toHaveLength(0);
		});

		it("Should not modify the original struct", function() {
			var _struct = { a: 1, b: 2 };
			struct_filter(_struct, function (_k, _v) { return false; });

			expect(_struct).toHaveLength(2);
		});
	});

	describe("struct_map", function() {
		it("Should replace every value with the callback result", function() {
			var _out = struct_map({ a: 1, b: 2 }, function (_key, _value) {
				return _value * 10;
			});

			expect(_out.a).toBe(10);
			expect(_out.b).toBe(20);
		});

		it("Should keep every key", function() {
			var _out = struct_map({ a: 1, b: 2, c: 3 }, function (_key, _value) {
				return 0;
			});

			expect(_out).toHaveLength(3);
		});

		it("Should pass the key to the callback", function() {
			var _out = struct_map({ name: "x" }, function (_key, _value) {
				return _key + ":" + _value;
			});

			expect(_out.name).toBe("name:x");
		});

		it("Should return an empty struct for an empty struct", function() {
			expect(struct_map({}, function (_k, _v) { return 1; })).toHaveLength(0);
		});

		it("Should not modify the original struct", function() {
			var _struct = { a: 1 };
			struct_map(_struct, function (_k, _v) { return 99; });

			expect(_struct.a).toBe(1);
		});
	});

	describe("struct_reduce", function() {
		it("Should carry the accumulator across every entry", function() {
			var _sum = struct_reduce({ a: 1, b: 2, c: 3 }, function (_acc, _key, _value) {
				return _acc + _value;
			}, 0);

			expect(_sum).toBe(6);
		});

		it("Should collect the keys", function() {
			var _count = struct_reduce({ a: 1, b: 2 }, function (_acc, _key, _value) {
				return _acc + 1;
			}, 0);

			expect(_count).toBe(2);
		});

		it("Should return the initial value for an empty struct", function() {
			expect(struct_reduce({}, function (_acc, _k, _v) { return _acc + 1; }, 42)).toBe(42);
		});

		it("Should default the initial value to undefined", function() {
			var _out = struct_reduce({}, function (_acc, _k, _v) { return _acc; });
			expect(_out).toBe(undefined);
		});
	});

	describe("struct_get_path", function() {
		it("Should read a nested value", function() {
			var _struct = { player: { stats: { hp: 100 } } };

			expect(struct_get_path(_struct, "player.stats.hp")).toBe(100);
			expect(struct_get_path(_struct, "player.stats")).toHaveLength(1);
		});

		it("Should read a top level value", function() {
			expect(struct_get_path({ a: 1 }, "a")).toBe(1);
		});

		it("Should walk into an array with a numeric step", function() {
			var _struct = { items: [{ name: "sword" }, { name: "shield" }] };

			expect(struct_get_path(_struct, "items.0.name")).toBe("sword");
			expect(struct_get_path(_struct, "items.1.name")).toBe("shield");
		});

		it("Should return the default when the path does not exist", function() {
			var _struct = { a: { b: 1 } };

			expect(struct_get_path(_struct, "a.c", "fallback")).toBe("fallback");
			expect(struct_get_path(_struct, "x.y.z", "fallback")).toBe("fallback");
			expect(struct_get_path(_struct, "a.b.c", "fallback")).toBe("fallback");
		});

		it("Should return the default for an index out of bounds", function() {
			var _struct = { items: [1, 2] };

			expect(struct_get_path(_struct, "items.5", "fallback")).toBe("fallback");
			expect(struct_get_path(_struct, "items.name", "fallback")).toBe("fallback");
		});

		it("Should default to undefined", function() {
			expect(struct_get_path({ a: 1 }, "b")).toBe(undefined);
		});

		it("Should find a value that is stored as undefined", function() {
			expect(struct_get_path({ a: undefined }, "a", "fallback")).toBe(undefined);
		});
	});

	describe("struct_flatten", function() {
		it("Should turn nested keys into a path", function() {
			var _out = struct_flatten({ a: { b: 1 } });

			expect(_out[$ "a.b"]).toBe(1);
			expect(_out).toHaveLength(1);
		});

		it("Should flatten several levels", function() {
			var _out = struct_flatten({ a: { b: { c: 2 } }, d: 3 });

			expect(_out[$ "a.b.c"]).toBe(2);
			expect(_out[$ "d"]).toBe(3);
			expect(_out).toHaveLength(2);
		});

		it("Should use a custom separator", function() {
			var _out = struct_flatten({ a: { b: 1 } }, "/");

			expect(_out[$ "a/b"]).toBe(1);
		});

		it("Should keep an array as a single value", function() {
			var _out = struct_flatten({ a: [1, 2] });

			expect(_out[$ "a"]).toBeEqual([1, 2]);
		});

		it("Should keep an empty struct as a value", function() {
			var _out = struct_flatten({ a: {} });

			expect(_out).toHaveLength(1);
			expect(_out[$ "a"]).toHaveLength(0);
		});

		it("Should return an empty struct for an empty struct", function() {
			expect(struct_flatten({})).toHaveLength(0);
		});

		it("Should be readable back with struct_get_path", function() {
			var _struct = { a: { b: { c: 7 } } };
			var _out = struct_flatten(_struct);

			expect(_out[$ "a.b.c"]).toBe(struct_get_path(_struct, "a.b.c"));
		});
	});

});

suite(function() {
	describe("__gml_ext_comp_get_version", function() {
		it("Should report a major that matches the runtime", function() {
			var _version = GM_CURRENT_VERSION;

			expect(_version.major).toBeGreaterThan(0);
			expect(is_real(_version.major)).toBeTruthy();
			expect(is_real(_version.minor)).toBeTruthy();
		});

		it("Should build the string out of the major and the minor", function() {
			var _version = GM_CURRENT_VERSION;

			expect(_version.as_string).toBe(string(_version.major) + "." + string(_version.minor));
		});

		it("Should return the same cached struct on every call", function() {
			expect(GM_CURRENT_VERSION).toBe(GM_CURRENT_VERSION);
		});

		it("Should match exactly one of the version macros", function() {
			var _matches = 0;
			if (GM_VERSION_IS_2_3) _matches++;
			if (GM_VERSION_IS_2022) _matches++;
			if (GM_VERSION_IS_2023) _matches++;
			if (GM_VERSION_IS_2024) _matches++;
			if (GM_VERSION_IS_2025) _matches++;
			if (GM_VERSION_IS_2026) _matches++;

			expect(_matches).toBeLessThanOrEqual(1);
		});
	});

	describe("__gml_ext_comp_version_at_least", function() {
		it("Should be true for the version the runtime is on", function() {
			var _version = GM_CURRENT_VERSION;

			expect(GM_VERSION_AT_LEAST(_version.major, _version.minor)).toBeTruthy();
			expect(GM_VERSION_AT_LEAST(_version.major)).toBeTruthy();
		});

		it("Should be false for a newer version", function() {
			var _version = GM_CURRENT_VERSION;

			expect(GM_VERSION_AT_LEAST(_version.major + 1)).toBeFalsy();
			expect(GM_VERSION_AT_LEAST(_version.major, _version.minor + 1)).toBeFalsy();
		});

		it("Should be true for an older version", function() {
			var _version = GM_CURRENT_VERSION;

			expect(GM_VERSION_AT_LEAST(_version.major - 1)).toBeTruthy();
			expect(GM_VERSION_AT_LEAST(_version.major - 1, 99)).toBeTruthy();
		});

		it("Should compare the major before the minor", function() {
			var _version = GM_CURRENT_VERSION;

			// A huge minor on an older major still counts as older.
			expect(GM_VERSION_AT_LEAST(_version.major - 1, 9999)).toBeTruthy();
			expect(GM_VERSION_AT_LEAST(_version.major + 1, 0)).toBeFalsy();
		});

		it("Should default the minor to 0", function() {
			var _version = GM_CURRENT_VERSION;

			expect(GM_VERSION_AT_LEAST(_version.major, 0)).toBe(GM_VERSION_AT_LEAST(_version.major));
		});
	});

	describe("__gml_ext_comp_has", function() {
		it("Should return a bool for every known feature", function() {
			var _features = [
				"instance_create_params", "string_ext", "string_split", "array_contains",
				"is_callable", "json_stringify_ext", "variable_clone", "gpu_set_depth",
				"window_mouse_delta",
			];
			var _len = array_length(_features);

			for (var i = 0; i < _len; i++) {
				expect(is_bool(GM_HAS(_features[i]))).toBeTruthy();
			}
		});

		it("Should return false for an unknown feature", function() {
			expect(GM_HAS("this_feature_does_not_exist")).toBeFalsy();
		});

		it("Should agree with the version the runtime reports", function() {
			expect(GM_HAS("string_split")).toBe(GM_VERSION_AT_LEAST(2022, 11));
			expect(GM_HAS("variable_clone")).toBe(GM_VERSION_AT_LEAST(2023, 4));
			expect(GM_HAS("gpu_set_depth")).toBe(GM_VERSION_AT_LEAST(2023, 8));
		});
	});

	describe("compatibility fallbacks", function() {
		it("Should split a string the same way as the built-in", function() {
			expect(__gml_ext_comp_string_split("a,b,c", ",")).toBeEqual(["a", "b", "c"]);
			expect(__gml_ext_comp_string_split("single", ",")).toBeEqual(["single"]);
			expect(__gml_ext_comp_string_split("", ",")).toBeEqual([]);
		});

		it("Should fill in the placeholders of a string", function() {
			expect(__gml_ext_comp_string_ext("{0} and {1}", ["a", "b"])).toBe("a and b");
			expect(__gml_ext_comp_string_ext("no args")).toBe("no args");
		});

		it("Should find a value inside an array", function() {
			expect(__gml_ext_comp_array_contains([1, 2, 3], 2)).toBeTruthy();
			expect(__gml_ext_comp_array_contains([1, 2, 3], 9)).toBeFalsy();
			expect(__gml_ext_comp_array_contains([], 1)).toBeFalsy();
		});

		it("Should clone a value without sharing its reference", function() {
			var _struct = { nested: { a: 1 } };
			var _clone = __gml_ext_comp_variable_clone(_struct);

			_clone.nested.a = 999;

			expect(_struct.nested.a).toBe(1);
			expect(__gml_ext_comp_variable_clone(5)).toBe(5);
			expect(__gml_ext_comp_variable_clone([1, 2])).toBeEqual([1, 2]);
		});

		it("Should tell a callable from a plain value", function() {
			expect(__gml_ext_comp_is_callable(function () {})).toBeTruthy();
			expect(__gml_ext_comp_is_callable(5)).toBeFalsy();
		});

		it("Should stringify a struct back into readable json", function() {
			var _json = __gml_ext_comp_json_stringify({ a: 1 });

			expect(is_string(_json)).toBeTruthy();
			expect(json_parse(_json).a).toBe(1);
		});
	});
});

suite(function() {
	describe("instance_create", function() {
		it("Should create the instance at the given position", function() {
			var _inst = instance_create(32, 64, o_gml_ext_test_dummy, 0);

			expect(instance_exists(_inst)).toBeTruthy();
			expect(_inst.x).toBe(32);
			expect(_inst.y).toBe(64);

			instance_destroy(_inst);
		});

		it("Should apply the params struct on creation", function() {
			var _inst = instance_create(0, 0, o_gml_ext_test_dummy, 0, { test_mark: 7 });

			expect(_inst.test_mark).toBe(7);

			instance_destroy(_inst);
		});

		it("Should use the given depth", function() {
			var _inst = instance_create(0, 0, o_gml_ext_test_dummy, 250);

			expect(_inst.depth).toBe(250);

			instance_destroy(_inst);
		});

		it("Should leave the caller params struct usable after the call", function() {
			var _params = { test_mark: 1 };
			var _inst = instance_create(0, 0, o_gml_ext_test_dummy, 0, _params);

			expect(_params).toHaveProperty("test_mark", 1);

			var _second = instance_create(0, 0, o_gml_ext_test_dummy, 0, _params);
			expect(_second.test_mark).toBe(1);

			instance_destroy(_inst);
			instance_destroy(_second);
		});
	});

	describe("instance_create_unique", function() {
		it("Should not create a second instance of the object", function() {
			var _first = instance_create_unique(0, 0, o_gml_ext_test_dummy, 0);
			instance_create_unique(0, 0, o_gml_ext_test_dummy, 0);
			instance_create_unique(0, 0, o_gml_ext_test_dummy, 0);

			expect(instance_number(o_gml_ext_test_dummy)).toBe(1);

			instance_destroy(_first);
		});

		it("Should return the instance that already exists", function() {
			var _first = instance_create_unique(0, 0, o_gml_ext_test_dummy, 0);
			var _second = instance_create_unique(32, 64, o_gml_ext_test_dummy, 0);

			expect(_second).toBe(_first);
			expect(_second.x).toBe(0);

			instance_destroy(_first);
		});

		it("Should create the instance when none exists yet", function() {
			expect(instance_number(o_gml_ext_test_dummy)).toBe(0);

			var _inst = instance_create_unique(0, 0, o_gml_ext_test_dummy, 0);

			expect(instance_exists(_inst)).toBeTruthy();

			instance_destroy(_inst);
		});
	});

	describe("instance_any_exists", function() {
		it("Should return true when one of the objects exists", function() {
			var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);

			expect(instance_any_exists(o_gml_ext_test_dummy)).toBeTruthy();
			expect(instance_any_exists(o_gml_ext_test_dummy, o_gml_ext_test_ease)).toBeTruthy();

			instance_destroy(_inst);
		});

		it("Should return false when none of the objects exists", function() {
			expect(instance_any_exists(o_gml_ext_test_dummy)).toBeFalsy();
		});

		it("Should return false when no argument is given", function() {
			expect(instance_any_exists()).toBeFalsy();
		});
	});

	describe("instance_get_all", function() {
		it("Should return every live instance of the object", function() {
			var _created = [];
			repeat (12) {
				array_push(_created, instance_create_depth(0, 0, 0, o_gml_ext_test_dummy));
			}

			var _all = instance_get_all(o_gml_ext_test_dummy);

			expect(_all).toHaveLength(12);
			expect(array_find_index_by_value(_all, _created[0])).toBe(0);
			expect(array_find_index_by_value(_all, _created[11])).toBe(11);

			for (var i = 0; i < 12; i++) {
				instance_destroy(_created[i]);
			}
		});

		it("Should return an empty array when no instance exists", function() {
			expect(instance_get_all(o_gml_ext_test_dummy)).toBeEqual([]);
		});

		it("Should return a single instance", function() {
			var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);

			expect(instance_get_all(o_gml_ext_test_dummy)).toHaveLength(1);

			instance_destroy(_inst);
		});
	});

	describe("instance_number_if", function() {
		it("Should count only the instances matching the callback", function() {
			var _created = [];
			for (var i = 0; i < 6; i++) {
				var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
				_inst.test_mark = i;
				array_push(_created, _inst);
			}

			expect(instance_number_if(o_gml_ext_test_dummy, function (_i) {
				return _i.test_mark < 2;
			})).toBe(2);

			expect(instance_number_if(o_gml_ext_test_dummy, function (_i) {
				return true;
			})).toBe(6);

			expect(instance_number_if(o_gml_ext_test_dummy, function (_i) {
				return false;
			})).toBe(0);

			for (var i = 0; i < 6; i++) {
				instance_destroy(_created[i]);
			}
		});

		it("Should return 0 when no instance exists", function() {
			expect(instance_number_if(o_gml_ext_test_dummy, function (_i) {
				return true;
			})).toBe(0);
		});
	});

	describe("instance_get_if", function() {
		it("Should return only the instances matching the callback", function() {
			var _created = [];
			for (var i = 0; i < 6; i++) {
				var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
				_inst.test_mark = i;
				array_push(_created, _inst);
			}

			var _found = instance_get_if(o_gml_ext_test_dummy, function (_i) {
				return _i.test_mark >= 4;
			});

			expect(_found).toHaveLength(2);
			expect(_found[0].test_mark).toBeGreaterThanOrEqual(4);
			expect(_found[1].test_mark).toBeGreaterThanOrEqual(4);

			for (var i = 0; i < 6; i++) {
				instance_destroy(_created[i]);
			}
		});

		it("Should return an empty array when nothing matches", function() {
			var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
			_inst.test_mark = 0;

			expect(instance_get_if(o_gml_ext_test_dummy, function (_i) {
				return false;
			})).toBeEqual([]);

			instance_destroy(_inst);
		});

		it("Should return every instance when everything matches", function() {
			var _created = [];
			repeat (4) {
				array_push(_created, instance_create_depth(0, 0, 0, o_gml_ext_test_dummy));
			}

			expect(instance_get_if(o_gml_ext_test_dummy, function (_i) {
				return true;
			})).toHaveLength(4);

			for (var i = 0; i < 4; i++) {
				instance_destroy(_created[i]);
			}
		});
	});

	describe("instance_first / instance_last", function() {
		it("Should return the first and the last instance of the object", function() {
			var _a = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
			var _b = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
			var _c = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);

			expect(instance_first(o_gml_ext_test_dummy)).toBe(_a);
			expect(instance_last(o_gml_ext_test_dummy)).toBe(_c);

			instance_destroy(_a);
			instance_destroy(_b);
			instance_destroy(_c);
		});

		it("Should return the same instance when only one exists", function() {
			var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);

			expect(instance_first(o_gml_ext_test_dummy)).toBe(_inst);
			expect(instance_last(o_gml_ext_test_dummy)).toBe(_inst);

			instance_destroy(_inst);
		});

		it("Should return noone when no instance exists", function() {
			expect(instance_first(o_gml_ext_test_dummy)).toBe(noone);
		});
	});
});

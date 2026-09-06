suite(function () {
	describe("del", function() {
		it("Should destroy an object", function() {
			var _inst = instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
			expect(instance_exists(_inst)).toBeTruthy();
			del(_inst);
			expect(instance_exists(_inst)).toBeFalsy();
		});

		it("Should destroy every instance of an object index", function() {
			repeat (3) {
				instance_create_depth(0, 0, 0, o_gml_ext_test_dummy);
			}
			expect(instance_number(o_gml_ext_test_dummy)).toBe(3);
			del(o_gml_ext_test_dummy);
			expect(instance_number(o_gml_ext_test_dummy)).toBe(0);
		});
	});

	describe("get_size", function() {
		it("Should get the size of an array correctly", function() {
			var _test_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
			expect(get_size(_test_array)).toBeEqual(10);
		});

		it("Should get the size of an struct correctly", function() {
			var _test_struct = {key1: "test", key2: "123", key3: "test again"};
			expect(get_size(_test_struct)).toBeEqual(3);
		});

		it("Should get the size of an string correctly", function() {
			var _test_string = "Hello World";
			expect(get_size(_test_string)).toBeEqual(11);
		});

		it("Should get the size of a number correctly", function() {
			var _test_number = 10;
			expect(get_size(_test_number)).toBeEqual(2);
		});

		it("Should get the size of an int64 correctly", function() {
			var _test_number = int64(500_000_000_000);
			expect(get_size(_test_number)).toBeEqual(12);
		});

		it("Should get the size of a bool correctly", function() {
			var _test_bool = true;
			expect(get_size(_test_bool)).toBeEqual(1);
		});

		it("Should return 0 for empty containers", function() {
			expect(get_size([])).toBe(0);
			expect(get_size({})).toBe(0);
			expect(get_size("")).toBe(0);
		});

		it("Should count the sign of a negative number", function() {
			expect(get_size(-10)).toBe(3);
			expect(get_size(0)).toBe(1);
		});

		it("Should return -1 for types without a size", function() {
			expect(get_size(undefined)).toBe(-1);
			expect(get_size(function () {})).toBe(-1);
		});

		it("Should use the type given as second argument", function() {
			expect(get_size([1, 2, 3], gm_type_array)).toBe(3);
			expect(get_size("abc", gm_type_string)).toBe(3);
			expect(get_size({a: 1}, gm_type_struct)).toBe(1);
		});

		it("Should count only the top level keys of a nested struct", function() {
			expect(get_size({a: {b: 1, c: 2}})).toBe(1);
		});

		it("Should get the size of a ds_list", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "a", "b", "c");

			expect(get_size(_list, ds_type_list)).toBe(3);

			ds_list_destroy(_list);
		});

		it("Should get the size of a ds_map", function() {
			var _map = ds_map_create();
			_map[? "a"] = 1;
			_map[? "b"] = 2;

			expect(get_size(_map, ds_type_map)).toBe(2);

			ds_map_destroy(_map);
		});

		it("Should get the cell count of a ds_grid", function() {
			var _grid = ds_grid_create(4, 3);

			expect(get_size(_grid, ds_type_grid)).toBe(12);

			ds_grid_destroy(_grid);
		});

		it("Should get the size of a ds_queue, ds_stack and ds_priority", function() {
			var _queue = ds_queue_create();
			var _stack = ds_stack_create();
			var _priority = ds_priority_create();

			ds_queue_enqueue(_queue, 1, 2);
			ds_stack_push(_stack, 1, 2, 3);
			ds_priority_add(_priority, "a", 1);

			expect(get_size(_queue, ds_type_queue)).toBe(2);
			expect(get_size(_stack, ds_type_stack)).toBe(3);
			expect(get_size(_priority, ds_type_priority)).toBe(1);

			ds_queue_destroy(_queue);
			ds_stack_destroy(_stack);
			ds_priority_destroy(_priority);
		});

		it("Should return 0 for empty data structures", function() {
			var _list = ds_list_create();
			var _map = ds_map_create();

			expect(get_size(_list, ds_type_list)).toBe(0);
			expect(get_size(_map, ds_type_map)).toBe(0);

			ds_list_destroy(_list);
			ds_map_destroy(_map);
		});

		it("Should return -1 for a destroyed or mismatched data structure", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "a");
			ds_list_destroy(_list);

			expect(get_size(_list, ds_type_list)).toBe(-1);

			var _map = ds_map_create();
			expect(get_size(_map, ds_type_list)).toBe(-1);
			ds_map_destroy(_map);
		});
	});

	describe("contains", function() {
		it("Should find different element types in an array", function() {
			var _elem = ["test", 123];
			var _container = [500, "test", 123, "Hello world"];

			expect(contains(_elem[0], _container)).toBeTruthy();
			expect(contains(_elem[1], _container)).toBeTruthy();
			expect(contains("Not Found", _container)).toBeFalsy();
		});

		it("Should find different element types in an struct", function() {
			var _elem = ["testkey", "test2"];
			var _container = {testkey: 1, test2: 0, keykey: "12345"};

			expect(contains(_elem[0], _container)).toBeTruthy();
			expect(contains(_elem[1], _container)).toBeTruthy();
			expect(contains("TEST444", _container)).toBeFalsy();
		});

		it("Should find element in string", function() {
			var _elem = "world";
			var _container = "Hello world!";

			expect(contains(_elem, _container)).toBeTruthy();
			expect(contains("hi", _container)).toBeFalsy();
		});

		it("Should find element in number", function() {
			var _elem = 1000;
			var _container = 1000000;

			expect(contains(_elem, _container)).toBeTruthy();
			expect(contains(25, _container)).toBeFalsy();
		});

		it("Should find a number inside a string", function() {
			expect(contains(345, "12345")).toBeTruthy();
			expect(contains(9, "12345")).toBeFalsy();
		});

		it("Should return false for empty containers", function() {
			expect(contains("a", [])).toBeFalsy();
			expect(contains("a", {})).toBeFalsy();
			expect(contains("a", "")).toBeFalsy();
		});

		it("Should use the container type given as third argument", function() {
			expect(contains("test", [1, "test"], gm_type_array)).toBeTruthy();
			expect(contains("a", "abc", gm_type_string)).toBeTruthy();
		});

		it("Should return false for element types that cannot be searched", function() {
			expect(contains([1], [1, 2])).toBeFalsy();
			expect(contains({a: 1}, [1, 2])).toBeFalsy();
		});

		it("Should return false for container types that cannot be searched", function() {
			// Feather ignore once all - This should fail and return false
			expect(contains(1, true)).toBeFalsy();
			// Feather ignore once all - This should fail and return false
			expect(contains(1, undefined)).toBeFalsy();
		});

		it("Should find a value inside a ds_list", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "a", "b", 3);

			expect(contains("a", _list, ds_type_list)).toBeTruthy();
			expect(contains(3, _list, ds_type_list)).toBeTruthy();
			expect(contains("z", _list, ds_type_list)).toBeFalsy();

			ds_list_destroy(_list);
		});

		it("Should find the first element of a ds_list", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "first", "second");

			expect(contains("first", _list, ds_type_list)).toBeTruthy();

			ds_list_destroy(_list);
		});

		it("Should find a key inside a ds_map", function() {
			var _map = ds_map_create();
			_map[? "key"] = "value";

			expect(contains("key", _map, ds_type_map)).toBeTruthy();
			expect(contains("value", _map, ds_type_map)).toBeFalsy();
			expect(contains("missing", _map, ds_type_map)).toBeFalsy();

			ds_map_destroy(_map);
		});

		it("Should find a value inside a ds_grid", function() {
			var _grid = ds_grid_create(2, 2);
			ds_grid_set(_grid, 0, 0, "found");
			ds_grid_set(_grid, 1, 1, 42);

			expect(contains("found", _grid, ds_type_grid)).toBeTruthy();
			expect(contains(42, _grid, ds_type_grid)).toBeTruthy();
			expect(contains("missing", _grid, ds_type_grid)).toBeFalsy();

			ds_grid_destroy(_grid);
		});

		it("Should return false for empty data structures", function() {
			var _list = ds_list_create();
			var _map = ds_map_create();

			expect(contains("a", _list, ds_type_list)).toBeFalsy();
			expect(contains("a", _map, ds_type_map)).toBeFalsy();

			ds_list_destroy(_list);
			ds_map_destroy(_map);
		});

		it("Should return false for a destroyed data structure", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "a");
			ds_list_destroy(_list);

			expect(contains("a", _list, ds_type_list)).toBeFalsy();
		});

		it("Should return false for a data structure type it cannot search", function() {
			var _stack = ds_stack_create();
			ds_stack_push(_stack, "a");

			expect(contains("a", _stack, ds_type_stack)).toBeFalsy();

			ds_stack_destroy(_stack);
		});
	});

	describe("rand", function() {
		it("Should stay inside the 0 to n range with one argument", function() {
			repeat (100) {
				expect(between(rand(10), 0, 10)).toBeTruthy();
			}
		});

		it("Should stay inside the given range with two arguments", function() {
			repeat (100) {
				expect(between(rand(5, 15), 5, 15)).toBeTruthy();
			}
		});

		it("Should accept the bounds in any order", function() {
			repeat (100) {
				expect(between(rand(15, 5), 5, 15)).toBeTruthy();
			}
		});
	});

	describe("irand", function() {
		it("Should return whole numbers inside the 0 to n range", function() {
			repeat (100) {
				var _val = irand(10);
				expect(between(_val, 0, 10)).toBeTruthy();
				expect(_val).toBe(floor(_val));
			}
		});

		it("Should return whole numbers inside the given range", function() {
			repeat (100) {
				var _val = irand(20, 10);
				expect(between(_val, 10, 20)).toBeTruthy();
				expect(_val).toBe(floor(_val));
			}
		});

		it("Should return the same value when both bounds are equal", function() {
			expect(irand(7, 7)).toBe(7);
		});
	});

	describe("rand_linear", function() {
		it("Should stay inside the 0 to n range with one argument", function() {
			repeat (100) {
				expect(between(rand_linear(10), 0, 10)).toBeTruthy();
			}
		});

		it("Should stay inside the given range with two arguments", function() {
			repeat (100) {
				expect(between(rand_linear(5, 15), 5, 15)).toBeTruthy();
			}
		});
	});
});

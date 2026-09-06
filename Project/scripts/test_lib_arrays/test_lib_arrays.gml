suite(function() {
	describe("array_fill", function() {
		it("Should fill the array with reals", function() {
			var _arr = [0, 0, 0, 0];
			array_fill(_arr, 1);
			expect(_arr).toBeEqual([1, 1, 1, 1]);
		});
		
		it("Should fill the array with strings", function() {
			var _arr = [0, 0, 0, 0];
			array_fill(_arr, "abc");
			expect(_arr).toBeEqual(["abc", "abc", "abc", "abc"]);
		});
		
		it("Should fill the array with undefined", function() {
			var _arr = [1, 2, 3];
			array_fill(_arr, undefined);
			expect(_arr).toHaveLength(3);
			expect(_arr[0]).toBe(undefined);
			expect(_arr[2]).toBe(undefined);
		});
		
		it("Should leave an empty array untouched", function() {
			var _arr = [];
			array_fill(_arr, 1);
			expect(_arr).toBeEqual([]);
		});
		
		it("Should fill the array through its reference", function() {
			var _arr = [0, 0];
			var _ref = _arr;
			array_fill(_ref, 9);
			expect(_arr).toBeEqual([9, 9]);
		});
	});
	
	describe("array_clear", function() {
		it("Should clear the array", function() {
			var _arr = [0, 1, 2, 3];
			array_clear(_arr);
			expect(_arr).toBeEqual([]);
		});
		
		it("Should keep an already empty array empty", function() {
			var _arr = [];
			array_clear(_arr);
			expect(_arr).toBeEqual([]);
		});
		
		it("Should clear the array through its reference", function() {
			var _arr = [1, 2, 3];
			var _ref = _arr;
			array_clear(_ref);
			expect(_arr).toHaveLength(0);
		});
	});
	
	describe("array_empty", function() {
		it("Should return true since the array is empty", function() {
			var _arr = [];
			expect(array_empty(_arr)).toBeTruthy();
		});
		
		it("Should return false since the array is not empty", function() {
			var _arr = [1, 2, 3];
			expect(array_empty(_arr)).toBeFalsy();
		});
		
		it("Should return false for an array holding only undefined", function() {
			var _arr = [undefined];
			expect(array_empty(_arr)).toBeFalsy();
		});
	});
	
	describe("array_find_index_by_value", function() {
		it("Should return the exact index of each value", function() {
			var _arr = [10, "mango", "pear", undefined, 255, 1.25, 10.654];
			
			expect(array_find_index_by_value(_arr, 10)).toBe(0);
			expect(array_find_index_by_value(_arr, "mango")).toBe(1);
			expect(array_find_index_by_value(_arr, "pear")).toBe(2);
			expect(array_find_index_by_value(_arr, undefined)).toBe(3);
			expect(array_find_index_by_value(_arr, 255)).toBe(4);
			expect(array_find_index_by_value(_arr, 1.25)).toBe(5);
			expect(array_find_index_by_value(_arr, 10.654)).toBe(6);
		});
		
		it("Should return -1 when the value is not in the array", function() {
			var _arr = [10, "mango", "pear", undefined, 255, 1.25, 1.3333];
			
			expect(array_find_index_by_value(_arr, 100)).toBe(-1);
			expect(array_find_index_by_value(_arr, "apple")).toBe(-1);
			expect(array_find_index_by_value(_arr, 1.3334)).toBe(-1);
		});
		
		it("Should return -1 on an empty array", function() {
			expect(array_find_index_by_value([], 1)).toBe(-1);
		});
		
		it("Should return the index of the first match only", function() {
			expect(array_find_index_by_value(["a", "b", "a"], "a")).toBe(0);
		});
	});
	
	describe("array_to_ds_list", function() {
		it("Should convert the array to a ds_list", function() {
			var _arr = ["mango", "pear", "apple"];
			var _list = array_to_ds_list(_arr);
			
			expect(ds_list_size(_list)).toBe(3);
			expect(_list[| 0]).toBe(_arr[@ 0]);
			expect(_list[| 1]).toBe(_arr[@ 1]);
			expect(_list[| 2]).toBe(_arr[@ 2]);
			
			ds_list_destroy(_list);
		});
		
		it("Should convert an empty array to an empty ds_list", function() {
			var _list = array_to_ds_list([]);
			
			expect(ds_list_size(_list)).toBe(0);
			
			ds_list_destroy(_list);
		});
		
		it("Should keep mixed value types", function() {
			var _arr = [1, "two", undefined];
			var _list = array_to_ds_list(_arr);
			
			expect(_list[| 0]).toBe(1);
			expect(_list[| 1]).toBe("two");
			expect(_list[| 2]).toBe(undefined);
			
			ds_list_destroy(_list);
		});
	});
	
	describe("ds_list_to_array", function() {
		it("Should convert the ds_list to an array", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "mango", "pear", "apple");
			var _arr = ds_list_to_array(_list);
			
			expect(_arr).toHaveLength(3);
			expect(_arr[@ 0]).toBe(_list[| 0]);
			expect(_arr[@ 1]).toBe(_list[| 1]);
			expect(_arr[@ 2]).toBe(_list[| 2]);
			
			ds_list_destroy(_list);
		});
		
		it("Should convert an empty ds_list to an empty array", function() {
			var _list = ds_list_create();
			var _arr = ds_list_to_array(_list);
			
			expect(_arr).toBeEqual([]);
			
			ds_list_destroy(_list);
		});
		
		it("Should round-trip an array without losing values", function() {
			var _arr = [1, "two", 3.5];
			var _list = array_to_ds_list(_arr);
			
			expect(ds_list_to_array(_list)).toBeEqual(_arr);
			
			ds_list_destroy(_list);
		});
	});
	
	describe("array_to_struct", function() {
		it("Should convert the array to an struct", function() {
			var _arr = ["mango", "pear", "apple"];
			var _struct = array_to_struct(_arr);
			
			expect(_struct).toHaveLength(3);
			expect(_struct).toHaveProperty("0", "mango");
			expect(_struct).toHaveProperty("1", "pear");
			expect(_struct).toHaveProperty("2", "apple");
			
			delete _struct;
		});
		
		it("Should convert an empty array to an empty struct", function() {
			var _struct = array_to_struct([]);
			
			expect(_struct).toHaveLength(0);
			
			delete _struct;
		});
		
		it("Should keep an inner array as a single value", function() {
			var _struct = array_to_struct([[1, 2], [3, 4]]);
			
			expect(_struct).toHaveLength(2);
			expect(_struct[$ "0"]).toBeEqual([1, 2]);
			expect(_struct[$ "1"]).toBeEqual([3, 4]);
			
			delete _struct;
		});
	});
	
	describe("sort macros", function() {
		it("Should sort reals ascending and descending", function() {
			var _asc = [5, 1, 4, 2, 3];
			array_sort(_asc, sort_ascending);
			expect(_asc).toBeEqual([1, 2, 3, 4, 5]);
			
			var _desc = [5, 1, 4, 2, 3];
			array_sort(_desc, sort_descending);
			expect(_desc).toBeEqual([5, 4, 3, 2, 1]);
		});
		
		it("Should sort elements by their size ascending and descending", function() {
			var _asc = ["dddd", "a", "ccc", "bb"];
			array_sort(_asc, sort_elem_size_asc);
			expect(_asc).toBeEqual(["a", "bb", "ccc", "dddd"]);
			
			var _desc = ["a", "dddd", "bb", "ccc"];
			array_sort(_desc, sort_elem_size_desc);
			expect(_desc).toBeEqual(["dddd", "ccc", "bb", "a"]);
		});
		
		it("Should sort inner arrays by their length", function() {
			var _arr = [[1, 2, 3], [1], [1, 2]];
			array_sort(_arr, sort_elem_size_asc);
			
			expect(_arr[0]).toBeEqual([1]);
			expect(_arr[1]).toBeEqual([1, 2]);
			expect(_arr[2]).toBeEqual([1, 2, 3]);
		});
	});

	describe("array_chunk", function() {
		it("Should split the array in even chunks", function() {
			expect(array_chunk([1, 2, 3, 4], 2)).toBeEqual([[1, 2], [3, 4]]);
		});

		it("Should put the remainder in the last chunk", function() {
			var _chunks = array_chunk([1, 2, 3, 4, 5], 2);

			expect(_chunks).toHaveLength(3);
			expect(_chunks[2]).toBeEqual([5]);
		});

		it("Should return one chunk when the size is bigger than the array", function() {
			expect(array_chunk([1, 2], 10)).toBeEqual([[1, 2]]);
		});

		it("Should return one chunk per element for a size of 1", function() {
			expect(array_chunk([1, 2, 3], 1)).toBeEqual([[1], [2], [3]]);
		});

		it("Should return an empty array for an empty input", function() {
			expect(array_chunk([], 2)).toBeEqual([]);
		});

		it("Should return an empty array for a size of 0 or less", function() {
			expect(array_chunk([1, 2, 3], 0)).toBeEqual([]);
			expect(array_chunk([1, 2, 3], -1)).toBeEqual([]);
		});
	});

	describe("array_flatten", function() {
		it("Should unwrap one level of nesting", function() {
			expect(array_flatten([[1, 2], [3, 4]])).toBeEqual([1, 2, 3, 4]);
		});

		it("Should unwrap every level by default", function() {
			expect(array_flatten([1, [2, [3, [4]]]])).toBeEqual([1, 2, 3, 4]);
		});

		it("Should stop at the given depth", function() {
			expect(array_flatten([1, [2, [3]]], 1)).toBeEqual([1, 2, [3]]);
			expect(array_flatten([1, [2, [3]]], 0)).toBeEqual([1, [2, [3]]]);
		});

		it("Should keep a flat array as it is", function() {
			expect(array_flatten([1, 2, 3])).toBeEqual([1, 2, 3]);
		});

		it("Should drop empty nested arrays", function() {
			expect(array_flatten([1, [], [2]])).toBeEqual([1, 2]);
		});

		it("Should return an empty array for an empty input", function() {
			expect(array_flatten([])).toBeEqual([]);
		});

		it("Should not modify the original array", function() {
			var _arr = [1, [2, 3]];
			array_flatten(_arr);

			expect(_arr).toHaveLength(2);
			expect(_arr[1]).toBeEqual([2, 3]);
		});
	});

	describe("array_group_by", function() {
		it("Should group the elements by the callback result", function() {
			var _groups = array_group_by([1, 2, 3, 4, 5], function (_value) {
				return (_value mod 2 == 0) ? "even" : "odd";
			});

			expect(_groups.even).toBeEqual([2, 4]);
			expect(_groups.odd).toBeEqual([1, 3, 5]);
		});

		it("Should pass the index to the callback", function() {
			var _groups = array_group_by(["a", "b", "c"], function (_value, _index) {
				return _index < 2 ? "first" : "rest";
			});

			expect(_groups.first).toBeEqual(["a", "b"]);
			expect(_groups.rest).toBeEqual(["c"]);
		});

		it("Should convert the key to a string", function() {
			var _groups = array_group_by([1, 2], function (_value) {
				return _value;
			});

			expect(struct_key_exists(_groups, "1")).toBeTruthy();
			expect(struct_key_exists(_groups, "2")).toBeTruthy();
		});

		it("Should return a single group when every key matches", function() {
			var _groups = array_group_by([1, 2, 3], function (_value) {
				return "all";
			});

			expect(_groups).toHaveLength(1);
			expect(_groups.all).toBeEqual([1, 2, 3]);
		});

		it("Should return an empty struct for an empty array", function() {
			expect(array_group_by([], function (_value) { return "a"; })).toHaveLength(0);
		});
	});

	describe("array_sum", function() {
		it("Should add up every number", function() {
			expect(array_sum([1, 2, 3, 4])).toBe(10);
			expect(array_sum([1.5, 2.5])).toBe(4);
			expect(array_sum([-5, 5])).toBe(0);
		});

		it("Should ignore the values that are not numbers", function() {
			expect(array_sum([1, "two", 3, undefined])).toBe(4);
		});

		it("Should return 0 for an empty array", function() {
			expect(array_sum([])).toBe(0);
			expect(array_sum(["a", "b"])).toBe(0);
		});
	});

	describe("array_mean", function() {
		it("Should return the average of the numbers", function() {
			expect(array_mean([1, 2, 3])).toBe(2);
			expect(array_mean([10, 20])).toBe(15);
			expect(array_mean([5])).toBe(5);
		});

		it("Should only count the numeric values", function() {
			expect(array_mean([1, "skip", 3])).toBe(2);
		});

		it("Should return 0 for an array without numbers", function() {
			expect(array_mean([])).toBe(0);
			expect(array_mean(["a"])).toBe(0);
		});
	});

	describe("array_median", function() {
		it("Should return the middle value of an odd amount", function() {
			expect(array_median([1, 2, 3])).toBe(2);
			expect(array_median([5, 1, 3])).toBe(3);
		});

		it("Should average the two middle values of an even amount", function() {
			expect(array_median([1, 2, 3, 4])).toBe(2.5);
			expect(array_median([4, 1, 3, 2])).toBe(2.5);
		});

		it("Should not depend on the order of the array", function() {
			expect(array_median([9, 1, 5])).toBe(array_median([1, 5, 9]));
		});

		it("Should not modify the original array", function() {
			var _arr = [3, 1, 2];
			array_median(_arr);

			expect(_arr).toBeEqual([3, 1, 2]);
		});

		it("Should only count the numeric values", function() {
			expect(array_median([1, "skip", 3, "skip", 5])).toBe(3);
		});

		it("Should return 0 for an array without numbers", function() {
			expect(array_median([])).toBe(0);
			expect(array_median(["a"])).toBe(0);
		});
	});

	describe("array_sample", function() {
		it("Should return an array with the requested amount", function() {
			expect(array_sample([1, 2, 3, 4, 5], 3)).toHaveLength(3);
			expect(array_sample([1, 2, 3], 1)).toHaveLength(1);
		});

		it("Should default to a single element", function() {
			expect(array_sample([1, 2, 3])).toHaveLength(1);
		});

		it("Should only return elements of the array", function() {
			var _source = ["a", "b", "c", "d"];

			repeat (50) {
				var _sample = array_sample(_source, 2);
				expect(contains(_sample[0], _source)).toBeTruthy();
				expect(contains(_sample[1], _source)).toBeTruthy();
			}
		});

		it("Should never repeat an element by default", function() {
			repeat (50) {
				var _sample = array_sample([1, 2, 3, 4], 4);
				array_sort(_sample, sort_ascending);
				expect(_sample).toBeEqual([1, 2, 3, 4]);
			}
		});

		it("Should cap an unique sample to the array length", function() {
			expect(array_sample([1, 2], 10)).toHaveLength(2);
		});

		it("Should allow repeats when unique is false", function() {
			expect(array_sample([1], 5, false)).toBeEqual([1, 1, 1, 1, 1]);
			expect(array_sample([1, 2], 10, false)).toHaveLength(10);
		});

		it("Should return an empty array for an empty input or a count below 1", function() {
			expect(array_sample([], 3)).toBeEqual([]);
			expect(array_sample([1, 2], 0)).toBeEqual([]);
			expect(array_sample([1, 2], -1)).toBeEqual([]);
		});

		it("Should not modify the original array", function() {
			var _arr = [1, 2, 3];
			array_sample(_arr, 3);

			expect(_arr).toBeEqual([1, 2, 3]);
		});
	});

	describe("array_swap", function() {
		it("Should swap the two elements in place", function() {
			var _arr = [1, 2, 3];
			array_swap(_arr, 0, 2);

			expect(_arr).toBeEqual([3, 2, 1]);
		});

		it("Should return the same array", function() {
			var _arr = [1, 2];

			expect(array_swap(_arr, 0, 1)).toBeEqual([2, 1]);
			expect(_arr).toBeEqual([2, 1]);
		});

		it("Should do nothing when both indexes are the same", function() {
			var _arr = [1, 2, 3];
			array_swap(_arr, 1, 1);

			expect(_arr).toBeEqual([1, 2, 3]);
		});

		it("Should leave the array untouched for an index out of bounds", function() {
			var _arr = [1, 2, 3];

			array_swap(_arr, 0, 5);
			expect(_arr).toBeEqual([1, 2, 3]);

			array_swap(_arr, -1, 1);
			expect(_arr).toBeEqual([1, 2, 3]);
		});

		it("Should swap values of different types", function() {
			var _arr = ["a", 2];
			array_swap(_arr, 0, 1);

			expect(_arr[0]).toBe(2);
			expect(_arr[1]).toBe("a");
		});
	});

});

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
	});
	
	describe("array_clear", function() {
		it("Should clear the array", function() {
			var _arr = [0, 1, 2, 3];
			array_clear(_arr);
			expect(_arr).toBeEqual([]);
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
	});
	
	describe("array_find_index_by_value", function() {
		it("Should find the index of different values on array", function() {
			var _arr = [10, "mango", "pear", undefined, 255, 1.25, 10.654];
			
			expect(array_find_index_by_value(_arr, 255)).toBeTruthy();
			expect(array_find_index_by_value(_arr, 1.25)).toBeTruthy();
			expect(array_find_index_by_value(_arr, "pear")).toBeTruthy();
			expect(array_find_index_by_value(_arr, 10.654)).toBeTruthy();
		});
		
		it("Should not find the index of different values on array", function() {
			var _arr = [10, "mango", "pear", undefined, 255, 1.25, 1.3333];
			
			expect(array_find_index_by_value(_arr, 100)).toBeFalsy();
			expect(array_find_index_by_value(_arr, "apple")).toBeFalsy();
		});
	});
	
	describe("array_to_ds_list", function() {
		it("Should convert the array to a ds_list", function() {
			var _arr = ["mango", "pear", "apple"];
			var _list = array_to_ds_list(_arr);
			
			expect(_list[| 0]).toBe(_arr[@ 0]);
			expect(_list[| 1]).toBe(_arr[@ 1]);
			expect(_list[| 2]).toBe(_arr[@ 2]);
			
			ds_list_destroy(_list);
		})
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
		})
	});
	
	describe("array_to_struct", function() {
		it("Should convert the array to an struct", function() {
			var _arr = ["mango", "pear", "apple"];
			var _struct = array_to_struct(_arr);
			
			expect(_struct).toHaveProperty("0", "mango");
			expect(_struct).toHaveProperty("1", "pear");
			expect(_struct).toHaveProperty("2", "apple");
			
			delete _struct;
		})
	});
	
	describe("array_write", function() {
		it("Should convert the array to an string", function() {
			var _arr = ["mango", "pear", "apple"];
			var _str = array_write(_arr);
			
			expect(string_pos(_arr[@ 0], _str)).toBeTruthy();
			expect(string_pos(_arr[@ 1], _str)).toBeTruthy();
			expect(string_pos(_arr[@ 2], _str)).toBeTruthy();
			expect(_str).toBeEqual("[ \"mango\",\"pear\",\"apple\" ]");

		})
	});
});

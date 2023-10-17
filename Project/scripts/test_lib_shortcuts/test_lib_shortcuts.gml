suite(function () {
	describe("del", function() {
		it("Should destroy an object", function() {
			var _inst = instance_create_depth(0, 0, 0, o_gml_ext_tests_draw);
			expect(instance_exists(_inst)).toBeTruthy();			
			del(_inst);
			expect(instance_exists(_inst)).toBeFalsy();
		})
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
	});
});
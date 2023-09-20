function __gmtl_internal_function_test() {
	describe("Test GMTL stuff", function() {
		it("Should pass", function() {
			var _a = 0;
			_a++;
			expect(_a).toBe(1);
			
			var _b = ["apple", "mango", "pineapple"];
			expect(_b[1]).toBe("mango");
			expect(_a == _b[1]).toBe(false);
			expect(_b).toHaveLength(3);
			
			var _c = {testKey: "test"};
			expect(_c).toHaveLength(1);
			expect(_c.testKey).toHaveLength(4);
			expect(_c).toHaveProperty("testKey");
			expect(_c).toHaveProperty("testKey", "test");
			
			expect(_c).toBe(_a);
		});
		
		it("Should fail", function() {
			instance_create_depth(0, 0, 0, obj_unexistent);
		});
		
		it("Should be skipped", function() {
			show_message("This should never be seen :)");
		});
	});
}
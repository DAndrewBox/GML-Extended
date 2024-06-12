// Uncomment this to test
suite(function() {
	describe("GameMaker's Testing Library - Demo Tests", function() {
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
		});
		
		each("Should {0} + {1} be {2}. (Multiple cases test)", function(_arg1, _arg2, _arg3) {
			expect(_arg1 + _arg2).toBe(_arg3);
		},
		[
			[1, 1, 2],
			[5, 5, 10],
			[3, 6, 9],
			[-5, 5, 0]
		]);
		
		it("Should create an instance, wait, and check timer.", function() {
			var _inst = create(10, 10, o_gmtl_demo_timer);
			_inst.waitFor(5, time_source_units_frames);
			
			expect(_inst).toHaveProperty("timer", 5);
		});
		
		it("Should fail", function() {
			instance_create_depth(0, 0, 0, obj_unexistent);
		});
		
		it("Should be skipped", function() {
			show_message("This should never be seen :)");
		});
	});
});
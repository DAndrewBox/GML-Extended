// Uncomment this to test
suite(function() {		
	describe("GameMaker's Testing Library - Demo Tests", function() {		
		#region Before/After - Each/All
		/*
			The execution order for this functions per suite is:
			> Suite starts
			> Start describe
				> Run beforeAll()
				> Start loop of it/test
					> Run beforeEach()
					> Run it/test
					> Run afterEach()
				> Finish loop of it/test
				> Run afterAll()
			> Finish describe
			> Suite ends
		*/
		
		beforeAll(function() {
			// This runs before all tests starts
			show_debug_message("Before all!");
		});
	
		afterAll(function() {
			// This runs after all tests are completed
			show_debug_message("After all!");
		});
	
		beforeEach(function() {
			// This runs before EACH test starts
			show_debug_message("Before each!");
		});
		
		afterEach(function() {
			// This runs after EACH test ends
			show_debug_message("After each!");
		});
		#endregion	
		
		// A simple test for almost all methods
		it("Should pass", function() {
			var _a = 0;
			_a++;
			expect(_a).toBe(1);
			
			var _b = ["apple", "mango", "pineapple"];
			expect(_b[1]).toBe("mango");
			expect(_a == _b[1]).toBe(false);
			expect(_b).toHaveLength(3);
			expect(_b).toContain("apple");
			
			var _c = {testKey: "test"};
			expect(_c).toHaveLength(1);
			expect(_c.testKey).toHaveLength(4);
			expect(_c).toHaveProperty("testKey");
			expect(_c).toHaveProperty("testKey", "test");
		});
		
		// This one test multiple cases provided as a 2D array
		each("Should {0} + {1} be {2}. (Multiple cases test)", function(_arg1, _arg2, _arg3) {
			expect(_arg1 + _arg2).toBe(_arg3);
		},
		[
			[1, 1, 2],
			[5, 5, 10],
			[3, 6, 9],
			[-5, 5, 0]
		]);
		
		// This should create and test an instance
		it("Should create an instance, wait, and check timer.", function() {
			var _inst = create(10, 10, o_gmtl_demo_timer);
			_inst.waitFor(5, time_source_units_frames);
			
			expect(_inst).toHaveProperty("timer", 5);
			
			_inst.waitFor(2, time_source_units_seconds);
			
			// Assuming gamespeed to be 60 fps / sec, so 5 + (60 frames * 2 seconds)
			expect(_inst.timer).toBeEqual(125);
			
			// You should destroy the instance after test, if not, could cause memory leaks.
			instance_destroy(_inst);
		});
		
		// This test should fail because object doesn't exists
		it("Should fail", function() {
			var _inst = create(0, 0, obj_unexistent);
			instance_destroy(_inst);
		});
		
		// This test should be skipped since last test in the describe event failed.
		// You can make this test pass if you move it before the failed test.
		it("Should be skipped", function() {
			show_message_async("This should never be seen :)");
		});
	});
});
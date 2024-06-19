suite(function() {
	describe("mouse_in_area", function() {
		it("Should return true if mouse is inside an area", function() {
			simulateMousePosition(50, 50);
			expect(mouse_in_area(0, 0, 100, 100)).toBeTruthy();
			expect(mouse_in_area(25, 25, 75, 75)).toBeTruthy();
			expect(mouse_in_area(50, 50, 50, 50)).toBeTruthy();
		});
		
		it("Should return false if mouse is outside area", function() {
			simulateMousePosition(200, 200);
			expect(mouse_in_area(0, 0, 100, 100)).toBeFalsy();
			expect(mouse_in_area(25, 25, 75, 75)).toBeFalsy();
			expect(mouse_in_area(50, 50, 50, 50)).toBeFalsy();
		});
	});
	
	describe("mouse_in_instance", function() {
		it("Should return true if mouse is inside an instance", function() {
			var _inst = create(100, 100, o_gml_ext_tests_draw);
			simulateMousePosition(_inst.x, _inst.y);
			expect(mouse_in_instance(_inst)).toBeTruthy();
			expect(mouse_in_instance(o_gml_ext_tests_draw)).toBeTruthy();
			
			instance_destroy(_inst);
		});
		
		it("Should return false if mouse is outside instance", function() {
			var _inst = create(100, 100, o_gml_ext_tests_draw);
			simulateMousePosition(0, 0);
			expect(mouse_in_instance(_inst)).toBeFalsy();
			expect(mouse_in_instance(o_gml_ext_tests_draw)).toBeFalsy();
			
			instance_destroy(_inst);
		});
	});
});
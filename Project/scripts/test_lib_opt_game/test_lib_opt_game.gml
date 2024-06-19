suite(function() {
	describe("game_params", function() {
		it("Should get all the starting game params", function() {
			var _game_params_len = parameter_count();
			expect(game_params()).toHaveLength(_game_params_len);
		});
	});
	
	describe("game_get_param_value", function() {
		it("Should get param value for '-game' correctly", function() {
			expect(game_get_param_value("-game")).toBeTruthy();
		});
		
		it("Should not get param value if doesn't exists", function() {
			expect(game_get_param_value("-version")).toBe(0);
		});
	});
	
	describe("game_get_param_exists", function() {
		it("Should get an existing parameter", function() {
			expect(game_get_param_exists("-game")).toBeTruthy();
		});
		
		it("Should not get an existing parameter", function() {
			expect(game_get_param_exists("-version")).toBeFalsy();
		});
	});
});

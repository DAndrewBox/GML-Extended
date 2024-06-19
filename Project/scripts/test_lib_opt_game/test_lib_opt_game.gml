suite(function() {
	describe("game_params", function() {
		it("Should get all the starting game params", function() {
			var _game_params_len = get_size(parameter_count());
			expect(game_params()).toHaveLength(_game_params_len);
		});
	});
	
	describe("game_get_param_value", function() {
		it("Should get param value for '-game' correctly", function() {
			expect(game_get_param_value("-game")).toBeTruthy();
		});
	});
});

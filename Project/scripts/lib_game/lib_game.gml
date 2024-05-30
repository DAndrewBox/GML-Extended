/// @func	game_params()
/// @desc	Gets launch parameters.
function game_params() {
	static _param_count = parameter_count();
	static _param_list = array_create_ext(_param_count, function (i) {
		return parameter_string(i);
	});
	
	return _param_list;
}

/// @func	game_get_param_value(param)
/// @param	{string}	param
/// @desc	Gets the value of a param.
function game_get_param_value(_param) {
	static _params_list = game_params();
	var _param_index = array_find_index_by_value(_params_list, _param);
	
	if (_param_index == -1) {
		return 0;
	}
	
	return _params_list[min(_param_index + 1, get_size(_params_list) - 1)];
}

/// @func	game_get_param_exists(param)
/// @param	{string}	param
/// @desc	Gets a bool telling if the param exists.
function game_get_param_exists(_param) {
	static _params_list = game_params();
	return bool(array_find_index_by_value(_params_list, _param) + 1);
}

/// @func	game_throw_error(message)
/// @param	{string}	message
function game_throw_error(_msg) {
	show_error($"Error: {_msg}", true);
}

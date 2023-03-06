/// @func	string_contains(string, substring)
/// @param	{str}	string
/// @param	{str}	substring
function string_contains(_str, _substr) {
	return string_pos(_substr, _str) > 0;
}

/// @func string_title(string)
/// @param	{str}	string
function string_title(_str) {
	var _out = "";
	var _prev_char = " ";
	
	for (var i = 1; i <= string_length(_str); i++) {
		var _char = string_copy(_str, i, 1);
		if (_prev_char == " ") {
			_out += string_upper(_char);
			_prev_char = "";
			continue;
		}
		
		_prev_char = _char;
		_out += _char;
	}
	
    return _out;
}

/// @func	string_remove(string, substring)
/// @param	{str}		string
/// @param	{str|array}	substring
function string_remove(_str, _substr) {
	if (is_array(_substr)) {
		for (var i = 0; i < array_length(_substr); i++) {
			_str = string_remove(_str, _substr[i]);
		}
		
		return _str;
	}
	
	return string_replace_all(_str, _substr, "");
}

/// @func	string_pad_left(string, char, size)
/// @param	{str}	string
/// @param	{str}	char
/// @param	{real}	size
function string_pad_left(_str, _char, _size) {
	var _pad = "";
	var _pad_size = _size - string_length(_str);
	
	for (var i = 0; i < _pad_size; i++) {
		_pad += _char;
	}
	
	return _pad + _str;
}

/// @func	string_pad_right(string, char, size)
/// @param	{str}	string
/// @param	{str}	char
/// @param	{real}	size
function string_pad_right(_str, _char, _size) {
	var _pad = "";
	var _pad_size = _size - string_length(_str);
	
	for (var i = 0; i < _pad_size; i++) {
		_pad += _char;
	}
	
	return _str + _pad;
}
/// @func	string_fill_zero(string, size, [on_left])
/// @param	{string}	string
/// @param	{real}		size
/// @param	{bool}		[on_left]
/// @desc	Returns a string filled with 0's on any side.
function string_fill_zero(_org_str, _size, _on_left = true) {
	// Calculate how many 0's need to be padded on to the string
	var _str = string(_org_str);
	var _pad = "";

	for (var i = 0; i < _size - string_length(_str); i++) {
		_pad += "0";
	}
	
	return ( _on_left ? _pad + _str : _str + _pad );
}

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

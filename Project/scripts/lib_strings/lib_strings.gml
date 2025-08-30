/// @func	string_contains(string, substring)
/// @param	{String}	string
/// @param	{String}	substring
/// @desc	Returns true if the string contains the substring.
function string_contains(_str, _substr) {
	return string_pos(_substr, _str) > 0;
}

/// @func string_title(string)
/// @param	{String}	string
/// @desc	Returns a string with the first letter of each word capitalized.
function string_title(_str) {
	var _out		= "";
	var _prev_char	= " ";
	var _str_len	= string_length(_str);
	
	for (var i = 1; i <= _str_len; i++) {
		var _char = string_char_at(_str, i);
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
/// @param	{String}					string
/// @param	{String | Array<String>}	substring
/// @desc	Returns a string with the specified substring removed.
function string_remove(_str, _substr) {
	if (is_array(_substr)) {
		var _arr_len = array_length(_substr);
		for (var i = 0; i < _arr_len; i++) {
			_str = string_remove(_str, _substr[i]);
		}
		
		return _str;
	}
	
	return string_replace_all(_str, _substr, "");
}

/// @func	string_pad_left(string, char, size)
/// @param	{String}	string
/// @param	{String}	char
/// @param	{Real}		size
/// @desc	Returns a string with the specified number of characters on the left side.
///			If the string is already bigger than the specified size, the string will be returned as is.
///			If the string is smaller than the specified size, the string will be filled with the specified character on the left side.
function string_pad_left(_str, _char, _size) {
	if (_char == "") return _str;
	var _pad = "";
	var _pad_size = _size - string_length(_str);
	
	for (var i = 0; i < _pad_size; i++) {
		_pad += _char;
	}
	
	return _pad + _str;
}

/// @func	string_pad_right(string, char, size)
/// @param	{String}	string
/// @param	{String}	char
/// @param	{Real}		size
/// @desc	Returns a string with the specified number of characters on the right side.
///			If the string is already bigger than the specified size, the string will be returned as is.
///			If the string is smaller than the specified size, the string will be filled with the specified character on the right side.
function string_pad_right(_str, _char, _size) {
	if (_char == "") return _str;
	var _pad = "";
	var _pad_size = _size - string_length(_str);
	
	for (var i = 0; i < _pad_size; i++) {
		_pad += _char;
	}
	
	return _str + _pad;
}

/// @func	string_percentage(current_value, 100%_value)
/// @param	{Real}	current_value
/// @param	{Real}	100%_value
/// @desc	Returns a string with the percentage of the given values.
function string_percentage(_val, _max) {	
	return string(percentage(_val, _max)) + "%";
}

/// @func	string_contains(string, substring)
/// @param	{String}	string		The string to check.
/// @param	{String}	substring	The substring to use.
/// @desc	Returns true if the string contains the substring.
///	@return	{Bool}
function string_contains(_str, _substr) {
	return string_pos(_substr, _str) > 0;
}

/// @func string_title(string)
/// @param	{String}	string		The string to check
/// @desc	Returns a string with the first letter of each word capitalized.
///	@return	{String}
function string_title(_str) {
	var _out		= "";
	var _prev_char	= " ";
	var _str_len	= string_length(_str);
	
	for (var i = 1; i <= _str_len; i++) {
		var _char = string_char_at(_str, i);
		if (_prev_char == " ") {
			_out += string_upper(_char);
			_prev_char = _char;
			continue;
		}
		
		_prev_char = _char;
		_out += _char;
	}
	
    return _out;
}

/// @func	string_remove(string, substring)
/// @param	{String}					string		The string to check.
/// @param	{String | Array<String>}	substring	The array of strings or substring to use.
/// @desc	Returns a string with the specified substring removed.
///	@return	{String}
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

/// @func	string_remove_duplicate_chars(string, [char])
/// @param	{String}	string		The string to clean up.
/// @param	{String}	char		Optional. The character or sequence to collapse. (Default: " ")
/// @desc	Returns a string where every run of the given character is collapsed into a single one. Useful to turn double spaces into one space, `..` into `.`, and so on.
///	@return	{String}
function string_remove_duplicate_chars(_str, _char = " ") {
	_str = string(_str);
	if (_char == "") return _str;

	var _char_len = string_length(_char);
	var _str_len = string_length(_str);
	var _out = "";
	var _pos = 1;
	var _was_char = false;

	while (_pos <= _str_len) {
		if (string_copy(_str, _pos, _char_len) == _char) {
			if (!_was_char) _out += _char;
			_was_char = true;
			_pos += _char_len;
			continue;
		}

		_was_char = false;
		_out += string_char_at(_str, _pos);
		_pos++;
	}

	return _out;
}

/// @func	string_pad_left(string, char, size)
/// @param	{String}	string		The string to fill.
/// @param	{String}	char		The character to fill the string with.
/// @param	{Real}		size		The final size of the string.
/// @desc	Returns a string with the specified number of characters on the left side. If the string is already bigger than the specified size, the string will be returned as is. If the string is smaller than the specified size, the string will be filled with the specified character on the left side.
///	@return	{String}
function string_pad_left(_str, _char, _size) {
	_str = string(_str);
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
/// @desc	Returns a string with the specified number of characters on the right side. If the string is already bigger than the specified size, the string will be returned as is. If the string is smaller than the specified size, the string will be filled with the specified character on the right side.
///	@return	{String}
function string_pad_right(_str, _char, _size) {
	_str = string(_str);
	if (_char == "") return _str;
	var _pad = "";
	var _pad_size = _size - string_length(_str);
	
	for (var i = 0; i < _pad_size; i++) {
		_pad += _char;
	}
	
	return _str + _pad;
}

/// @func	string_percentage(current_value, total_value)
/// @param	{Real}	current_value		The current value.
/// @param	{Real}	total_value			The total value to compare.
/// @desc	Returns a string with the percentage of the given values.
///	@return	{String}
function string_percentage(_val, _max) {	
	return string(percentage(_val, _max)) + "%";
}

/// @func	string_truncate(string, max_length, [suffix])
/// @param	{String}	string		The string to truncate.
/// @param	{Real}		max_length	The maximum length of the resulting string, suffix included.
/// @param	{String}	suffix		Optional. The text added at the end when the string is cut. (Default: "...")
/// @desc	Returns a string no longer than `max_length`, adding the suffix at the end when it had to be cut. If the suffix does not fit in `max_length` the suffix itself is cut instead.
///	@return	{String}
function string_truncate(_str, _max_len, _suffix = "...") {
	_str = string(_str);
	if (string_length(_str) <= _max_len) return _str;
	if (_max_len <= 0) return "";

	var _suffix_len = string_length(_suffix);
	if (_suffix_len >= _max_len) return string_copy(_suffix, 1, _max_len);

	return string_copy(_str, 1, _max_len - _suffix_len) + _suffix;
}

/// @func	string_to_snake(string)
/// @param	{String}	string		The string to convert.
/// @desc	Returns the string in `snake_case`. Spaces, dashes and underscores separate words, and a capital letter after a lowercase one starts a new word.
///	@return	{String}
function string_to_snake(_str) {
	_str = string(_str);
	var _str_len = string_length(_str);
	var _out = "";
	var _prev_lower = false;

	for (var i = 1; i <= _str_len; i++) {
		var _char = string_char_at(_str, i);

		if (_char == " " || _char == "-" || _char == "_") {
			if (_out != "" && string_char_at(_out, string_length(_out)) != "_") _out += "_";
			_prev_lower = false;
			continue;
		}

		// A capital right after a lowercase letter starts a new word.
		var _is_upper = (_char != string_lower(_char));
		if (_is_upper && _prev_lower && _out != "") _out += "_";

		_out += string_lower(_char);
		_prev_lower = !_is_upper;
	}

	return _out;
}

/// @func	string_to_camel(string)
/// @param	{String}	string		The string to convert.
/// @desc	Returns the string in `camelCase`. Spaces, dashes and underscores separate words, the first letter is always lowercased and every following word is capitalized.
///	@return	{String}
function string_to_camel(_str) {
	_str = string(_str);
	var _str_len = string_length(_str);
	var _out = "";
	var _next_upper = false;

	for (var i = 1; i <= _str_len; i++) {
		var _char = string_char_at(_str, i);

		if (_char == " " || _char == "-" || _char == "_") {
			_next_upper = (_out != "");
			continue;
		}

		if (_next_upper) {
			_out += string_upper(_char);
			_next_upper = false;
			continue;
		}

		_out += (_out == "" ? string_lower(_char) : _char);
	}

	return _out;
}

/// @func	string_slugify(string, [allowed], [separator])
/// @param	{String}	string		The string to convert.
/// @param	{String}	allowed		Optional. The special characters to keep as they are. (Default: "")
/// @param	{String}	separator	Optional. The text used to replace every other character. (Default: "-")
/// @desc	Returns a lowercase URL friendly version of the string. Letters and digits are always kept, every character listed in `allowed` is kept too, and any run of the remaining characters becomes a single separator. Leading and trailing separators are removed.
///	@return	{String}
function string_slugify(_str, _allowed = "", _separator = "-") {
	_str = string_lower(string(_str));
	var _str_len = string_length(_str);
	var _out = "";
	var _was_sep = true;

	for (var i = 1; i <= _str_len; i++) {
		var _char = string_char_at(_str, i);
		var _ord = string_ord_at(_str, i);
		var _is_kept = (_ord >= 97 && _ord <= 122)
			|| (_ord >= 48 && _ord <= 57)
			|| (_allowed != "" && string_pos(_char, _allowed) > 0);

		if (_is_kept) {
			_out += _char;
			_was_sep = false;
			continue;
		}

		// Any run of removed characters collapses into a single separator.
		if (!_was_sep) _out += _separator;
		_was_sep = true;
	}

	// Drop the separator left behind by the characters at the end of the string.
	var _sep_len = string_length(_separator);
	var _out_len = string_length(_out);
	if (_sep_len > 0 && _out_len >= _sep_len && string_copy(_out, _out_len - _sep_len + 1, _sep_len) == _separator) {
		_out = string_copy(_out, 1, _out_len - _sep_len);
	}

	return _out;
}
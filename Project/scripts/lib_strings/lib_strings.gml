/*
	Library:	GM-SIMPLE-STRINGS
	Author:		D'Andrëw Box
	Revision:	2022/07/05
	Version:	1.0
*/
/// @func	string_ext(str, [*args])
/// @param	{str}	str
/// @param	{any}	[*args]
/// @desc	Replace every "{}" with arguments values.
function string_ext(_str){
	var _args = argument_count;
	var _new_str = _str;
	for (var i = 1; i < _args; i++) {
		_new_str = string_replace(_new_str, "{}", string(argument[i]));
	}
	
	return _new_str;
}

/// @func	string_split(str, substr)
/// @param	{str}	str
/// @param	{str}	substr
function string_split(_str, _substr) {
	var _arr = [];
	var _slices = string_count(_substr, _str);
	
	for (var i = 0; i < _slices; i++) {
		var _substr_pos = string_pos(_substr, _str);
		var _slice = string_copy(_str, 1, _substr_pos - 1);
		array_push(_arr, _slice);
		_str = string_delete(_str, 1, _substr_pos);
	}
	
	return _arr;
}

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

/// @func	string_cointains(string, substring)
/// @param	{str}	string
/// @param	{str}	substring
function string_contains(_str, _substr) {
	return string_pos(_substr, _str) > 0;
}
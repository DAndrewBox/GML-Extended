/*
*** DEPRECATED FUNCTIONS CAN BE REMOVED IF YOU ARE NOT USING THEM. ***
*/

/// @func	__obsolete_trace(func_old, func_new)
/// @param	{string}	func_old
/// @param	{string}	func_new
function __obsolete_trace(_old, _new) {
	trace(
		"(GML-Extended) - WARNING! Function '",
		_old,
		"' is obsolete and will be deprecated. Try using '",
		_new,
		"'.",
	);
}

/// @func	size(element)
/// @param	{any}	element
/// @desc	Returns the size or length of the element.
/// @deprecated	since v1.3
function size(_e) {
	__obsolete_trace("size", "get_size");
	return get_size(_e);
}

/// @func	file_to_json(file)
/// @param	{real}	file
/// @desc	Read a file a transforms it into a json struct
/// @deprecated	since v1.3
function file_to_json(_file) {
	__obsolete_trace("file_to_json", "file_json_read");
	return file_json_read(_file);
}

/// @func	string_fill_zero(string, size, [on_left])
/// @param	{string}	string
/// @param	{real}		size
/// @param	{bool}		[on_left]
/// @desc	Returns a string filled with 0's on any side.
/// @deprecated	since v1.3
function string_fill_zero(_org_str, _size, _on_left = true) {
	__obsolete_trace("string_fill_zero", "string_pad_left or string_pad_right");
	return _on_left ? string_pad_left(_org_str, "0", _size) : string_pad_right(_org_str, "0", _size);
}


/// @func	struct_copy(struct)
/// @param	{any}	struct
/// @desc	Returns an exact copy of the struct
/// @deprecated	since v1.4
function struct_copy(_struct) {
	__obsolete_trace("struct_copy", "variable_clone");
	return __gml_ext_comp_variable_clone(_struct);
}

/// @func	json2file(filename, struct, iteration)
/// @param	{string}	filename
/// @param	{any}	struct
/// @param	{real}	iteration
/// @desc	Creates a file from a json struct.
/// @deprecated since v1.5
function json2file(_filename = "", _json = {}, _iteration = 0) {
	__obsolete_trace("json2file", "file_json_create");
	return file_json_create(_filename, _json);
}

///	@func array_write(array)
/// @param	{array}	array
/// @desc	Returns an string of the array.
/// @deprecated since v1.5
function array_write(_array) {
	__obsolete_trace("array_write", "string(array)");
	return string(_array);
}
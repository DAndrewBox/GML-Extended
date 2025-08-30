/*
*** DEPRECATED FUNCTIONS CAN BE REMOVED IF YOU ARE NOT USING THEM. ***
*/

/// @func	__obsolete_trace(func_old, func_new)
/// @param	{String}	func_old
/// @param	{String}	func_new
/// @desc	Function used to log "obsolete" warnings.
/// @ignore
function __obsolete_trace(_old, _new) {
	trace(
		"(GML-Extended) - WARNING! Function '",
		_old,
		"' is obsolete and will be deprecated. Please use '",
		_new,
		"'.",
	);
}

/// @func	size(element)
/// @param	{Any}	element
/// @desc	Returns the size or length of the element. [v1.3 - DEPRECATED]
/// @deprecated
function size(_e) {
	__obsolete_trace("size", "get_size");
	return get_size(_e);
}

/// @func	file_to_json(file)
/// @param	{Real}	file
/// @desc	Read a file a transforms it into a json struct. [v1.3 - DEPRECATED]
/// @deprecated
function file_to_json(_file) {
	__obsolete_trace("file_to_json", "file_json_read");
	return file_json_read(_file);
}

/// @func	string_fill_zero(string, size, [on_left])
/// @param	{String}	string
/// @param	{Real}		size
/// @param	{Bool}		[on_left]
/// @desc	Returns a string filled with 0's on any side. [v1.3 - DEPRECATED]
/// @deprecated
function string_fill_zero(_org_str, _size, _on_left = true) {
	__obsolete_trace("string_fill_zero", "string_pad_left or string_pad_right");
	return _on_left ? string_pad_left(_org_str, "0", _size) : string_pad_right(_org_str, "0", _size);
}


/// @func	struct_copy(struct)
/// @param	{Any}	struct
/// @desc	Returns an exact copy of the struct. [v1.4 - DEPRECATED]
/// @deprecated
function struct_copy(_struct) {
	__obsolete_trace("struct_copy", "variable_clone");
	return __gml_ext_comp_variable_clone(_struct);
}

/// @func	json2file(filename, struct, iteration)
/// @param	{String}	filename
/// @param	{Any}	struct
/// @param	{Real}	iteration
/// @desc	Creates a file from a json struct. [v1.5 - DEPRECATED]
/// @deprecated
function json2file(_filename = "", _json = {}, _iteration = 0) {
	__obsolete_trace("json2file", "file_json_create");
	return file_json_create(_filename, _json);
}

///	@func array_write(array)
/// @param	{Array}	array
/// @desc	Returns an string of the array. [v1.5 - DEPRECATED]
/// @deprecated
function array_write(_array) {
	__obsolete_trace("array_write", "string(array)");
	return string(_array);
}
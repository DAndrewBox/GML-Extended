/// @func	__obsolete_trace(func_old, func_new)
/// @param	{ref}	func_old
/// @param	{ref}	func_new
function __obsolete_trace(_old, _new) {
	trace(
		string(
			"WARNING! Function '{0}' is obsolete and will be deprecated. Try using '{1}'.",
			_old,
			_new
		)
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
	__obsolete_trace("string_fill_zero", "string_pad_left");
	// Calculate how many 0's need to be padded on to the string
	var _str = string(_org_str);
	var _pad = "";

	for (var i = 0; i < _size - string_length(_str); i++) {
		_pad += "0";
	}
	
	return ( _on_left ? _pad + _str : _str + _pad );
}


/// @func	struct_copy(struct)
/// @param	{any}	struct
/// @desc	Returns an exact copy of the struct
function struct_copy(_struct) {
	__obsolete_trace("struct_copy", "variable_clone");
	return variable_clone(_struct);
}
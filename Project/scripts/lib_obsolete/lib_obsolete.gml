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
function size(_e) {
	__obsolete_trace("size", "get_size");
	return get_size(_e);
}

/// @func	string_fill_zero(string, size, [on_left])
/// @param	{string}	string
/// @param	{real}		size
/// @param	{bool}		[on_left]
/// @desc	Returns a string filled with 0's on any side.
function string_fill_zero(_org_str, _size, _on_left = true) {
	// Calculate how many 0's need to be padded on to the string
	__obsolete_trace("string_fill_zero", "string_pad_left");
	var _str = string(_org_str);
	var _pad = "";

	for (var i = 0; i < _size - string_length(_str); i++) {
		_pad += "0";
	}
	
	return ( _on_left ? _pad + _str : _str + _pad );
}
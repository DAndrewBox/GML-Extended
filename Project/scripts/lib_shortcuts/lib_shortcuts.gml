/// @func	del(object_index|id, exec_event);
/// @param	{ref}	object_index|id
/// @param	{bool}	exec_event
/// @desc	A short way to destroy an element
function del(_obj = id, _exec_ev = true) {
	instance_destroy(_obj, _exec_ev);
}

/// @func	size(element)
/// @param	{any}	element
/// @desc	Returns the size or length of the element.
function size(_e) {
	var _type = typeof(_e);
	
	switch(_type) {
		case "array":	return array_length(_e);
		case "struct":	return size(struct_keys(_e));
		case "string":	return string_length(_e);
		case "number":
		case "int32":
		case "int64":	return size(string(_e));
		case "bool":	return 1;
		default:		return -1;
	}
}

/// @func	trace(*args)
/// @param	{any}	*args
/// @desc	A short way to use show_debug_message
function trace() {
	script_execute_ext(show_debug_message, argument);
}

/// @func	alert(*args)
/// @param	{any}	*args
/// @desc	A short way to use show_message
function alert() {
	script_execute_ext(show_message, argument);
}

/// @func	alert_async(*args)
/// @param	{any}	*args
/// @desc	A short way to use show_message_async
function alert_async() {
	script_execute_ext(show_message_async, argument);
}
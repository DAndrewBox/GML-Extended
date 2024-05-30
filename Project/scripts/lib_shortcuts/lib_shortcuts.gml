/// @func	del(object_index|id, exec_event);
/// @param	{Id.Instance|Asset.GMObject}	object_index|id
/// @param	{bool}							exec_event
/// @desc	A short way to destroy an element
function del(_obj = id, _exec_ev = true) {
	instance_destroy(_obj, _exec_ev);
}

/// @func	get_size(element)
/// @param	{any}	element
/// @desc	Returns the size or length of the element.
function get_size(_e) {
	var _type = typeof(_e);
	
	switch(_type) {
		case gm_type_array:		return array_length(_e);
		case gm_type_struct:	return get_size(struct_keys(_e));
		case gm_type_string:	return string_length(_e);
		case gm_type_number:
		case gm_type_int32:
		case gm_type_int64:		return get_size(string(_e));
		case gm_type_bool:		return 1;
		default:				return -1;
	}
}

/// @func	contains(find_this, search_here)
/// @param	{any}	find_this
/// @param	{any}	search_here
function contains(_elem, _container) {
	static _forbidden_elem_types = [
		gm_type_array,
		gm_type_pointer,
		gm_type_struct,
		gm_type_unknown,
	];
	static _forbidden_container_types = [
		gm_type_pointer,
		gm_type_unknown,
		gm_type_bool,
		gm_type_method,
		gm_type_undefined,
	];
	var _elem_type = typeof(_elem);
	var _container_type = typeof(_container);
	
	if (is_type(_elem, _forbidden_elem_types)) {
		trace($"(GML-Extended) - WARNING! On function \"contains()\" {_elem} is type {_elem_type} and cannot be search in {_container}.");
		return false;
	}
	
	if (is_type(_container, _forbidden_container_types)) {
		trace($"(GML-Extended) - WARNING! On function \"contains()\" {_container} is type {_container_type} and cannot be used to be searched.");
		return false;
	}
	
	switch (_container_type) {
		case gm_type_string:
			return string_contains(_container, _elem);
		
		case gm_type_number:
		case gm_type_int32:
		case gm_type_int64:
			return contains(string(_elem), string(_container));
			
		case gm_type_array:
			return array_contains(_container, _elem);
			
		case gm_type_struct:
			return struct_key_exists(_container, string(_elem));
	}
	
	trace($"(GML-Extended) - ERROR! On function \"contains()\". This is unexpected and shouldn't happen.");
	return false;
}

/// @func	trace(*args)
/// @param	{any}	*args
/// @desc	A short way to use show_debug_message
function trace() {
	var _str = "";
	for (var i = 0; i < argument_count; i++) {
		_str += string(argument[i]);
	}
	show_debug_message(_str);
}

/// @func	alert(*args)
/// @param	{any}	*args
/// @desc	A short way to use show_message
function alert() {
	var _args = array_create(argument_count, undefined);
	for (var i = 0; i < argument_count; i++) {
		_args[i] = argument[i];
	}
	script_execute_ext(show_message, _args);
}

/// @func	alert_async(*args)
/// @param	{any}	*args
/// @desc	A short way to use show_message_async
function alert_async() {
	var _args = array_create(argument_count, undefined);
	for (var i = 0; i < argument_count; i++) {
		_args[i] = argument[i];
	}
	script_execute_ext(show_message_async, _args);
}

/// @func	view_get_x(view)
/// @param	{real}	view
function view_get_x(_view = view_current) {
	return camera_get_view_x(view_camera[_view]);
}

/// @func	view_get_y(view)
/// @param	{real}	view
function view_get_y(_view = view_current) {
	return camera_get_view_y(view_camera[_view]);
}

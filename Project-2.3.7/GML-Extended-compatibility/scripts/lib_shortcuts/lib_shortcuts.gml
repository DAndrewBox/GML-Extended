/// @func	del(object_index|id, exec_event);
/// @param	{Id.Instance|Asset.GMObject}	object_index|id
/// @param	{bool}							exec_event
/// @desc	A short way to destroy an element
function del(_obj = id, _exec_ev = true) {
	instance_destroy(_obj, _exec_ev);
}

/// @func	get_size(element, gm_type)
/// @param	{any}		element
/// @param	{string}	gm_type
/// @desc	Returns the size or length of the element.
function get_size(_e, _type = undefined) {
	_type = (_type == undefined ? typeof(_e) : _type);
	
	switch(_type) {
		case gm_type_array:			return array_length(_e);
		case gm_type_struct:		return get_size(struct_keys(_e));
		case gm_type_string:		return string_length(_e);
		case gm_type_number:
		case gm_type_int32:
		case gm_type_int64:			return get_size(string(_e));
		case gm_type_bool:			return 1;
		
		case gm_type_ds_list:		return ds_list_size(_e);
		case gm_type_ds_map:		return ds_map_size(_e);
		case gm_type_ds_grid:		return [ds_grid_width(_e), ds_grid_height(_e)];
		case gm_type_ds_queue:		return ds_queue_size(_e);
		case gm_type_ds_stack:		return ds_stack_size(_e);
		case gm_type_ds_priority:	return ds_priority_size(_e);

		default:					return -1;
	}
}

/// @func	contains(find_this, search_here, container_gm_type)
/// @param	{any}		find_this
/// @param	{any}		search_here
/// @param	{string}	container_gm_type
function contains(_elem, _container, _container_type_predef = undefined) {
	static _forbidden_elem_types = [
		gm_type_array,
		gm_type_pointer,
		gm_type_struct,
		gm_type_unknown,
		gm_type_ds_list,
		gm_type_ds_grid,
		gm_type_ds_map,
		gm_type_ds_queue,
		gm_type_ds_stack,
		gm_type_ds_priority,
	];
	static _forbidden_container_types = [
		gm_type_pointer,
		gm_type_unknown,
		gm_type_bool,
		gm_type_method,
		gm_type_undefined,
		gm_type_ds_queue,
		gm_type_ds_stack,
	];
	var _elem_type = typeof(_elem);
	var _container_type = _container_type_predef == undefined ? typeof(_container) : _container_type_predef;
	
	if (is_type(_elem, _forbidden_elem_types)) {
		trace("(GML-Extended) - WARNING! On function \"contains()\" ", _elem, " is type ", _elem_type, " and cannot be search in ", _container, ".");
		return false;
	}
	
	if (is_type(_container, _forbidden_container_types)) {
		trace("(GML-Extended) - WARNING! On function \"contains()\" ", _container, " is type ", _container_type, " and cannot be used to be searched.");
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
			return __gml_ext_comp_array_contains(_container, _elem);
			
		case gm_type_struct:
			return struct_key_exists(_container, string(_elem));
		
		case gm_type_ds_list:
			return ds_list_find_index(_container, _elem) > -1;
		
		case gm_type_ds_grid:
			var _grid_w = ds_grid_width(_container);
			var _grid_h = ds_grid_height(_container);
			for (var i = 0; i < _grid_h; i++) {
				for (var j = 0; j < _grid_w; j++) {
					if (_elem == _container[# j, i]) {
						return true;
					}
				}
			}
			
			return false;
			
		case gm_type_ds_map:
			var _key = ds_map_find_first(_container);
			var _map_size = ds_map_size(_container);
			
			for (var i = 0; i < _map_size; i++) {
				if (_container[? _key] == _elem) return true;
				_key = ds_map_find_next(_container, _key);
			}
			return false;
		
		case gm_type_ds_priority:
			return ds_priority_find_priority(_container, _elem) > -1;
	}
	
	trace("(GML-Extended) - ERROR! On function \"contains()\". This is unexpected and shouldn't happen.");
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

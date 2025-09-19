/// @func	del(object_index, [exec_event])
/// @param	{Id.Instance|Asset.GMObject}	object_index	The index of the object or the id of the instance.
/// @param	{Bool}							exec_event		Optional. Whether to execute the destroy event or not after delete.
/// @desc	Deletes an instance and executes the destroy event of the object. Serves as a shortcut for `instance_destroy`.
///	@return	{Undefined}
function del(_obj = id, _exec_ev = true) {
	instance_destroy(_obj, _exec_ev);
}

/// @func	get_size(element, [type])
/// @param	{Any}		element		The element to get the size of.
/// @param	{String}	type		Optional. The type of the element. Prefer using `gm_type_*`.
/// @desc	Returns the size or length of the element. Read documentation for more details.
function get_size(_e, _type = noone) {
	_type = _type == noone ? typeof(_e) : _type;
	
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

/// @func	contains(find_this, search_here, [container_type])
/// @param	{Any}		find_this		The element to check if it's inside.
/// @param	{Any}		search_here		The container to check if the element is in.
/// @param	{String}	container_type	Optional. The type of the container. Prefer using `gm_type_*`.
/// @desc	Checks if an element is inside a container. Serves as a shortcut for `ds_list_find_index`, `ds_map_find_value`, `ds_grid_value`, `array_find_value`, `string_pos`, and more.
///	@return	{Bool}
function contains(_elem, _container, _container_type = "") {
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
	_container_type = _container_type == "" ? typeof(_container) : _container_type;
	
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
	}
	
	trace("(GML-Extended) - ERROR! On function \"contains()\". This is unexpected and shouldn't happen.");
	return false;
}

/// @func	trace(*args)
/// @param	{Any}	*args	The messages to print.
/// @desc	Prints a message to the console. Serves as a shortcut for `show_debug_message`.
///	@return	{Undefined}
function trace() {
	var _str = "";
	for (var i = 0; i < argument_count; i++) {
		_str += string(argument[i]);
	}
	show_debug_message(_str);
}

/// @func	alert(*args)
/// @param	{Any}	*args	The message to show.
/// @desc	Shows an alert dialog with the message passed as argument. The dialog will stop anything happening in the game until the user clicks the OK button. Server as a shortcut for `show_message`.
///	@return	{Undefined}
function alert() {
	var _args = array_create(argument_count, undefined);
	for (var i = 0; i < argument_count; i++) {
		_args[i] = argument[i];
	}
	script_execute_ext(show_message, _args);
}

/// @func	alert_async(*args)
/// @param	{Any}	*args	The message to show
/// @desc	Shows an alert dialog with the message passed as argument. The dialog **will not** stop anything happening in the game. Server as a shortcut for `show_message_async`.
///	@return	{Undefined}
function alert_async() {
	var _args = array_create(argument_count, undefined);
	for (var i = 0; i < argument_count; i++) {
		_args[i] = argument[i];
	}
	script_execute_ext(show_message_async, _args);
}

/// @func	view_get_x(view)
/// @param	{Real}	view	The view index to get the X position from.
/// @desc	Gets the X position of the view passed as argument. Serves as a shortcut for `camera_get_view_x(view_camera[view_current])`.
///	@return	{Real}
function view_get_x(_view = view_current) {
	return camera_get_view_x(view_camera[_view]);
}

/// @func	view_get_y(view)
/// @param	{Real}	view	The view index to get the Y position from.
/// @desc	Gets the Y position of the view passed as argument. Serves as a shortcut for `camera_get_view_y(view_camera[view_current])`.
///	@return	{Real}
function view_get_y(_view = view_current) {
	return camera_get_view_y(view_camera[_view]);
}

/// @func	sprite_get_index(sprite_name)
/// @param	{String}	sprite_name		The name of the sprite you want to get the index of.
///	@desc	Wrapper for "asset_get_index" to return the valid type to be used as sprite.
/// @return	{Asset.GMSprite}
function sprite_get_index(_name) {
	// Feather ignore once GM1045 - `asset_get_index` always return type "Asset" and tend to cause errors.
	return asset_get_index(_name);
}

/// @func	object_get_index(object_name)
/// @param	{String}	object_name		The name of the object you want to get the index of.
///	@desc	Wrapper for "asset_get_index" to return the valid type to be used as object.
/// @return	{Asset.GMObject}
function object_get_index(_name) {
	// Feather ignore once GM1045 - `asset_get_index` always return type "Asset" and tend to cause errors.
	return asset_get_index(_name);
}

/// @func	sound_get_index(sound_name)
/// @param	{String}	sound_name		The name of the sound you want to get the index of.
///	@desc	Wrapper for "asset_get_index" to return the valid type to be used as sound.
/// @return	{Asset.GMSound}
function sound_get_index(_name) {
	// Feather ignore once GM1045 - `asset_get_index` always return type "Asset" and tend to cause errors.
	return asset_get_index(_name);
}

/// @func	font_get_index(font_name)
/// @param	{String}	font_name		The name of the font you want to get the index of.
///	@desc	Wrapper for "asset_get_index" to return the valid type to be used as font.
/// @return	{Asset.GMFont}
function font_get_index(_name) {
	// Feather ignore once GM1045 - `asset_get_index` always return type "Asset" and tend to cause errors.
	return asset_get_index(_name);
}

/// @func	font_get_index(room_name)
/// @param	{String}	room_name		The name of the room you want to get the index of.
///	@desc	Wrapper for "asset_get_index" to return the valid type to be used as room.
/// @return	{Asset.GMFont}
function room_get_index(_name) {
	// Feather ignore once GM1045 - `asset_get_index` always return type "Asset" and tend to cause errors.
	return asset_get_index(_name);
}

/// @func	rand(n1, n2)
///	@param	{Real}	n1	The minimum value to check. If 'n2' is not provided this is the maximum value.
///	@param	{Real}	n2	Optional. The maximum value to check.
///	@desc	Snippet for 'random' and 'random_range'. If only one argument is provided, 'random' is used, if two parameters are provided, it uses 'random_range'.
///	@return	{Real}	
function rand(_n1, _n2 = undefined) {
	if (is_undefined(_n2)) {
		return random(_n1);
	}
	
	var _min = min(_n1, _n2);
	var _max = max(_n1, _n2);
	return random_range(_min, _max);
}

/// @func	irand(n1, n2)
///	@param	{Real}	n1	The minimum value to check. If 'n2' is not provided this is the maximum value.
///	@param	{Real}	n2	Optional. The maximum value to check.
///	@desc	Snippet for 'irandom' and 'irandom_range'. If only one argument is provided, 'irandom' is used, if two parameters are provided, it uses 'irandom_range'.
///	@return	{Real}	
function irand(_n1, _n2 = undefined) {
	if (is_undefined(_n2)) {
		return irandom(_n1);
	}
	
	var _min = min(_n1, _n2);
	var _max = max(_n1, _n2);
	return irandom_range(_min, _max);
}

/// @func	rand_linear(n1, n2)
///	@param	{Real}	n1	The minimum value to check. If 'n2' is not provided this is the maximum value.
///	@param	{Real}	n2	Optional. The maximum value to check.
///	@desc	Snippet for 'random_linear' and 'random_range_linear'. If only one argument is provided, 'random_linear' is used, if two parameters are provided, it uses 'random_range_linear'.
///	@return	{Real}	
function rand_linear(_n1, _n2 = undefined) {
	if (is_undefined(_n2)) {
		return random_linear(_n1);
	}
	
	var _min = min(_n1, _n2);
	var _max = max(_n1, _n2);
	return random_range_linear(_min, _max);
}
/// @func	instance_create(x, y, object_index, depth|layer_name, _params)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{real}	object_index
/// @param	{any}	depth|layer_name
/// @param	{any}	params
function instance_create(_x, _y, _obj, _depth_or_layer = depth, _params = {}) {
	var _callback =
		typeof(_depth_or_layer) == "string"
		? instance_create_layer
		: instance_create_depth;
		
	var _inst = _callback(_x, _y, _depth_or_layer, _obj, _params);
	delete _params;
	return _inst;
}

/// @func	instance_create_unique(x, y, object_index, depth|layer_name, _params)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{real}	object_index
/// @param	{any}	depth|layer_name
/// @param	{any}	params
/// @desc	Create a new instance only if it doesn't exists
function instance_create_unique(_x, _y, _obj, _depth_or_layer = depth, _params = {}) {
	if !(instance_exists(_obj)) {
		return instance_create(_x, _y, _obj, _depth_or_layer, _params);
	}
	
	return -1;
}

/// @func	instance_any_exists(*args)
/// @param	{ref}	*args
/// @desc	Check if any of the instances on the arguments exists.
function instance_any_exists() {
	var _count = 0;
	
	while (_count < argument_count) {
		if (instance_exists(argument[_count])) return true;
		_count++;
	}

	return false;
}

/// @func	instance_in_room(object_index|id)
/// @param	{ref}	object_index|id
/// @desc	Get a bool telling if the instance is inside the room
function instance_in_room(_inst) {
	return	(_inst.bbox_right >= 0 && _inst.bbox_left <= room_width) &&
			(_inst.bbox_bottom >= 0 && _inst.bbox_top <= room_height);
}

/// @func	instance_get_all(object_index)
/// @param	{ref}	object_index
function instance_get_all(_obj) {
	var _inst_count = instance_number(_obj);
	var _inst_ids = [];
	
	var _inst = -1;
	for (var i = 0; i < size(_inst_count); i++) {
		_inst = instance_find(_obj, i);
		array_push(_inst_ids, _inst);
	}
	
	return _inst_ids;
}

/// @func	instance_number_if(object_index, callback)
/// @param	{ref}	object_index
/// @param	{ref}	callback
function instance_number_if(_obj, _callback) {
	var _inst_ids = instance_get_all(_obj);
	var _count = 0;
	for (var i = 0; i < size(_inst_ids); i++) {
		if (_callback(_inst_ids[@ i])) {
			_count++;
		}
	}
	
	return _count;
}

/// @func	del(object_index|id);
/// @param	{ref}	object_index|id
/// @desc	A short way to destroy an element
function del(_obj = id) {
	instance_destroy(_obj, true);
}

/// @func	event_user_exec(inst, ev_number)
/// @param	{real}	inst
/// @param	{real}	ev_number
/// @desc	Fastest way to perform a event user from an specified object.
function event_user_exec(_inst, _ev_number) {
	with (_inst) {
		event_user(_ev_number);
	}
}

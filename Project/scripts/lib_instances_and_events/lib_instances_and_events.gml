/// @func	instance_create(x, y, object_index, depth|layer_name, _params)
/// @param	{Real}			x
/// @param	{Real}			y
/// @param	{Real}			object_index
/// @param	{real|string}	depth|layer_name
/// @param	{Struct}		params
function instance_create(_x, _y, _obj, _depth_or_layer = depth, _params = {}) {
	var _is_layer = typeof(_depth_or_layer) == gm_type_string;
	var _inst = undefined;
	
	if (_is_layer) {
		_inst = __gml_ext_comp_instance_create_layer(_x, _y, _depth_or_layer, _obj, _params);
	} else {
		_inst = __gml_ext_comp_instance_create_depth(_x, _y, _depth_or_layer, _obj, _params);
	}
	
	delete _params;
	return _inst;
}

/// @func	instance_create_unique(x, y, object_index, depth|layer_name, _params)
/// @param	{Real}	x
/// @param	{Real}	y
/// @param	{Real}	object_index
/// @param	{Any}	depth|layer_name
/// @param	{Any}	params
/// @desc	Create a new instance only if it doesn't exists
function instance_create_unique(_x, _y, _obj, _depth_or_layer = depth, _params = {}) {
	var _inst = instance_find(_obj, 0);
	if (_inst == noone) {
		return instance_create(_x, _y, _obj, _depth_or_layer, _params);
	}
	
	return _inst;
}

/// @func	instance_any_exists(*args)
/// @param	{Id.Instance|Asset.Object}	*args
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
/// @param	{Id.Instance|Asset.Object}	object_index|id
/// @desc	Get a bool telling if the instance is inside the room
function instance_in_room(_inst) {
	return	(_inst.bbox_right >= 0 && _inst.bbox_left <= room_width) &&
			(_inst.bbox_bottom >= 0 && _inst.bbox_top <= room_height);
}

/// @func	instance_get_all(object_index)
/// @param	{Asset.GMObject}	object_index
function instance_get_all(_obj) {
	var _inst_count = instance_number(_obj);
	var _inst_ids = [];
	
	var _inst = -1;
	for (var i = 0; i < get_size(_inst_count); i++) {
		_inst = instance_find(_obj, i);
		array_push(_inst_ids, _inst);
	}
	
	return _inst_ids;
}

/// @func	instance_number_if(object_index, callback)
/// @param	{Asset.GMObject}			object_index
/// @param	{Function|Asset.GMScript}	callback
/// @desc	Return the number of instances that make the callback return true
function instance_number_if(_obj, _callback) {
	var _inst_ids = instance_get_all(_obj);
	var _count = 0;
	for (var i = 0; i < get_size(_inst_ids); i++) {
		if !(_callback(_inst_ids[@ i])) continue;
		_count++;
	}
	
	return _count;
}

/// @func	instance_get_if(object_index, callback)
/// @param	{Asset.GMObject}			object_index
/// @param	{Function|Asset.GMScript}	callback
/// @desc	Return the instance ids that make the callback returns true
function instance_get_if(_obj, _callback) {
	var _inst_ids = instance_get_all(_obj);
	var _inst_got = [];
	for (var i = 0; i < get_size(_inst_ids); i++) {
		if (_callback(_inst_ids[@ i])) continue;
		array_push(_inst_got, _inst_ids[@ i]);
	}
	
	return _inst_got;
}

/// @func	event_user_exec(inst, ev_number)
/// @param	{Id.Instance|Asset.GMObject}	inst
/// @param	{Real}							ev_number
/// @desc	Fastest way to perform a event user from an specified object or instance.
function event_user_exec(_inst, _ev_number) {
	with (_inst) {
		event_user(_ev_number);
	}
}

/// @func	instance_first(inst)
/// @param	{Id.Instance|Asset.GMObject}	inst
/// @desc	Returns the first created instance from an object.
function instance_first(_inst) {
	return instance_find(_inst, 0);
}

/// @func	instance_last(inst)
/// @param	{Id.Instance|Asset.GMObject}	inst
/// @desc	Returns the last created instance from an object.
function instance_last(_inst) {
	return instance_find(_inst, instance_number(_inst) - 1);
}
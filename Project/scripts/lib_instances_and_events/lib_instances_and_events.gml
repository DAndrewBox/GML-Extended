/// @func	instance_create(x, y, object_index, depth_or_layer_name, _params)
/// @param	{Real}							x						The x position of the instance
/// @param	{Real}							y						The y position of the instance
/// @param	{Asset.GMObject|Id.Instance}	object_index			The index of the object to create
/// @param	{Real|String}					depth_or_layer_name		Optional. The depth of the instance or the layer to use. (Default: instance.depth)
/// @param	{Struct}						params					Optional. The parameters to pass to the instance at creation
///	@desc	Creates an instance of an object at the specified position. Similar of how `instance_create` worked before GameMaker Studio 2, but with some extra features. The object index is the index of the object in the object list (not the id). The depth is the depth of the instance (if the layer doesn't exists, it will be created). The params argument is a struct with the parameters to pass to the instance at creation.
function instance_create(_x, _y, _obj, _depth_or_layer = depth, _params = {}) {
	var _is_layer = typeof(_depth_or_layer) == gm_type_string;
	var _inst = noone;
	
	if (_is_layer) {
		_inst = __gml_ext_comp_instance_create_layer(_x, _y, _depth_or_layer, _obj, _params);
	} else {
		_inst = __gml_ext_comp_instance_create_depth(_x, _y, _depth_or_layer, _obj, _params);
	}
	
	delete _params;
	return _inst;
}

/// @func	instance_create_unique(x, y, object_index, depth|layer_name, _params)
/// @param	{Real}							x						The x position of the instance
/// @param	{Real}							y						The y position of the instance
/// @param	{Asset.GMObject|Id.Instance}	object_index			The index of the object to create
/// @param	{Real|String}					depth_or_layer_name		Optional. The depth of the instance or the layer to use. (Default: instance.depth)
/// @param	{Struct}						params					Optional. The parameters to pass to the instance at creation
/// @desc	Functions the same as `instance_create`, but **if an instance of the object already exists, it will return -1 and will not create the instance**. The object index is the index of the object in the object list (not the id). The depth is the depth of the instance (if the layer doesn't exists, it will be created). The params argument is a struct with the parameters to pass to the instance at creation.
function instance_create_unique(_x, _y, _obj, _depth_or_layer = depth, _params = {}) {
	var _inst = instance_find(_obj, 0);
	if (_inst == noone) {
		return instance_create(_x, _y, _obj, _depth_or_layer, _params);
	}
	
	return _inst;
}

/// @func	instance_any_exists(*args)
/// @param	{Id.Instance|Asset.Object}	*args	The instances to check existance
/// @desc	Returns true if any instance of the objects passed as arguments exists.
function instance_any_exists() {
	var _count = 0;
	
	while (_count < argument_count) {
		if (instance_exists(argument[_count])) return true;
		_count++;
	}

	return false;
}

/// @func	instance_in_room(object_index_or_id)
/// @param	{Id.Instance|Asset.Object}	object_index_or_id		The index of the object or the id of the instance
/// @desc	Returns true if an instance of the object exists inside the boundaries of the room.
function instance_in_room(_inst) {
	return	(_inst.bbox_right >= 0 && _inst.bbox_left <= room_width) &&
			(_inst.bbox_bottom >= 0 && _inst.bbox_top <= room_height);
}

/// @func	instance_get_all(object_index)
/// @param	{Asset.GMObject}	object_index	The index of the object
///	@desc	Returns an array of all instances of the object passed as argument.
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
/// @param	{Asset.GMObject}			object_index	The index of the object
/// @param	{Function|Asset.GMScript}	callback		The callback function
/// @desc	Returns a number of instances of the object passed as argument that match the condition passed as callback argument.
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
/// @param	{Asset.GMObject}			object_index	The index of the object
/// @param	{Function|Asset.GMScript}	callback		The callback function
/// @desc	Returns an array of instances of the object passed as argument that match the condition passed as callback argument.
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
/// @param	{Id.Instance|Asset.GMObject}	inst		The id of the instance to execute the event
/// @param	{Real}							ev_number	The id of the event to execute
/// @desc	Executes an event of an object. The event must be a user event. The event_number is the id of the event to execute.
function event_user_exec(_inst, _ev_number) {
	with (_inst) {
		event_user(_ev_number);
	}
}

/// @func	instance_first(inst)
/// @param	{Asset.GMObject}	inst	The index of the object
/// @desc	Returns the first created instance of the object passed as argument.
function instance_first(_inst) {
	return instance_find(_inst, 0);
}

/// @func	instance_last(inst)
/// @param	{Asset.GMObject}	inst	The index of the object
/// @desc	Returns the last created instance of the object passed as argument.
function instance_last(_inst) {
	return instance_find(_inst, instance_number(_inst) - 1);
}

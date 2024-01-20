/// @func	json2yy(json)
/// @param	{str}	json
function json2yy(_json) {
	static _keys_number_to_bool = [
		"inheritCode",
		"inheritCreationOrder",
		"inheritLayers",
		"frozen",
		"isDnd",
		"userdefinedDepth",
		"hasCreationCode",
		"ignore",
		"hierarchyFrozen",
		"inheritLayerDepth",
		"inheritLayerSettings",
		"inheritSubLayers",
		"inheritVisibility",
		"inheritItemSettings",
		"htiled",
		"vtiled",
		"stretch",
		"userdefinedAnimFPS",
		"inheritPhysicsSettings",
		"PhysicsWorld",
		"inheritRoomSettings",
		"persistent",
		"visible",
		"clearDisplayBuffer",
		"clearViewBackground",
		"enableViews",
		"inheritViewSettings",
		"effectEnabled",
	];
	var _str;

    _json =  __gml_ext_internal_json2yy_replace_keys_number_to_bool(_json, _keys_number_to_bool);
    _str  = json_stringify(_json, true);
	_str  = string_replace_all(_str, "\\/", "/");
	_str  = string_replace_all(_str, "\"___true___\"", "true");
	_str  = string_replace_all(_str, "\"___false___\"", "false");
	
	return _str;
}

/// @func	 __gml_ext_internal_json2yy_replace_keys_number_to_bool(struct, keys_to_replace)
/// @param	{struct|array}	struct
/// @param	{array}		keys_to_replace
function __gml_ext_internal_json2yy_replace_keys_number_to_bool(_struct, _keys_number_to_bool) {
    var _keys = is_array(_struct) ? range(get_size(_struct) - 1) : struct_keys(_struct);
    var _num_keys = get_size(_keys);

    for (var _i = 0; _i < _num_keys; _i++) {
        var _key = _keys[_i];
        var _value = is_array(_struct) ? _struct[_key] : _struct[$ _key];

        if (is_array(_value)) {
            _value =  __gml_ext_internal_json2yy_replace_keys_number_to_bool(_value, _keys_number_to_bool); // Recursive call for arrays
		} else if (is_struct(_value)) {
            _value =  __gml_ext_internal_json2yy_replace_keys_number_to_bool(_value, _keys_number_to_bool); // Recursive call for nested structs
		} else if (is_real(_value) || is_bool(_value)) {
            if (array_find_index_by_value(_keys_number_to_bool, _key) != -1) {
				_value = (bool(_value) ? "___true___" : "___false___");
            } else {
				_value = (round(_value) == _value) ? int64(_value) : _value;
			}
        }
		
		if (is_array(_struct)) {
			_struct[_key] = _value;
		} else {
	        _struct[$ _key] = _value;
		}
    }
	
	return _struct;
};
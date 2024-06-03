/*
	COMPATIBILITY FUNCTIONS
	SHOULD BE IMPORTED IF GAMEMAKER VERSIONS IS BEFORE v2024.
*/

#macro	GML_EXT_CURRENT_VERSION	"1.5.0"
#macro	GM_CURRENT_VERSION	__gml_ext_comp_get_gamemaker_version()
#macro	GM_VERSION_IS_2_3	string_copy(GM_runtime_version, 1, 3) == "2.3"
#macro	GM_VERSION_IS_2022	__gml_ext_comp_is_gamemaker_major_version(2022)
#macro	GM_VERSION_IS_2023	__gml_ext_comp_is_gamemaker_major_version(2023)
#macro	GM_VERSION_IS_2024	__gml_ext_comp_is_gamemaker_major_version(2024)

gml_pragma("global", "__gml_ext_comp_init()");

/// @func	__gml_ext_comp_init()
function __gml_ext_comp_init() {
	gm_unit_seconds = 0;
	gm_unit_frames = 1;

	if (GM_VERSION_IS_2022 || GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 8) {
		global.__gml_ext_mouse_x_last = 0;
		global.__gml_ext_mouse_x = 0;
		global.__gml_ext_mouse_y_last = 0;
		global.__gml_ext_mouse_y = 0;
	}

	if (GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor > 4) {
		gm_unit_seconds = time_source_units_seconds;
		gm_unit_frames = time_source_units_frames;
	}
}


/// @func	__gml_ext_comp_get_gamemaker_version()
function __gml_ext_comp_get_gamemaker_version() {
	static _force_compatibility = true;
	if (GM_VERSION_IS_2_3 || _force_compatibility) {
		static _v_23 = {
			major: 2.3,
			minor: 7,
			as_string: "2.3.7"
		};
		return _v_23;
	}
	
	static _major = real(string_digits(string_copy(GM_runtime_version, 1, 4)));
	static _minor = real(string_digits(string_copy(GM_runtime_version, 6, 2)));
	static _version = {
		major:	_major,
		minor:	_minor,
		as_string:	string(_major) + "." + string(_minor),
	};
	
	trace(_version);
	
	return _version;
}

/// @func	__gml_ext_comp_is_gamemaker_major_version(major)
/// @param	{real}	major
function __gml_ext_comp_is_gamemaker_major_version(_major_v) {
	return GM_CURRENT_VERSION.major == _major_v;
}

/// @func	__gml_ext_comp_json_stringify(json, prettify, filter_func)
/// @param	{struct}	json
/// @param	{bool}		prettify
/// @param	{function}	filter_func
function __gml_ext_comp_json_stringify(_json, _pretty = false, _filter_func = undefined) {
	static _use_compatibility = GM_VERSION_IS_2022 || (GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 2);
	
	if (_use_compatibility) {
		return json_stringify(_json);
	}
	
	return script_execute(json_stringify, _json, _pretty, _filter_func)
}

/// @func	__gml_ext_comp_is_callable(value)
/// @param	{any}	value
function __gml_ext_comp_is_callable(_value) {
	static _use_compatibility = GM_VERSION_IS_2022 || (GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 2);
	
	if (_use_compatibility) {
		return (script_exists(_value) || is_method(_value));
	}
	
	return script_execute(is_callable, _value);
}

/// @func	__gml_ext_comp_instance_create_layer(x, y, object_index, layer_name, _params)
/// @param	{real}		x
/// @param	{real}		y
/// @param	{real}		object_index
/// @param	{string}	layer_name
/// @param	{struct}	params
function __gml_ext_comp_instance_create_layer(_x, _y, _obj, _layer, _params = {}) {
	static _use_compatibility = GM_VERSION_IS_2022 && GM_CURRENT_VERSION.minor < 8;
	
	if (_use_compatibility) {
		var _inst = instance_create_layer(_x, _y, _layer, _obj);
		var _params_keys = struct_keys(_params);
		var _params_keys_len = get_size(_params);
		
		for (var i = 0; i < _params_keys_len; i++) {
			variable_instance_set(_inst, _params_keys[i], _params[$ _params_keys[i]]);
		}
		
		return _inst;
	}
	
	return script_execute(instance_create_layer, _x, _y, _obj, _layer, _params);
}

/// @func	__gml_ext_comp_instance_create_depth(x, y, object_index, depth, _params)
/// @param	{real}		x
/// @param	{real}		y
/// @param	{real}		object_index
/// @param	{real}		depth
/// @param	{struct}	params
function __gml_ext_comp_instance_create_depth(_x, _y, _obj, _depth, _params = {}) {
	static _use_compatibility = GM_VERSION_IS_2022 && GM_CURRENT_VERSION.minor < 8;
	
	if (_use_compatibility) {
		var _inst = instance_create_depth(_x, _y, _depth, _obj);
		var _params_keys = struct_keys(_params);
		var _params_keys_len = get_size(_params);
		
		for (var i = 0; i < _params_keys_len; i++) {
			variable_instance_set(_inst, _params_keys[i], _params[$ _params_keys[i]]);
		}
		
		return _inst;
	}
	
	return script_execute(instance_create_layer, _x, _y, _obj, _depth, _params);
}

/// @func	__gml_ext_comp_string_ext(str, args)
/// @param	{string}	str
/// @param	{array}		args
function __gml_ext_comp_string_ext(_str, _args = []) {
	static _use_compatibility = GM_VERSION_IS_2022 && GM_CURRENT_VERSION.minor < 11;
	
	if (_use_compatibility) {
		var _args_len = get_size(_args);
		for (var i = 0; i < _args_len; i++) {
			_str = string_replace_all(_str, "{" + string(i) + "}", string(_args[i]));
		}
		return _str;
	}
	
	return script_execute(string_ext, _str, _args);
}

/// @func	__gml_ext_comp_string_split(str, delimiter, remove_empty, max_splits)
/// @param	{string}	str
/// @param	{string}	delimiter
/// @param	{bool}		remove_empty
/// @param	{real}		max_splits
function __gml_ext_comp_string_split(_str, _delim, _remove_empty = false, _max_splits = infinity) {
	static _use_compatibility = GM_VERSION_IS_2022 && GM_CURRENT_VERSION.minor < 11;
	_str = string(_str);

	if (_use_compatibility) {
		var _str_array = [];
		var _count = 1;
		
		var _new_str = "";
		while (_count <= string_length(_str)) {
			var _char = string_char_at(_str, _count);
			
			if (_char == _delim && get_size(_str_array) < _max_splits) {
				if (_new_str != "" || !_remove_empty) {
					array_push(_str_array, _new_str);
				}
				_new_str = "";
				_count++;
				continue;
			}
			
			_new_str += _char;
			_count++;
		}
		
		if (string_length(_new_str) > 0) {
			array_push(_str_array, _new_str);
		}
		
		return _str_array;
	}
	
	return script_execute(string_split, _str, _delim, _remove_empty, _max_splits);
}

/// @func	__gml_ext_comp_variable_clone(value, max_depth)
/// @param	{any}	value
/// @param	{real}	max_depth
function __gml_ext_comp_variable_clone(_value, _depth = 128) {
	static _use_compatibility = GM_VERSION_IS_2022 || GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 4;
	
	if (_use_compatibility) {
		var _type = typeof(_value);
		if (_type == gm_type_struct) {
			var _json_str = json_stringify(_value);
			return json_parse(_json_str);
		} else if (_type == gm_type_array) {
			var _new_array = [];
			array_copy(_new_array, 0, _value, 0, get_size(_value));
			return _new_array;
		} else {
			return _value;
		}
	}
	
	return script_execute(variable_clone, _value, _depth);
}

/// @func	__gml_ext_comp_array_contains(array, value, offset, lenght)
/// @param	{array}	array
/// @param	{any}	value
/// @param	{real}	offset
/// @param	{real}	lenght
function __gml_ext_comp_array_contains(_array, _value, _offset = 0, _len = infinity) {
	static _use_compatibility = GM_VERSION_IS_2022;
	
	if (_use_compatibility) {
		var _elem_in_array = false;
		var _array_len	= get_size(_array);
		_len = is_infinity(_len) ? _array_len : _len;
		var _go_forward = (_len >= 0);
		var _start_pos	= _go_forward ? _offset : _array_len - _offset ;
		var _end_pos	= _go_forward ? _len : _array_len - _len;
		var _val_to_add = _go_forward ? 1 : -1;
		
		for (var i = _start_pos; (_go_forward ? i < _end_pos : i >= _end_pos); _val_to_add++) {
			if (_value == _array[i]) {
				_elem_in_array = true;
				break;
			}
		}
		
		return _elem_in_array;
	}
	
	return script_execute(array_contains, _array, _value, _offset, _len);
}

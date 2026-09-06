/*
	COMPATIBILITY FUNCTIONS
	THESE FUNCTIONS MAKE EVERYTHING WORK IN OLDER GAMEMAKER VERSIONS UNDER THE HOOD.
*/

/*
	Set `GML_EXT_FORCE_COMPATIBILITY_MODE` to `true` to run every fallback below even on a modern runtime.
*/
#macro	GML_EXT_FORCE_COMPATIBILITY_MODE	false

#macro	GML_EXT_CURRENT_VERSION				"1.6.0"

#macro	GM_CURRENT_VERSION	__gml_ext_comp_get_version()
#macro	GM_VERSION_AT_LEAST	__gml_ext_comp_version_at_least
#macro	GM_HAS				__gml_ext_comp_has

#macro	GM_VERSION_IS_2_3	(GM_CURRENT_VERSION.major == 2)
#macro	GM_VERSION_IS_2022	(GM_CURRENT_VERSION.major == 2022)
#macro	GM_VERSION_IS_2023	(GM_CURRENT_VERSION.major == 2023)
#macro	GM_VERSION_IS_2024	(GM_CURRENT_VERSION.major == 2024)
#macro	GM_VERSION_IS_2025	(GM_CURRENT_VERSION.major == 2025)
#macro	GM_VERSION_IS_2026	(GM_CURRENT_VERSION.major == 2026)

gml_pragma("global", "__gml_ext_comp_init()");

/// @func	__gml_ext_comp_init()
/// @ignore
function __gml_ext_comp_init() {
	global.__gml_ext = {
		draw_profiles: {},
		units_seconds: 0,
		units_frames: 1
	};

	// Only needed while the runtime cannot report the mouse delta on its own.
	if (!GM_HAS("window_mouse_delta")) {
		global.__gml_ext.custom_mouse_x_last = 0;
		global.__gml_ext.custom_mouse_x = 0;
		global.__gml_ext.custom_mouse_y_last = 0;
		global.__gml_ext.custom_mouse_y = 0;
	}

	show_debug_message(
		__gml_ext_comp_string_ext(
			"[GML-Extended] - Running GML-Extended v{0} with GameMaker runtime v{1}.{2}",
			[
				GML_EXT_CURRENT_VERSION,
				GM_CURRENT_VERSION.as_string,
				GML_EXT_FORCE_COMPATIBILITY_MODE ? " Compatibility mode is forced ON." : ""
			]
		)
	);
}

/// @func	__gml_ext_comp_build_features()
/// @desc	Returns which of the GameMaker functions GML-Extended relies on the current runtime has. Every version number of the library lives here and nowhere else.
/// @ignore
function __gml_ext_comp_build_features() {
	// Forcing compatibility mode marks every function as missing, so all the fallbacks run.
	if (GML_EXT_FORCE_COMPATIBILITY_MODE) {
		return {
			instance_create_params:	false,
			string_ext:				false,
			string_split:			false,
			array_contains:			false,
			is_callable:			false,
			json_stringify_ext:		false,
			variable_clone:			false,
			gpu_set_depth:			false,
			window_mouse_delta:		false,
		};
	}

	return {
		instance_create_params:	GM_VERSION_AT_LEAST(2022, 8),
		string_ext:				GM_VERSION_AT_LEAST(2022, 11),
		string_split:			GM_VERSION_AT_LEAST(2022, 11),
		array_contains:			GM_VERSION_AT_LEAST(2023, 1),
		is_callable:			GM_VERSION_AT_LEAST(2023, 2),
		json_stringify_ext:		GM_VERSION_AT_LEAST(2023, 2),
		variable_clone:			GM_VERSION_AT_LEAST(2023, 4),
		gpu_set_depth:			GM_VERSION_AT_LEAST(2023, 8),
		window_mouse_delta:		GM_VERSION_AT_LEAST(2023, 8),
	};
}

/// @func	__gml_ext_comp_has(feature)
/// @param	{String}	feature		The name of the feature, as listed in `__gml_ext_comp_build_features`.
/// @desc	Returns whether the current runtime ships the given GameMaker function. Reading it through a `static` keeps the lookup to once per function.
/// @ignore
function __gml_ext_comp_has(_feature) {
	static _features = __gml_ext_comp_build_features();

	if (!variable_struct_exists(_features, _feature)) {
		show_debug_message("[GML-Extended] - ERROR! On function \"__gml_ext_comp_has()\". Unknown feature \"" + string(_feature) + "\".");
		return false;
	}

	return _features[$ _feature];
}

/// @func	__gml_ext_comp_get_version()
/// @desc	Returns the GameMaker runtime version as a struct holding its `major` and `minor` numbers. Parsed once and cached.
/// @ignore
function __gml_ext_comp_get_version() {
	static _version = __gml_ext_comp_parse_version();

	return _version;
}

/// @func	__gml_ext_comp_parse_version()
/// @desc	Reads `GM_runtime_version` into a struct. GameMaker 2.3.x reports a major of 2, every later release reports its year.
/// @ignore
function __gml_ext_comp_parse_version() {
	// The trailing dot makes the last number end the same way as the others.
	var _str = string(GM_runtime_version) + ".";
	var _str_len = string_length(_str);
	var _numbers = [0, 0];
	var _index = 0;
	var _digits = "";

	for (var i = 1; i <= _str_len && _index < 2; i++) {
		var _char = string_char_at(_str, i);

		if (_char != ".") {
			_digits += _char;
			continue;
		}

		// `string_digits` drops any letter a beta or preview build may carry.
		var _clean = string_digits(_digits);
		_numbers[_index] = (_clean == "") ? 0 : real(_clean);
		_digits = "";
		_index++;
	}

	return {
		major:		_numbers[0],
		minor:		_numbers[1],
		as_string:	string(_numbers[0]) + "." + string(_numbers[1]),
	};
}

/// @func	__gml_ext_comp_version_at_least(major, [minor])
/// @param	{Real}	major	The major version to compare against, e.g. 2023.
/// @param	{Real}	minor	Optional. The minor version to compare against. (Default: 0)
/// @desc	Returns whether the runtime is the given version or a newer one.
/// @ignore
function __gml_ext_comp_version_at_least(_major, _minor = 0) {
	var _version = GM_CURRENT_VERSION;

	if (_version.major != _major) return (_version.major > _major);

	return (_version.minor >= _minor);
}

/// @func	__gml_ext_comp_json_stringify(json, prettify, filter_func)
/// @param	{Struct}					json
/// @param	{Bool}						prettify
/// @param	{Function|Asset.GMScript}	filter_func
/// @desc	Compatibility function for `json_stringify()`.
/// @ignore
function __gml_ext_comp_json_stringify(_json, _pretty = false, _filter_func = undefined) {
	static _has = GM_HAS("json_stringify_ext");
	
	if (!_has) return json_stringify(_json);
	
	return script_execute(json_stringify, _json, _pretty, _filter_func);
}

/// @func	__gml_ext_comp_is_callable(value)
/// @param	{Any}	value
/// @desc	Compatibility function for `is_callable()`.
/// @ignore
function __gml_ext_comp_is_callable(_value) {
	static _has = GM_HAS("is_callable");
	
	if (!_has) return is_method(_value) || (is_real(_value) && script_exists(_value));
	
	return script_execute(is_callable, _value);
}

/// @func	__gml_ext_comp_instance_create_layer(x, y, layer_name, object_index, _params)
/// @param	{Real}				x
/// @param	{Real}				y
/// @param	{String|Id.Layer}	layer_name
/// @param	{Asset.GMObject}	object_index
/// @param	{Struct}			params
/// @desc	Compatibility function for `instance_create_layer()`.
/// @ignore
function __gml_ext_comp_instance_create_layer(_x, _y, _layer, _obj, _params = {}) {
	static _has = GM_HAS("instance_create_params");
	
	if (!_has) {
		var _inst = instance_create_layer(_x, _y, _layer, _obj);
		var _params_keys = struct_keys(_params);
		var _params_keys_len = get_size(_params);
		
		for (var i = 0; i < _params_keys_len; i++) {
			variable_instance_set(_inst, _params_keys[i], _params[$ _params_keys[i]]);
		}
		
		return _inst;
	}
	
	return script_execute(instance_create_layer, _x, _y, _layer, _obj, _params);
}

/// @func	__gml_ext_comp_instance_create_depth(x, y, depth, object_index, _params)
/// @param	{Real}				x
/// @param	{Real}				y
/// @param	{Real}				depth
/// @param	{Asset.GMObject}	object_index
/// @param	{Struct}			params
/// @desc	Compatibility function for `instance_create_depth()`.
/// @ignore
function __gml_ext_comp_instance_create_depth(_x, _y, _depth,  _obj, _params = {}) {
	static _has = GM_HAS("instance_create_params");
	
	if (!_has) {
		var _inst = instance_create_depth(_x, _y, _depth, _obj);
		var _params_keys = struct_keys(_params);
		var _params_keys_len = get_size(_params);
		
		for (var i = 0; i < _params_keys_len; i++) {
			variable_instance_set(_inst, _params_keys[i], _params[$ _params_keys[i]]);
		}
		
		return _inst;
	}
	
	return script_execute(instance_create_depth, _x, _y, _depth, _obj, _params);
}

/// @func	__gml_ext_comp_string_ext(str, args)
/// @param	{String}	str
/// @param	{Array}		args
/// @desc	Compatibility function for `string_ext()`.
/// @ignore
function __gml_ext_comp_string_ext(_str, _args = []) {
	static _has = GM_HAS("string_ext");
	
	if (!_has) {
		var _args_len = get_size(_args);
		for (var i = 0; i < _args_len; i++) {
			_str = string_replace_all(_str, "{" + string(i) + "}", string(_args[i]));
		}
		return _str;
	}
	
	return script_execute(string_ext, _str, _args);
}

/// @func	__gml_ext_comp_string_split(str, delimiter, remove_empty, max_splits)
/// @param	{String}	str
/// @param	{String}	delimiter
/// @param	{Bool}		remove_empty
/// @param	{Real}		max_splits
/// @desc	Compatibility function for `string_split()`.
/// @ignore
function __gml_ext_comp_string_split(_str, _delim, _remove_empty = false, _max_splits = infinity) {
	static _has = GM_HAS("string_split");
	_str = string(_str);

	if (!_has) {
		var _str_array = [];
		var _str_len = string_length(_str);
		// A delimiter can be longer than a single character, and an empty one never matches.
		var _delim_len = max(1, string_length(_delim));
		var _new_str = "";
		var _count = 1;
		
		while (_count <= _str_len) {
			if (array_length(_str_array) < _max_splits && string_copy(_str, _count, _delim_len) == _delim) {
				if (_new_str != "" || !_remove_empty) {
					array_push(_str_array, _new_str);
				}
				_new_str = "";
				_count += _delim_len;
				continue;
			}
			
			_new_str += string_char_at(_str, _count);
			_count++;
		}
		
		// The built-in keeps the last chunk even when it is empty.
		if (_new_str != "" || !_remove_empty) {
			array_push(_str_array, _new_str);
		}
		
		return _str_array;
	}
	
	return script_execute(string_split, _str, _delim, _remove_empty, _max_splits);
}

/// @func	__gml_ext_comp_variable_clone(value, max_depth)
/// @param	{Any}	value
/// @param	{Real}	max_depth
/// @desc	Compatibility function for `variable_clone()`.
/// @ignore
function __gml_ext_comp_variable_clone(_value, _depth = 128) {
	static _has = GM_HAS("variable_clone");
	
	if (!_has) {
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
/// @param	{Array}	array
/// @param	{Any}	value
/// @param	{Real}	offset
/// @param	{Real}	lenght
/// @desc	Compatibility function for `array_contains()`.
/// @ignore
function __gml_ext_comp_array_contains(_array, _value, _offset = 0, _len = infinity) {
	static _has = GM_HAS("array_contains");
	
	if (!_has) {
		var _elem_in_array = false;
		var _array_len	= get_size(_array);
		_len = is_infinity(_len) ? _array_len : _len;
		var _go_forward = (_len >= 0);
		var _start_pos	= _go_forward ? _offset : _array_len - _offset ;
		var _end_pos	= _go_forward ? min(_offset + _len, _array_len) : _array_len + _len;
		var _val_to_add = _go_forward ? 1 : -1;
		
		for (var i = _start_pos; (_go_forward ? i < _end_pos : i >= _end_pos); i += _val_to_add) {
			if (_value == _array[i]) {
				_elem_in_array = true;
				break;
			}
		}
		
		return _elem_in_array;
	}
	
	return script_execute(array_contains, _array, _value, _offset, _len);
}

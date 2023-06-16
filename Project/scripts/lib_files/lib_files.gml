/// @func	file_text_read_whole(file)
/// @param	{real}	file
/// @desc	Read all lines of a file and returns it as a string
function file_text_read_whole(_file) {
	if (_file < 0) return "";
	
	var _file_str = ""
	while (!file_text_eof(_file)) {
	    _file_str += file_text_readln(_file);
	}
	
	return _file_str;
}

/// @func	file_json_read(file)
/// @param	{real}	file
/// @desc	Read a file a transforms it into a json struct
function file_json_read(_file) {
	var _str = file_text_read_whole(_file);
	return json_parse(_str);
}

/// @func	file_text_get_lines_array(file)
/// @param	{real}	file
/// @desc	Returns all lines of a file and returns it as an array
function file_text_get_lines_array(_file) {
	if (_file < 0) return [];
	
	var _file_arr = [];
	var _str = "";
	while (!file_text_eof(_file)) {
		_str = file_text_readln(_file);
	    array_push(_file_arr, _str);
	}
	
	return _file_arr;
}

/// @func	json2file(filename, struct, iteration)
/// @param	{str}	filename
/// @param	{any}	struct
/// @param	{real}	iteration
/// @desc	Creates a file from a json struct.
function json2file(_filename = "", _json = {}, _iteration = 0) {
	if (!is_struct(_json)) return "";
	
	var _str	= "{";
	var _keys	= struct_keys(_json);
	array_sort(_keys, true);
	for (var i = 0; i < get_size(_keys); i++) {
		var _value = _json[$ _keys[i]];
		if (is_struct(_value)) {
			_value = json2file("", _value, _iteration + 1);
		} else if (is_string(_value)) {
			_value = string("\"{0}\"", _value);
			_value = string_replace_all(_value, "\n", "\\n");
		}
		_str += "\n\t";
		for (var j = 0; j < _iteration; j++) {
			_str += "\t";
		}
		_str += string(
			"\"{0}\": {1}",
			_keys[i],
			_value
		);
		_str += ( i != get_size(_keys) - 1 ? "," : "" );
	}
	_str += "\n";
	for (var j = 0; j < _iteration; j++) {
		_str += "\t";
	}
	_str += "}";
	
	if (_filename != "") {
		var _file = file_text_open_write(_filename);
		file_text_write_string(_file, _str);
		file_text_close(_file);
	}
	
	return _str;
}

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
/// @param	{struct}	struct
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
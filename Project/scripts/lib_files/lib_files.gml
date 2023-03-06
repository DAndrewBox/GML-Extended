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
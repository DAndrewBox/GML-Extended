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

/// @func	file_to_json(file)
/// @param	{real}	file
/// @desc	Read a file a transforms it into a json struct
function file_to_json(_file) {
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
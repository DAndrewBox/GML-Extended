/// @func Logger(filename, path)
/// @param	{string}	filename
/// @param	{string}	path
/// @desc	Create a logger struct.
function Logger(_fname, _path = working_directory) constructor {
	function __init_logger__(_fname, _path) {
		var _file = _path + _fname;
		_file = ( !file_exists(_file) ? file_text_open_write(_file) : file_text_open_append(_file) );
		
		self.file = _file;
		self.filename = _fname;
		self.filepath = _path + _fname;
		
		self.linked = {
			id: -1,
			onLog:	show_debug_message,
			onWarn: show_debug_message,
			onError: show_debug_message,
		}
	}
	
	/// @func open()
	/// @desc Open the logger file
	function open() {
		if (self.file == -1) return;
		self.file = (
			!file_exists(self.filepath)
			? file_text_open_write(self.filepath)
			: file_text_open_append(self.filepath)
			);
	}
	
	/// @func close()
	/// @desc Closes the logger file
	function close() {
		if (self.file == -1) return;
		file_text_close(self.file);
	}
	
	/// @func log([*args])
	/// @param	{string}	[*args]
	/// @desc	Writes your text into the logger file.
	function log() {
		if (self.file == -1) return;
		var _msg = datetime_get_timestamp() + " ";
		
		for (var i = 0; i < argument_count; i++) {
			// If an array is recieved, converts it into string, else, use the string of the argument.
			var _substr = "";
			if (is_array(argument[i])) {
				for (var j = 0; j < array_length(argument[i]); j++ ) {
					_substr += string(argument[i][j]);
				}
			} else {
				_substr = string(argument[i]);
			}
		
			_msg += _substr;
		}
	
		file_text_write_string(self.file, _msg + "\n");
		
		if (__gml_ext_comp_is_callable(self.linked.id) && self.linked.onLog) {
			script_execute(self.linked.onLog);
		}
	}
	
	/// @func warn([*args])
	/// @param	{string}	[*args]
	/// @desc	Writes a warning into into the logger file.
	function warn() {
		var _text = [];
		for (var i = 0; i < argument_count; i++) {
			array_push(_text, string(argument[i]));
		}
	
		self.log(self.file, "[⚠] ", _text);
		if (__gml_ext_comp_is_callable(self.linked.id) && self.linked.onWarn) {
			script_execute(self.linked.onWarn);
		}
	}
	
	/// @func error([*args])
	/// @param	{string}	[*args]
	/// @desc	Writes a error into into the logger file.
	function error() {
		var _text = [];
		for (var i = 0; i < argument_count; i++) {
			array_push(_text, string(argument[i]));
		}
	
		self.log(self.file, "[❌] ", _text);
		if (__gml_ext_comp_is_callable(self.linked.id) && self.linked.onError) {
			script_execute(self.linked.onError);
		}
	}
	
	/// @func link_instance(inst, callbacks)
	/// @param	{id}		inst
	/// @param	{any}	callbacks
	/// @desc	Link an instance to execute callbacks when logger is used.
	function link_instance(_inst, _callbacks) {
		var _default_callbacks = {
			onLog: -1,
			onWarn: -1,
			onError: -1,
		};
		var _callbacks_merged = struct_merge(_default_callbacks, _callbacks);
		
		self.linked.id		= _inst;
		self.linked.onLog	= _callbacks_merged.onLog;
		self.linked.onWarn	= _callbacks_merged.onWarn;
		self.linked.onError	= _callbacks_merged.onError;
		
		delete _default_callbacks;
		delete _callbacks_merged;
	}
	
	__init_logger__(_fname, _path);
}
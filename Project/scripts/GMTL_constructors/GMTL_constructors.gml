/// @func	TestCase(value)
/// @param	{any}	value
function TestCase(_val) constructor {
	__internal_value = _val;	
	
	/// @func toBe(expected_result)
	/// @param	{any}	expected_result
	function toBe(_expectedResult) {
		var _isValid;
		if (is_array(__internal_value) && is_array(_expectedResult)) {
			_isValid = array_equals(__internal_value, _expectedResult);
		} else {
			_isValid = __internal_value == _expectedResult;
		}
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBe({_expectedResult}):");
			array_push(gmtl_test_log, $"- Expected Result: {_expectedResult}");
			array_push(gmtl_test_log, $"- Recieved Result: {__internal_value}");
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeEqual(expected_result)
	/// @param	{any}	expected_result
	function toBeEqual(_expectedResult) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		
		switch (_typeOf) {
			case "array":
				_isValid = array_equals(__internal_value, _expectedResult);
				break;
			case "struct":
				_isValid = variable_get_hash(__internal_value) == variable_get_hash(_expectedResult);
				break;
			default:
				toBe(_expectedResult);
				return;
		}
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeEqual({_expectedResult}):");
			array_push(gmtl_test_log, $"- Expected Result: {_expectedResult}");
			array_push(gmtl_test_log, $"- Recieved Result: {__internal_value}");
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toHaveReturned()
	function toHaveReturned() {
		var _isValid = !is_undefined(__internal_value);
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toHaveReturned():");
			array_push(gmtl_test_log, $"- Expected Result: {true}");
			array_push(gmtl_test_log, $"- Recieved Result: {__internal_value}");
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toHaveReturnedWith(expected_result)
	/// @param	{any}	expected_result
	function toHaveReturnedWith(_expectedResult) {
		self.toBe(_expectedResult);
	}
	
	/// @func toHaveLength(number)
	/// @param	{real}	number
	function toHaveLength(_n) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		var _len	 = 0;
		
		switch (_typeOf) {
			case "array":
				_len = array_length(__internal_value);
				break;
			case "struct":
				_len = array_length(variable_struct_get_names(__internal_value));
				break;
			case "string":
				_len = string_length(__internal_value);
				break;
			default:
				_typeInvalid = true;
		}		
		
		_isValid = _n == _len;
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $">expect({__internal_value}).toHaveLength({_n}):");
			array_push(gmtl_test_log, $"- Expected Result: {_n}");
			array_push(gmtl_test_log, $"- Recieved Result: {_typeInvalid ? $"<Invalid Type: {_typeOf}>" : _len}");
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toHaveProperty(key, value)
	/// @param	{str}	key
	/// @param	{any}	value
	function toHaveProperty(_key, _value = undefined) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		
		switch (_typeOf) {
			case "struct":
				if (!is_undefined(_value)) {
					_isValid = __internal_value[$ _key] == _value;
				} else {
					_isValid = !is_undefined(__internal_value[$ _key]);
				}
				break;
			default:
				_typeInvalid = true;
		}		
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toHaveProperty({_key}, {_value}):");
			array_push(gmtl_test_log, $"- Expected Result: {!is_undefined(_value) ? $"{_key} = {_value}" : $"_key != undefined"}");
			if (_typeInvalid) {
				array_push(gmtl_test_log, $"- Recieved Result: <Invalid Type: {_typeOf}>");
			} else {
				array_push(gmtl_test_log, $"- Recieved Result: {_key} = {__internal_value[$ _key]}");
			}
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeGreaterThan(number)
	/// @param	{real}	number
	function toBeGreaterThan(_n) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		
		switch (_typeOf) {
			case "number":
				_isValid = __internal_value > _n;
				break;
			default:
				_typeInvalid = true;
		}		
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeGreaterThan({_n}):");
			array_push(gmtl_test_log, $"- Expected Result: {__internal_value} > {_n}");
			if (_typeInvalid) {
				array_push(gmtl_test_log, $"- Recieved Result: <Invalid Type: {_typeOf}>");
			} else {
				array_push(gmtl_test_log, $"- Recieved Result: {__internal_value} <= {_n}");
			}
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeGreaterThanOrEqual(number)
	/// @param	{real}	number
	function toBeGreaterThanOrEqual(_n) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		
		switch (_typeOf) {
			case "number":
				_isValid = __internal_value >= _n;
				break;
			default:
				_typeInvalid = true;
		}		
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeGreaterThanOrEqual({_n}):");
			array_push(gmtl_test_log, $"- Expected Result: {__internal_value} >= {_n}");
			if (_typeInvalid) {
				array_push(gmtl_test_log, $"- Recieved Result: <Invalid Type: {_typeOf}>");
			} else {
				array_push(gmtl_test_log, $"- Recieved Result: {__internal_value} < {_n}");
			}
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeLessThan(number)
	/// @param	{real}	number
	function toBeLessThan(_n) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		
		switch (_typeOf) {
			case "number":
				_isValid = __internal_value < _n;
				break;
			default:
				_typeInvalid = true;
		}		
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeLessThan({_n}):");
			array_push(gmtl_test_log, $"- Expected Result: {__internal_value} < {_n}");
			if (_typeInvalid) {
				array_push(gmtl_test_log, $"- Recieved Result: <Invalid Type: {_typeOf}>");
			} else {
				array_push(gmtl_test_log, $"- Recieved Result: {__internal_value} >= {_n}");
			}
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeLessThanOrEqual(number)
	/// @param	{real}	number
	function toBeLessThanOrEqual(_n) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		
		switch (_typeOf) {
			case "number":
				_isValid = __internal_value <= _n;
				break;
			default:
				_typeInvalid = true;
		}		
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeLessThanOrEqual({_n}):");
			array_push(gmtl_test_log, $"- Expected Result: {__internal_value} <= {_n}");
			if (_typeInvalid) {
				array_push(gmtl_test_log, $"- Recieved Result: <Invalid Type: {_typeOf}>");
			} else {
				array_push(gmtl_test_log, $"- Recieved Result: {__internal_value} > {_n}");
			}
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeFalsy()
	function toBeFalsy() {
		var _isValid = !(__internal_value);
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeFalsy():");
			array_push(gmtl_test_log, $"- Expected Result: {false}");
			array_push(gmtl_test_log, $"- Recieved Result: {true}");
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toBeTruthy()
	function toBeTruthy() {
		var _isValid = !!(__internal_value);
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toBeTruthy():");
			array_push(gmtl_test_log, $"- Expected Result: {true}");
			array_push(gmtl_test_log, $"- Recieved Result: {false}");
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
	
	/// @func toContain(value)
	/// @param	{any}	value
	function toContain(_value) {
		var _typeOf	 = typeof(__internal_value);
		var _isValid = false;
		var _typeInvalid = false;
		var _onPos	 = -1
		
		switch (_typeOf) {
			case "array":
				var _arr_len = array_length(__internal_value);
				_onPos = -1;
				
				for (var i = 0; i < _arr_len; i++) {
					if (__internal_value[i] == _value) {
						_isValid = true;
						_onPos = i;
						break;
					}
				}
				break;
			default:
				_typeInvalid = true;
		}
		
		if (!_isValid) {
			var _stacktrace = debug_get_callstack(8);
			var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
			if (_traced_error_index) {
				var _trace = _stacktrace[_traced_error_index]
				var _filename = array_last(string_split(_trace, "@"));
				var _line = string_split(_filename, ":")[1];
				_filename = string_split(_filename, ":")[0];
				_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
				array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
			}
			
			array_push(gmtl_test_log, $"> expect({__internal_value}).toContain({_value}):");
			array_push(gmtl_test_log, $"- Expected Result: Found on Position > -1");
			if (_typeInvalid) {
				array_push(gmtl_test_log, $"- Recieved Result: <Invalid Type: {_typeOf}>");
			} else {
				array_push(gmtl_test_log, $"- Recieved Result: Not Found.");
			}
			gmtl_test_status = __gmtl_test_status.FAILED;
			gmtl_suite_continue = false;
		} else {
			gmtl_test_status = __gmtl_test_status.SUCCESS;
		}
	}
}
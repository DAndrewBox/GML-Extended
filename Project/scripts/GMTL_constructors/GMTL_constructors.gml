/// @func	TestCase(value)
/// @param	{any}	value
function TestCase(_val) constructor {
	__internal_value = _val;	
	
	/// @func toBe(expected_result)
	/// @param	{any}	expected_result
	function toBe(_expectedResult) {
		var _isValid = __internal_value == _expectedResult;
		
		if (!_isValid) {
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
	/// @param	{any}	number
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
}
/// @func	describe(name, fn)
/// @param	{str}		name
/// @param	{callable}	fn
function describe(_name, _fn) {
	gmtl_suite_continue = true;
	gmtl_indent = 0;
	__gmtl_internal_function_log($"------- {_name} -------");

	try {
		_fn();
	} catch(e) {
		__gmtl_internal_function_log(e);
	} finally {
		gmtl_indent = 0;
	}
}

/// @func	it(name, fn)
/// @param	{str}		name
/// @param	{callable}	fn
function it(_name, _fn) {	
	gmtl_test_status = __gmtl_test_status.RUN;
	gmtl_indent = 1;
	
	if (!gmtl_suite_continue) {
		__gmtl_internal_function_log_test_skipped(_name);
		return;
	}
	
	var _time = get_timer();
	try {
		_fn();
		_time = get_timer() - _time;		

		if (gmtl_test_status == __gmtl_test_status.SUCCESS) {
			__gmtl_internal_function_log_test_success(_name, _time);
		} else if (gmtl_test_status == __gmtl_test_status.FAILED) {
			__gmtl_internal_function_log_test_failed(_name, _time);
			gmtl_indent = 2;
			var _tests_stacktrace_len = array_length(gmtl_test_log);
			for (var i = 0; i < _tests_stacktrace_len; i++) {
				__gmtl_internal_function_log(gmtl_test_log[i]);
			}

			gmtl_test_log = [];
		}
	} catch(e) {
		_time = get_timer() - _time;
		__gmtl_internal_function_log_test_failed(_name, _time);
		
		gmtl_indent = 2;
		__gmtl_internal_function_log(e.message);
		__gmtl_internal_function_log(
			string_copy(e.longMessage, string_pos("(line", e.longMessage), string_length(e.longMessage) - string_pos("(line", e.longMessage))
		);
		gmtl_suite_continue = false;
	} finally {
		gmtl_indent = 1;
	}
}

/// @func	test(name, fn)
/// @param	{str}		name
/// @param	{callable}	fn
function test(_name, _fn) {
	it(_name, _fn);
}

/// @func	expect(value)
/// @param	{any}	value
function expect(_val) {
	if (gmtl_suite_continue) {
		return new TestCase(_val);
	}
}

function suite(_suite) {
	__gmtl_internal_function_suite_add_to_queue(_suite);
}
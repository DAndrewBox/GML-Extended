/// @func	describe(name, fn)
/// @param	{string}		name
/// @param	{function}	fn
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

/// @func	it(name, fn, args)
/// @param	{string}		name
/// @param	{function}	fn
/// @param	{array}		args
function it(_name, _fn, _args = []) {	
	gmtl_test_status = __gmtl_test_status.RUN;
	gmtl_indent = 1;
	gmtl_coverage_tests.total++;
	
	if (!gmtl_suite_continue) {
		__gmtl_internal_function_log_test_skipped(_name);
		gmtl_coverage_tests.skipped++;
		return;
	}
	
	var _time = get_timer();
	try {
		script_execute_ext(_fn, _args);
		_time = get_timer() - _time;		

		if (gmtl_test_status == __gmtl_test_status.SUCCESS) {
			__gmtl_internal_function_log_test_success(_name, _time);
			gmtl_coverage_tests.success++;
		} else if (gmtl_test_status == __gmtl_test_status.FAILED) {
			__gmtl_internal_function_log_test_failed(_name, _time);
			gmtl_coverage_tests.failed++;
			gmtl_suite_last_failed = true;
			gmtl_indent = 2;
			var _tests_stacktrace_len = array_length(gmtl_test_log);
			for (var i = 0; i < _tests_stacktrace_len; i++) {
				__gmtl_internal_function_log(gmtl_test_log[i]);
			}
		}
	} catch(e) {
		_time = get_timer() - _time;
		__gmtl_internal_function_log_test_failed(_name, _time);
		gmtl_coverage_tests.failed++;
		
		gmtl_indent = 2;
		var _tests_stacktrace_len = array_length(gmtl_test_log);
		for (var i = 0; i < _tests_stacktrace_len; i++) {
			__gmtl_internal_function_log(gmtl_test_log[i]);
		}
		
		__gmtl_internal_function_log(e.message);
		__gmtl_internal_function_log(
			string_copy(e.longMessage, string_pos("(line", e.longMessage), string_length(e.longMessage) - string_pos("(line", e.longMessage))
		);
		
		gmtl_suite_last_failed = true;
		gmtl_suite_continue = false;
	} finally {
		gmtl_indent = 1;
		gmtl_test_log = [];
	}
}

/// @func	test(name, fn)
/// @param	{string}		name
/// @param	{function}	fn
function test(_name, _fn) {
	it(_name, _fn);
}

/// @func	each(name, fn, cases)
/// @param	{string}		name
/// @param	{function}	fn
/// @param	{array}		cases
function each(_name, _fn, _cases) {
	var _cases_len = get_size(_cases);
	for (var i = 0; i < _cases_len; i++) {
		it($"{_name} [Case {i}]", _fn, _cases[i]);
	}
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
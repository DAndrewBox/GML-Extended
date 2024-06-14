/// @func	describe(name, fn)
/// @param	{string}		name
/// @param	{function}	fn
function describe(_name, _fn) {
	gmtl_suite_continue = true;
	gmtl_indent = 0;
	__gmtl_internal_function_log($"------- {_name} -------");

	try {
		if (is_callable(gmtl_test_before_all)) {
			script_execute(gmtl_test_before_all);
		}
		
		_fn();
		
		if (is_callable(gmtl_test_after_all)) {
			script_execute(gmtl_test_after_all);
		}
	} catch(e) {
		__gmtl_internal_function_log(e);
	} finally {
		gmtl_indent = 0;
		gmtl_test_before_all = noone;
		gmtl_test_after_all = noone;
		gmtl_test_before_each = noone;
		gmtl_test_after_each = noone;
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
		if (is_callable(gmtl_test_before_each)) {
			script_execute(gmtl_test_before_each);
		}
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
		if (is_callable(gmtl_test_after_each)) {
			script_execute(gmtl_test_after_each);
		}
	}
}

/// @func	test(name, fn)
/// @param	{string}	name
/// @param	{function}	fn
function test(_name, _fn) {
	it(_name, _fn);
}

/// @func	each(name, fn, cases)
/// @param	{string}	name
/// @param	{function}	fn
/// @param	{array}		cases
function each(_name, _fn, _cases) {
	var _cases_len = get_size(_cases);
	for (var i = 0; i < _cases_len; i++) {
		var _name_with_params = string_ext(_name, _cases[i]);
		it($"{_name_with_params} [Case {i + 1}]", _fn, _cases[i]);
	}
}

/// @func	expect(value)
/// @param	{any}	value
function expect(_val) {
	if (gmtl_suite_continue) {
		return new TestCase(_val);
	}
}

/// @func	suite(fn)
/// @param	{function}	fn
function suite(_suite) {
	__gmtl_internal_function_suite_add_to_queue(_suite);
}

/// @func	create(x, y, object_index, params)
/// @param	{real}		x
/// @param	{real}		y
/// @param	{ref}		object_index
/// @param	{struct}	params
function create(_x, _y, _obj, _params = {}) {
	if (gmtl_suite_continue) {
		static _layer_name = "__GMTL_LAYER_TESTING";
		var _layer = layer_exists(_layer_name) ? layer_get_id(_layer_name) : layer_create(0, _layer_name);
		var _inst = instance_create_layer(_x, _y, _layer, _obj, _params);
		_inst.waitFor = method(_inst.id, function (_time, _unit) {
			__gmtl_internal_function_wait_for(id, _time, _unit);
		});
		
		return _inst;
	}
}

/// @func	beforeAll(fn)
/// @param	{function}	fn
function beforeAll(_fn) {
	gmtl_test_before_all = _fn;
}

/// @func	afterAll(fn)
/// @param	{function}	fn
function afterAll(_fn) {
	gmtl_test_after_all = _fn;
}

/// @func	beforeEach(fn)
/// @param	{function}	fn
function beforeEach(_fn) {
	gmtl_test_before_each = _fn;
}

/// @func	afterEach(fn)
/// @param	{function}	fn
function afterEach(_fn) {
	gmtl_test_after_each = _fn;
}
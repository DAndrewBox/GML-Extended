gml_pragma("global", "__gmtl_internal_function_init()");
gml_pragma("global", "GMTL_core()");

enum __gmtl_test_status {
	RUN,
	SUCCESS,
	FAILED,
	SKIP
}

#macro	gmtl_internal			global.__gmtl_internal
#macro	gmtl_indent				gmtl_internal.indent
#macro	gmtl_log				gmtl_internal.log
#macro	gmtl_test_log			gmtl_internal.tests.log
#macro	gmtl_test_status		gmtl_internal.tests.status
#macro	gmtl_suite_continue		gmtl_internal.suites.should_continue
#macro	gmtl_suite_list			gmtl_internal.suites.list
#macro	gmtl_suite_last_failed	gmtl_internal.suites.last_failed
#macro	gmtl_coverage_suites	gmtl_internal.coverage.suites
#macro	gmtl_coverage_tests		gmtl_internal.coverage.tests

#macro	gmtl_test_before_all	gmtl_internal.tests.before_all
#macro	gmtl_test_after_all		gmtl_internal.tests.after_all
#macro	gmtl_test_before_each	gmtl_internal.tests.before_each
#macro	gmtl_test_after_each	gmtl_internal.tests.after_each

/// @func __gmtl_internal_function_init()
function __gmtl_internal_function_init() {
	gml_pragma("forceinline");
	global.__gmtl_internal	= {
		indent:	0,
		log:	"",
		tests: {
			log:	[],
			status: __gmtl_test_status.RUN,
			before_all: noone,
			after_all: noone,
		},
		suites: {
			list:				[],
			should_continue:	true,
			last_failed:		false,
		},
		coverage: {
			suites: {
				total:		0,
				success:	0,
				failed:		0,
				skipped:	0,
			},
			tests: {
				total:		0,
				success:	0,
				failed:		0,
				skipped:	0,
			}
		}
	};

	call_later(1, time_source_units_seconds, function() {
		var _t_start = get_timer();
		var _suites_len = array_length(gmtl_suite_list);
		for (var i = 0; i < _suites_len; i++) {
			gmtl_suite_last_failed = false;
			var _suite = gmtl_suite_list[i];
			try {
				_suite();
				if (gmtl_suite_last_failed) {
					throw "Suite Failed";
				}
				gmtl_coverage_suites.success++;
			} catch(e) {
				gmtl_coverage_suites.failed++;
			}
			__gmtl_internal_function_log("=================================");
		}
		
		var _failed, _skipped, _time;
		gmtl_indent = 0;
		__gmtl_internal_function_log("========== Tests Finished! ==========");
		
		_failed	 = gmtl_coverage_suites.failed > 0 ? $"{gmtl_coverage_suites.failed} failed, " : "";
		_skipped = gmtl_coverage_suites.skipped > 0 ? $"{gmtl_coverage_suites.skipped} skipped, " : "";
		__gmtl_internal_function_log($"Test Suites: {gmtl_coverage_suites.success} passed, {_failed}{_skipped}{gmtl_coverage_suites.total} total. ({string_percentage(gmtl_coverage_suites.success, gmtl_coverage_suites.total)})");
		
		_failed	 = gmtl_coverage_tests.failed > 0 ? $"{gmtl_coverage_tests.failed} failed, " : "";
		_skipped = gmtl_coverage_tests.skipped > 0 ? $"{gmtl_coverage_tests.skipped} skipped, " : "";
		__gmtl_internal_function_log($"Tests: {gmtl_coverage_tests.success} passed, {_failed}{_skipped}{gmtl_coverage_tests.total} total. ({string_percentage(gmtl_coverage_tests.success, gmtl_coverage_tests.total)})");
		
		_time = (get_timer() - _t_start) / 1000;
		_time = _time > 1000 ? $"{_time / 1000}s" : $"{_time}ms"
		__gmtl_internal_function_log($"All tests finished in {_time}.\n");

	});
}

/// @func	__gmtl_internal_function_log(message)
/// @param	{string}	message
function __gmtl_internal_function_log(_msg) {
	gml_pragma("forceinline");
	var _pad_left = "";
	for (var i = 0; i < gmtl_indent * 2; i++) {
		_pad_left += "\t";
	}
	_msg = _pad_left + _msg;
	
	gmtl_log += _msg;
	show_debug_message(_msg);
}

/// @func	__gmtl_internal_function_log_test_success(message, time)
/// @param	{string}	message
/// @param	{real}	time
function __gmtl_internal_function_log_test_success(_msg, _time) {
	gml_pragma("forceinline");
	__gmtl_internal_function_log($"✔ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_function_log_test_failed(message, time)
/// @param	{string}	message
/// @param	{real}	time
function __gmtl_internal_function_log_test_failed(_msg, _time) {
	gml_pragma("forceinline");
	__gmtl_internal_function_log($"❌ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_function_log_test_skipped(message)
/// @param	{string}	message
function __gmtl_internal_function_log_test_skipped(_msg) {
	gml_pragma("forceinline");
	__gmtl_internal_function_log($"⚠ (Skipped) {_msg}");
}

/// @func	__gmtl_internal_function_suite_add_to_queue(suite)
/// @param	{function}	suite
function __gmtl_internal_function_suite_add_to_queue(_suite) {
	var _ts = time_source_create(time_source_game, 2, time_source_units_frames, function(_suite) {
		array_push(gmtl_suite_list, _suite);
		gmtl_coverage_suites.total++;
	}, [_suite]);
	time_source_start(_ts);
}

/// @func	__gmtl_internal_function_wait_for(instance, time, unit)
/// @param	{ref}	instance
/// @param	{real}	time
/// @param	{real}	unit
function __gmtl_internal_function_wait_for(_inst, _t, _unit) {
	_t = (_unit == time_source_units_seconds ? _t * game_get_speed(gamespeed_fps) : _t);
	var _count = 0;
	
	while (_count < _t) {
		with (_inst) {
			event_perform(ev_step, ev_step_begin);
			event_perform(ev_step, ev_step_normal);
			event_perform(ev_step, ev_step_end);

			for (var i = 0; i < 12; i++) {
				if (alarm[i] < 0) continue;
				alarm[i] -= 1;
			}
		}
		_count++;
	}
	
	return _inst;
}
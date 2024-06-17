gml_pragma("global", "__gmtl_internal_fn_init()");
gml_pragma("global", "GMTL_definitions()");
gml_pragma("global", "GMTL_internal()");
gml_pragma("global", "GMTL_core_test_setup()");
gml_pragma("global", "GMTL_core_test_events()");
gml_pragma("global", "GMTL_core_TestCase()");

/// @func __gmtl_internal_fn_init()
function __gmtl_internal_fn_init() {
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
		},
		keys: {
			hold:		vk_nokey,
			press:		vk_nokey,
			release:	vk_nokey,
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
			__gmtl_internal_fn_log("=================================");
		}
		
		var _failed, _skipped, _time;
		gmtl_indent = 0;
		__gmtl_internal_fn_log("========== Tests Finished! ==========");
		
		_failed	 = gmtl_coverage_suites.failed > 0 ? $"{gmtl_coverage_suites.failed} failed, " : "";
		_skipped = gmtl_coverage_suites.skipped > 0 ? $"{gmtl_coverage_suites.skipped} skipped, " : "";
		__gmtl_internal_fn_log($"Test Suites: {gmtl_coverage_suites.success} passed, {_failed}{_skipped}{gmtl_coverage_suites.total} total. ({string_percentage(gmtl_coverage_suites.success, gmtl_coverage_suites.total)})");
		
		_failed	 = gmtl_coverage_tests.failed > 0 ? $"{gmtl_coverage_tests.failed} failed, " : "";
		_skipped = gmtl_coverage_tests.skipped > 0 ? $"{gmtl_coverage_tests.skipped} skipped, " : "";
		__gmtl_internal_fn_log($"Tests: {gmtl_coverage_tests.success} passed, {_failed}{_skipped}{gmtl_coverage_tests.total} total. ({string_percentage(gmtl_coverage_tests.success, gmtl_coverage_tests.total)})");
		
		_time = (get_timer() - _t_start) / 1000;
		_time = _time > 1000 ? $"{_time / 1000}s" : $"{_time}ms"
		__gmtl_internal_fn_log($"All tests finished in {_time}.\n");
	});
}

/// @func	__gmtl_internal_fn_log(message)
/// @param	{string}	message
function __gmtl_internal_fn_log(_msg) {
	var _pad_left = "";
	for (var i = 0; i < gmtl_indent * 2; i++) {
		_pad_left += "\t";
	}
	_msg = _pad_left + _msg;
	
	gmtl_log += _msg + "\n";
	show_debug_message(_msg);
}

/// @func	__gmtl_internal_fn_log_test_success(message, time)
/// @param	{string}	message
/// @param	{real}	time
function __gmtl_internal_fn_log_test_success(_msg, _time) {
	__gmtl_internal_fn_log($"✔ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_fn_log_test_failed(message, time)
/// @param	{string}	message
/// @param	{real}	time
function __gmtl_internal_fn_log_test_failed(_msg, _time) {
	__gmtl_internal_fn_log($"❌ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_fn_log_test_skipped(message)
/// @param	{string}	message
function __gmtl_internal_fn_log_test_skipped(_msg) {
	__gmtl_internal_fn_log($"⚠ (Skipped) {_msg}");
}

/// @func	__gmtl_internal_fn_suite_add_to_queue(suite)
/// @param	{function}	suite
function __gmtl_internal_fn_suite_add_to_queue(_suite) {
	var _ts = time_source_create(time_source_game, 2, time_source_units_frames, function(_suite) {
		array_push(gmtl_suite_list, _suite);
		gmtl_coverage_suites.total++;
	}, [_suite]);
	time_source_start(_ts);
}

/// @func	__gmtl_internal_fn_wait_for(instance, time, unit)
/// @param	{ref}	instance
/// @param	{real}	time
/// @param	{real}	unit
function __gmtl_internal_fn_wait_for(_inst, _t, _unit) {
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

/// @func	__gmtl_internal_fn_stacktrace()
function __gmtl_internal_fn_stacktrace() {
	var _stacktrace = debug_get_callstack(8);
	var _traced_error_index = array_find_index(_stacktrace, function (e) {return string_contains(e, "gml_Script_anon@")});
	if (_traced_error_index) {
		var _trace = _stacktrace[_traced_error_index]
		var _filename = array_last(string_split(_trace, "@"));
		var _fname_arr = string_split(_filename, ":");
		var _line = _fname_arr[1];
		_filename = _fname_arr[0];
		_filename = string_copy(_filename, 1, floor(string_length(_filename) / 2));
		array_push(gmtl_test_log, $"On file \"{_filename}\" (line {_line}):");
	}
}

/// @func	__gmtl_internal_fn_keyboard_check(button)
/// @param	{real}	button
function __gmtl_internal_fn_keyboard_check(_btn) {
	return original_keyboard_check(_btn) || gmtl_internal.keys.hold == _btn || gmtl_internal.keys.press == _btn;
}

/// @func	__gmtl_internal_fn_keyboard_check_pressed(button)
/// @param	{real}	button
function __gmtl_internal_fn_keyboard_check_pressed(_btn) {
	return original_keyboard_check_pressed(_btn) || gmtl_internal.keys.press == _btn;
}

/// @func	__gmtl_internal_fn_keyboard_check_released(button)
/// @param	{real}	button
function __gmtl_internal_fn_keyboard_check_released(_btn) {
	return original_keyboard_check_released(_btn) || gmtl_internal.keys.release == _btn;
}
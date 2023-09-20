gml_pragma("global", "__gmtl_internal_function_init()");
gml_pragma("global", "GMTL_core()");

enum __gmtl_test_status {
	RUN,
	SUCCESS,
	FAILED,
	SKIP
}

#macro	gmtl_indent			global.__gmtl_internal_indent
#macro	gmtl_log			global.__gmtl_internal_log
#macro	gmtl_test_log		global.__gmtl_internal_test_log
#macro	gmtl_test_status	global.__gmtl_internal_test_status
#macro	gmtl_suite_continue	global.__gmtl_internal_suite_continue
#macro	gmtl_suite_list		global.__gmtl_internal_suite_list

/// @func __gmtl_internal_function_init()
function __gmtl_internal_function_init() {
	gml_pragma("forceinline");
	global.__gmtl_internal_indent			= 0;
	global.__gmtl_internal_log				= "";
	global.__gmtl_internal_test_log			= [];
	global.__gmtl_internal_test_status		= __gmtl_test_status.RUN;
	global.__gmtl_internal_suite_continue	= true;
	global.__gmtl_internal_suite_list		= [];

	call_later(1, time_source_units_seconds, function() {
		var _t_start = get_timer();
		var _suites_len = array_length(gmtl_suite_list);
		for (var i = 0; i < _suites_len; i++) {
			var _suite = gmtl_suite_list[i];
			_suite();
			__gmtl_internal_function_log("=================================");
		}
		
		gmtl_indent = 0;
		__gmtl_internal_function_log("========== Tests Finished! ==========");
		__gmtl_internal_function_log($"Total Suites: {_suites_len}");
		__gmtl_internal_function_log($"Total Tests Time: {(get_timer() - _t_start) / 1000}ms");
	})
}

/// @func	__gmtl_internal_function_log(message)
/// @param	{str}	message
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
/// @param	{str}	message
/// @param	{real}	time
function __gmtl_internal_function_log_test_success(_msg, _time) {
	gml_pragma("forceinline");
	__gmtl_internal_function_log($"✔ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_function_log_test_failed(message, time)
/// @param	{str}	message
/// @param	{real}	time
function __gmtl_internal_function_log_test_failed(_msg, _time) {
	gml_pragma("forceinline");
	__gmtl_internal_function_log($"❌ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_function_log_test_skipped(message)
/// @param	{str}	message
function __gmtl_internal_function_log_test_skipped(_msg) {
	gml_pragma("forceinline");
	__gmtl_internal_function_log($"⚠ (Skipped) {_msg}");
}

function __gmtl_internal_function_suite_add_to_queue(_suite) {
	var _ts = time_source_create(time_source_game, 2, time_source_units_frames, function(_suite) {
		array_push(gmtl_suite_list, _suite);
	}, [_suite]);
	time_source_start(_ts);
}
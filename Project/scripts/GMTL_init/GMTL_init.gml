gml_pragma("global", "__gmtl_internal_function_init()");

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

/// @func __gmtl_internal_function_init()
function __gmtl_internal_function_init() {
	global.__gmtl_internal_indent			= 0;
	global.__gmtl_internal_log				= "";
	global.__gmtl_internal_test_log			= [];
	global.__gmtl_internal_test_status		= __gmtl_test_status.RUN;
	global.__gmtl_internal_suite_continue	= true;
	
	__gmtl_internal_function_test();
}

/// @func	__gmtl_internal_function_log(message)
/// @param	{str}	message
function __gmtl_internal_function_log(_msg) {
	var _pad_left = "";
	for (var i = 0; i < gmtl_indent * 2; i++) {
		_pad_left += "  ";
	}
	_msg = _pad_left + _msg;
	
	gmtl_log += _msg;
	show_debug_message(_msg);
}

/// @func	__gmtl_internal_function_log_test_success(message, time)
/// @param	{str}	message
/// @param	{real}	time
function __gmtl_internal_function_log_test_success(_msg, _time) {
	__gmtl_internal_function_log($"✔ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_function_log_test_failed(message, time)
/// @param	{str}	message
/// @param	{real}	time
function __gmtl_internal_function_log_test_failed(_msg, _time) {
	__gmtl_internal_function_log($"❌ {_msg} ({_time / 1000}ms)");
}

/// @func	__gmtl_internal_function_log_test_skipped(message)
/// @param	{str}	message
function __gmtl_internal_function_log_test_skipped(_msg) {
	__gmtl_internal_function_log($"⚠ (Skipped) {_msg}");
}
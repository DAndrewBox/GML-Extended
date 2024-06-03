/// @func	now()
/// @desc	Returns the unix timestamp from now datetime.
function now() {
	return unix_timestamp(date_current_datetime());
}

/// @func   unix_timestamp(datetime)
/// @param  {real}  datetime    date-time value (default current time)
/// @desc   Returns a Unix timestamp for the current or given GameMaker datetime.
/// @author Xot
function unix_timestamp(_datetime) {
    static _epoch = floor(date_create_datetime(1970, 1, 1, 0, 0, 0));
    return floor(date_second_span(_epoch, _datetime));
}

/// @func	unix_to_datetime(timestamp)
/// @param	{real}	timestamp
function unix_to_datetime(_timestamp) {
	return date_create_datetime(1970, 1, 1, 0, 0, _timestamp);
}

/// @func	unix_timestamp_format(timestamp, format)
/// @param	{real}	timestamp
function unix_timestamp_format(_timestamp, _format="%YYYY-%MM-%DD %HH:%NN:%SS") {
	var _dt = unix_to_datetime(_timestamp);
	static _month_names = [
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	];
	static _month_abbr = [
		"Jan",
		"Feb",
		"Mar",
		"Apr",
		"May",
		"Jun",
		"Jul",
		"Aug",
		"Sep",
		"Oct",
		"Nov",
		"Dec"
	];
	static _day_names = [
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thrusday",
		"Friday",
		"Saturday",
		"Sunday",
	];
	static _day_abbr = [
		"Mon",
		"Tue",
		"Wed",
		"Thr",
		"Fri",
		"Sat",
		"Sun",
	];
	var _dt_values = {
		year:		date_get_year(_dt),
		month:		date_get_month(_dt),
		day:		date_get_month(_dt),
		hour:		date_get_hour(_dt),
		minute:		date_get_minute(_dt),
		second:		date_get_second(_dt),
		weekday:	date_get_weekday(_dt),
	};
	var _dt_formats = {
		YYYY:	_dt_values[$ "year"],
		YY:		string_copy(_dt_values[$ "year"], 3, 2),
		MM:		string_pad_left(string(_dt_values[$ "month"]), "0", 2),
		DD:		string_pad_left(string(_dt_values[$ "day"]), "0" , 2),
		mm:		_month_names[_dt_values[$ "month"] - 1],
		dd:		_day_names[_dt_values[$ "weekday"] - 1],
		HH:		string_pad_left(string(_dt_values[$ "hour"]), "0" , 2),
		NN:		string_pad_left(string(_dt_values[$ "minute"]), "0" , 2),
		SS:		string_pad_left(string(_dt_values[$ "second"]), "0" , 2),
		M:		_dt_values[$ "month"],
		D:		_dt_values[$ "day"],
		m:		_month_abbr[_dt_values[$ "month"] - 1],
		d:		_day_abbr[_dt_values[$ "weekday"] - 1],
		H:		_dt_values[$ "hour"],
	}
	
	// Sort keys array so longer keys will be checked first
	var _keys = struct_keys(_dt_formats);
	var _keys_len = get_size(_keys);
	array_sort(_keys, sort_elem_size_asc);
	
	for (var i = 0; i < _keys_len; i++) {
		var _key = _keys[i];
		_format = string_replace_all(_format, "%" + _key, _dt_formats[$ _key]);
	}
	
	delete _dt_values;
	delete _dt_formats;
	return _format;
}

/// @func	datetime_get_timestamp()
/// @desc	Returns a string of the current time in format "<%HH:%NN:%SS>"
function datetime_get_timestamp() {
	return unix_timestamp_format(now(), "<%HH:%NN:%SS>");
}

/// @func	time_performance(callback, arguments, iterations)
/// @param	{function}	function
/// @param	{array}	argument
/// @param	{real}	iterations
function time_performance(_func, _args = [], _iter = 1) {
	var _time_start = get_timer();
	
	repeat (_iter) {
		script_execute_ext(_func, _args);
	}
	
	var _time_end = get_timer();
	var _time_delta = (_time_end - _time_start) / 1000;
	
	trace(
		"[Iterations: ", _iter, "] Function ",
		script_get_name(_func), " with arguments ",
		string(_args), "} finished in ", _time_delta, "ms."
	);
}

/// @func	current_week()
function current_week() {
	return date_get_week(date_current_datetime());
}

/// @func	current_day_of_year()
function current_day_of_year() {
	return date_get_day_of_year(date_current_datetime());
}
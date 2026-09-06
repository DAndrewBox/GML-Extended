/// @func   unix_timestamp(datetime)
/// @param  {Real}  datetime    The datetime to get the Unix timestamp from.
/// @desc   Returns a Unix timestamp for the given GameMaker datetime. The calendar values of the datetime are used, so the result is the same on every machine no matter its timezone or daylight saving rules. Use `date_set_timezone(timezone_utc)` if you need `now()` to line up with an external UTC clock.
/// @author Xot
///	@return	{Real}
function unix_timestamp(_datetime) {
	// Built from the calendar values instead of a span between two datetimes, which would
	// drift whenever the epoch and the given date fall on different UTC offsets.
	var _days = __gml_ext_internal_days_from_civil(
		date_get_year(_datetime),
		date_get_month(_datetime),
		date_get_day(_datetime)
	);
	
	return _days * 86400
		+ date_get_hour(_datetime) * 3600
		+ date_get_minute(_datetime) * 60
		+ date_get_second(_datetime);
}

/// @func	now()
/// @desc	Returns the unix timestamp from now datetime. Reads the clock in the timezone GameMaker is set to, see `unix_timestamp`.
///	@return	{Real}
function now() {
	return unix_timestamp(date_current_datetime());
}

/// @func	unix_to_datetime(timestamp)
/// @param	{Real}		timestamp	The Unix timestamp to convert.
///	@desc	Returns a GameMaker datetime from a Unix timestamp. Exact inverse of `unix_timestamp`, so the calendar values always survive the round trip.
///	@return	{Real}
function unix_to_datetime(_timestamp) {
	_timestamp = round(_timestamp);
	
	var _days = floor(_timestamp / 86400);
	var _secs = _timestamp - _days * 86400;
	var _date = __gml_ext_internal_civil_from_days(_days);
	
	return date_create_datetime(
		_date[0], _date[1], _date[2],
		_secs div 3600, (_secs div 60) mod 60, _secs mod 60
	);
}

/// @func	__gml_ext_internal_days_from_civil(year, month, day)
/// @param	{Real}	year	The year of the date.
/// @param	{Real}	month	The month of the date. (1-12)
/// @param	{Real}	day		The day of the date. (1-31)
///	@desc	Returns the whole days between 1970-01-01 and the given calendar date, negative for any date before it.
/// @ignore
function __gml_ext_internal_days_from_civil(_year, _month, _day) {
	// Civil calendar algorithm by Howard Hinnant, the year starts on March so the leap day
	// always lands at the end of it.
	_year -= (_month <= 2);
	
	var _era = (_year >= 0 ? _year : _year - 399) div 400;
	var _yoe = _year - _era * 400;
	var _doy = ((153 * (_month + (_month > 2 ? -3 : 9)) + 2) div 5) + _day - 1;
	var _doe = _yoe * 365 + (_yoe div 4) - (_yoe div 100) + _doy;
	
	return _era * 146097 + _doe - 719468;
}

/// @func	__gml_ext_internal_civil_from_days(days)
/// @param	{Real}	days	The whole days since 1970-01-01.
///	@desc	Returns the calendar date of a day count as an array holding the year, the month and the day.
/// @ignore
function __gml_ext_internal_civil_from_days(_days) {
	// Inverse of `__gml_ext_internal_days_from_civil`.
	_days += 719468;
	
	var _era = (_days >= 0 ? _days : _days - 146096) div 146097;
	var _doe = _days - _era * 146097;
	var _yoe = (_doe - (_doe div 1460) + (_doe div 36524) - (_doe div 146096)) div 365;
	var _doy = _doe - (365 * _yoe + (_yoe div 4) - (_yoe div 100));
	var _mp = (5 * _doy + 2) div 153;
	var _day = _doy - ((153 * _mp + 2) div 5) + 1;
	var _month = _mp + (_mp < 10 ? 3 : -9);
	
	return [_yoe + _era * 400 + (_month <= 2), _month, _day];
}

/// @func	unix_timestamp_format(timestamp, format)
/// @param	{Real}		timestamp	The Unix timestamp to format.
///	@param	{String}	format		The format to use. (Default: "%YYYY-%MM-%DD %HH:%NN:%SS")
///	@desc	Returns a formatted datetime from a Unix timestamp. If no argument is given, the current datetime is used. [Read documentation for formatting help.]
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
		"Sunday",
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday",
	];
	static _day_abbr = [
		"Sun",
		"Mon",
		"Tue",
		"Wed",
		"Thu",
		"Fri",
		"Sat",
	];
	var _dt_values = {
		year:		date_get_year(_dt),
		month:		date_get_month(_dt),
		day:		date_get_day(_dt),
		hour:		date_get_hour(_dt),
		minute:		date_get_minute(_dt),
		second:		date_get_second(_dt),
		weekday:	date_get_weekday(_dt),
	};
	var _dt_formats = {
		YYYY:	string(_dt_values[$ "year"]),
		YY:		string_copy(string(_dt_values[$ "year"]), 3, 2),
		MM:		string_pad_left(string(_dt_values[$ "month"]), "0", 2),
		DD:		string_pad_left(string(_dt_values[$ "day"]), "0" , 2),
		mm:		_month_names[_dt_values[$ "month"] - 1],
		dd:		_day_names[_dt_values[$ "weekday"]],
		HH:		string_pad_left(string(_dt_values[$ "hour"]), "0" , 2),
		NN:		string_pad_left(string(_dt_values[$ "minute"]), "0" , 2),
		SS:		string_pad_left(string(_dt_values[$ "second"]), "0" , 2),
		M:		string(_dt_values[$ "month"]),
		D:		string(_dt_values[$ "day"]),
		m:		_month_abbr[_dt_values[$ "month"] - 1],
		d:		_day_abbr[_dt_values[$ "weekday"]],
		H:		string(_dt_values[$ "hour"]),
	}
	
	// Sort keys array so longer keys will be checked first
	var _keys = struct_keys(_dt_formats);
	var _keys_len = get_size(_keys);
	array_sort(_keys, sort_elem_size_desc);
	
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
/// @param	{Function|Asset.GMScript}	callback		The callback function to test.
/// @param	{Array}						argument		The array of arguments to pass to the function.
/// @param	{Real}						iterations		The number of times to run the function. (Default: 1)
///	@desc	A way to test the performance of a function or code block. It will show in console the time it took to execute the code. It's useful for testing the performance of your code.
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
		string(_args), " finished in ", _time_delta, "ms."
	);
}

/// @func	current_week()
///	@desc	Returns the current week of the year starting from 1.
function current_week() {
	return date_get_week(date_current_datetime()) + 1;
}

/// @func	current_day_of_year()
///	@desc	Returns the current day of the year.
function current_day_of_year() {
	return date_get_day_of_year(date_current_datetime());
}
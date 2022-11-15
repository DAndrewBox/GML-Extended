#region Definitions
global.__MONTH_NAMES = [
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
global.__MONTH_ABBR = [
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
global.__DAY_NAMES = [
	"Monday",
	"Tuesday",
	"Wednesday",
	"Thrusday",
	"Friday",
	"Saturday",
	"Sunday",
];
global.__DAY_ABBR = [
	"Mon",
	"Tue",
	"Wed",
	"Thr",
	"Fri",
	"Sat",
	"Sun",
];
#endregion

/// @func   unix_timestamp(datetime)
/// @param  {datetime}  datetime    date-time value (default current time)
/// @desc   Returns a Unix timestamp for the current or given GameMaker datetime.
/// @author Xot
function unix_timestamp(_datetime) {
    var _epoch = floor(date_create_datetime(1970, 1, 1, 0, 0, 0));
    return floor(date_second_span(_epoch, _datetime));
}

/// @func	now()
/// @desc	Returns the unix timestamp from now datetime.
function now() {
	return unix_timestamp(date_current_datetime());
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
	var _month_names = global.__MONTH_NAMES;
	var _month_abbr = global.__MONTH_ABBR;
	var _day_names = global.__DAY_NAMES;
	var _day_abbr = global.__DAY_ABBR;
	
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
		MM:		string_fill_zero(string(_dt_values[$ "month"]), 2),
		DD:		string_fill_zero(string(_dt_values[$ "day"]), 2),
		mm:		_month_names[_dt_values[$ "month"] - 1],
		dd:		_day_names[_dt_values[$ "weekday"] - 1],
		HH:		string_fill_zero(string(_dt_values[$ "hour"]), 2),
		NN:		string_fill_zero(string(_dt_values[$ "minute"]), 2),
		SS:		string_fill_zero(string(_dt_values[$ "second"]), 2),
		M:		_dt_values[$ "month"],
		D:		_dt_values[$ "day"],
		m:		_month_abbr[_dt_values[$ "month"] - 1],
		d:		_day_abbr[_dt_values[$ "weekday"] - 1],
		H:		_dt_values[$ "hour"],
	}
	
	// Sort keys array so longer keys will be checked first
	var _keys = struct_keys(_dt_formats);
	array_sort(_keys, sort_elem_size_asc);
	
	for (var i = 0; i < size(_keys); i++) {
		var _key = _keys[i];
		_format = string_replace_all(_format, "%" + _key, _dt_formats[$ _key]);
	}
	
	delete _dt_values;
	return _format;
}

/// @func	datetime_get_timestamp()
/// @desc	Returns a string of the current time in format "<%HH:%NN:%SS>"
function datetime_get_timestamp() {
	var _now = now();
	return unix_timestamp_format(_now, "<%HH:%NN:%SS>");
}

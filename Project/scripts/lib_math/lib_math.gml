/// @func	round_dec(x, decimals)
/// @param	{real}	x
/// @param	{real}	decimals
/// @desc	Returns a rounded number with N decimal places to the nearest tenth.
function round_dec(_x, _dec = 0) {
	var _n = power(10, _dec);
	return round(_x * _n) / _n;
}

/// @func	near(value, value_to, offset)
/// @param	{real}	value
/// @param	{real}	value_to
/// @param	{real}	offset
/// @desc	Returns TRUE if VALUE is near (VALUE_TO - OFFSET).
function near(_val, _val_to, _offset) {
	return _val >= _val_to - abs(_offset) && _val <= _val_to + abs(_offset);
}

/// @func	between(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
/// @desc	Returns TRUE if value is between MIN and MAX.
function between(_val, _min, _max) {
	return (_val >= _min) && (_val <= _max);
}

/// @func	rng(chance)
/// @param	{real}	chance
/// @desc	Returns a bool if random value is less than chance.
function rng(_chance) {
	return random_linear(1) < _chance;
}

/// @func	choice_weighted(values, weights)
/// @param	{array}	values
/// @param	{array}	weights
function choice_weighted(_values, _weights) {
	if (!is_array(_values) || !is_array(_weights)) return noone;
	
	var _chance = random_linear(1);
	var _acc = 0;
	var _len = array_length(_values)
	for (var i = 0; i < _len; i++) {
		if (_chance <= (_weights[i] + _acc)) return _values[i];
		_acc += _weights[i];
	}
	
	return noone;
}

/// @func	range(value_to, value_from, steps)
/// @param	{real}	value_to
/// @param	{real}	value_from
/// @param	{real}	steps
/// @desc	Returns an array of numbers from from to to with a step.
function range(_to, _from = 0, _step = 1) {
	var _arr = [];
	
	if (_from > _to) {
		for (var i = _from; i >= _to; i -= _step) {
			array_push(_arr, i);
		}
	} else {
		for (var i = _from; i <= _to; i += _step) {
			array_push(_arr, i);
		}
	}
	
	return _arr;
}

/// @func	wrap(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function wrap(_val, _min, _max) {
	var _mod = ( _val - _min ) mod ( _max - _min );
	if ( _mod < 0 ) return _mod + _max else return _mod + _min;
}

/// @func	random_linear(n)
/// @param	{real}	n
function random_linear(_n = 1) {
	return sqrt(random(_n))
}

/// @func	uuid_v4()
function uuid_v4() {
	var _config_data = os_get_info();
	var _uuid = md5_string_unicode(
		string(
			get_timer() * current_second * current_minute * current_hour * current_day * current_month
		)
		+ (_config_data[? "udid"] ?? now())
		+ string(
			_config_data[? "video_adapter_subsysid"]
		)
	);
	ds_map_destroy(_config_data);
	
	return _uuid;
}

/// @func	percentage(current_value, 100%_value)
/// @param	{real}	current_value
/// @param	{real}	100%_value
function percentage(_val, _max) {
	if (!is_real(_val) || !is_real(_max)) {
		trace("(GML-Extended) - ERROR! On function \"percentage()\". \"current_value\" and/or \"100%_value\" are not numbers.");
		return 0;
	}
	
	return round_dec(100 * (_val / _max), 2);
}
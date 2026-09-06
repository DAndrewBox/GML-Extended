/// @func	round_dec(x, decimals)
/// @param	{Real}	x			The number to round.
/// @param	{Real}	decimals	Optional. The number of decimal places to round the number to. (Default: 0)
/// @desc	Returns a rounded number with N decimal places to the nearest tenth.
///	@return	{Real}
function round_dec(_x, _dec = 0) {
	var _n = power(10, _dec);
	return round(_x * _n) / _n;
}

/// @func	near(value, value_to, offset)
/// @param	{Real}	value		The value to check.
/// @param	{Real}	value_to	The value to check against.
/// @param	{Real}	offset		The offset to check.
/// @desc	Returns a boolean if the first value is near the second value with a defined offset.
///	@return	{Bool}
function near(_val, _val_to, _offset) {
	return _val >= _val_to - abs(_offset) && _val <= _val_to + abs(_offset);
}

/// @func	between(value, min, max)
/// @param	{Real}	value	The value to check.
/// @param	{Real}	min		The minimum value.
/// @param	{Real}	max		The maximum value.
/// @desc	Returns a boolean if the first value is near the second value with an offset.
///	@return	{Bool}
function between(_val, _min, _max) {
	return (_val >= _min) && (_val <= _max);
}

/// @func	rng(chance)
/// @param	{Real}	chance	The normalized value to check
/// @desc	Returns a boolean if the random value is less than the chance. All values must be between 0 and 1 where 0 is 0% chance and 1 is 100%.
///	@return	{Bool}
function rng(_chance) {
	return random(1) < _chance;
}

/// @func	choice_weighted(values, weights)
/// @param	{Array}	values	The array of values to choose from.
/// @param	{Array}	weights	The array of weights of the values. Must share the same index and length than `values`.
/// @desc	Returns a random value from an array of values with a weight. Both arrays must be the same length and weights must sum to 1, if not, `noone` will be returned.
///	@return	{Any}
function choice_weighted(_values, _weights) {
	if (!is_array(_values) || !is_array(_weights)) return noone;
	if (array_length(_values) != array_length(_weights)) return noone;
	
	var _chance = random(1);
	var _acc = 0;
	var _len = array_length(_values)
	for (var i = 0; i < _len; i++) {
		if (_chance <= (_weights[i] + _acc)) return _values[i];
		_acc += _weights[i];
	}
	
	return noone;
}

/// @func	range(value_to, value_from, steps)
/// @param	{Real}	value_to		The end of the range
/// @param	{Real}	value_from		Optional. The start of the range. (default: 0)
/// @param	{Real}	steps			Optional. The step of the range. (default = 1)
/// @desc	Returns an array of numbers from `from` to `to` with a step of `step`. If `step` is not provided, it will default to 1. If `from` is greater than `to`, the array will be reversed.
function range(_to, _from = 0, _step = 1) {
	var _arr = [];
	
	// A step of 0 or less never reaches `to` and would loop forever.
	if (_step <= 0) {
		trace("(GML-Extended) - ERROR! On function \"range()\". \"steps\" must be greater than 0.");
		return _arr;
	}
	
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
/// @param	{Real}	value	The value to wrap
/// @param	{Real}	min		The minimum value
/// @param	{Real}	max		The maximum value
/// @desc	Wraps the value to the range of `min` to `max`. If the value is less than `min`, it will return `max`. If the value is greater than `max`, it will return `min`.
///	@return	{Real}
function wrap(_val, _min, _max) {
	if (_min == _max) return _min;
	var _mod = ( _val - _min ) mod ( _max - _min );
	if ( _mod < 0 ) return _mod + _max else return _mod + _min;
}

/// @func	random_linear(n)
/// @param	{Real}	n	Optional. The value to check. (Default: 1)
/// @desc	Returns a random value with a linear distribution. This is more random than `random()`.
///	@return	{Real}
function random_linear(_n = 1) {
	return sqrt(random(_n))
}

/// @func	random_range_linear(n1, n2)
/// @param	{Real}	n1	Minimum value of the range to check.
/// @param	{Real}	n2	Maximum value of the range to check.
/// @desc	Returns a random value with a linear distribution within a range. This is more random than `random_range()`.
///	@return	{Real}
function random_range_linear(_n1, _n2) {
	var _min = min(_n1, _n2);
	var _max = max(_n1, _n2);
	return _min + (_max - _min) * random_linear(1);
}

/// @func	uuid_v4()
/// @desc	Returns a random UUID v4.
///	@return	{String}
function uuid_v4() {
	var _config_data = os_get_info();
	var _udid = _config_data[? "udid"];
	var _hex = md5_string_unicode(
		string(get_timer())
		+ string(now())
		+ string(irandom(0x7FFFFFFF))
		+ string(is_undefined(_udid) ? "" : _udid)
		+ string(_config_data[? "video_adapter_subsysid"])
	);
	ds_map_destroy(_config_data);
	
	// Force the version (4) and variant (8, 9, a or b) nibbles required by RFC 4122.
	_hex = string_copy(_hex, 1, 12) + "4" + string_copy(_hex, 14, 3)
		+ string_char_at("89ab", irandom(3) + 1) + string_copy(_hex, 18, 15);
	
	return string_copy(_hex, 1, 8) + "-" + string_copy(_hex, 9, 4) + "-"
		+ string_copy(_hex, 13, 4) + "-" + string_copy(_hex, 17, 4) + "-"
		+ string_copy(_hex, 21, 12);
}

/// @func	percentage(current_value, total_value)
/// @param	{Real}	current_value	The current value.
/// @param	{Real}	total_value		The total value to compare. This value corresponds to the 100%.
///	@desc	Returns the percentage of the given values.
function percentage(_val, _max) {
	if (!is_real(_val) || !is_real(_max)) {
		trace("(GML-Extended) - ERROR! On function \"percentage()\". \"current_value\" and/or \"100%_value\" are not numbers.");
		return 0;
	}
	
	if (_max == 0) {
		trace("(GML-Extended) - ERROR! On function \"percentage()\". \"total_value\" cannot be 0.");
		return 0;
	}
	
	return round_dec(100 * (_val / _max), 2);
}

/// @func	dec2hex(decimal, len)
/// @param	{Real}	decimal		The decimal number to convert
/// @param	{Real}	len			Optional. The minimum length of the resulting string. (default = 6)
/// @desc	Converts a decimal number to a hexadecimal string. The resulting string will have a minimum length, padded with leading zeros if necessary.
function dec2hex(_dec, _hex_len = 6) {
    static _dig = "0123456789ABCDEF";
	var _len = 1;
	var _hex = "";
	
	// Negatives have no defined hexadecimal form here, so they are clamped to 0.
	_dec = floor(max(0, _dec));
	
    while (_len-- || _dec) {
		var _char = string_char_at(_dig, (_dec & $F) + 1);
        _hex = _char + _hex;
        _dec = _dec >> 4;
    }
 
    return string_pad_left(_hex, "0", _hex_len);
}

/// @func	approach(value, target, step)
/// @param	{Real}	value	The current value.
/// @param	{Real}	target	The value to move towards.
/// @param	{Real}	step	How much to move on this call. The sign is ignored.
/// @desc	Moves a value towards a target by a fixed step without ever overshooting it. Returns the target once it is reached.
///	@return	{Real}
function approach(_val, _target, _step) {
	_step = abs(_step);

	if (_val < _target) return min(_val + _step, _target);
	return max(_val - _step, _target);
}

/// @func	lerp_angle(angle1, angle2, amount)
/// @param	{Real}	angle1	The angle to start from, in degrees.
/// @param	{Real}	angle2	The angle to move towards, in degrees.
/// @param	{Real}	amount	The normalized amount to move. (0.0-1.0)
/// @desc	Interpolates between two angles taking the shortest way around the circle, so going from 350 to 10 moves forward instead of all the way back.
///	@return	{Real}
function lerp_angle(_angle_1, _angle_2, _amount) {
	return _angle_1 + angle_difference(_angle_2, _angle_1) * _amount;
}

/// @func	normalize(value, in_min, in_max, [out_min], [out_max])
/// @param	{Real}	value	The value to convert.
/// @param	{Real}	in_min	The minimum of the range the value belongs to.
/// @param	{Real}	in_max	The maximum of the range the value belongs to.
/// @param	{Real}	out_min	Optional. The minimum of the range to convert the value to. (Default: 0)
/// @param	{Real}	out_max	Optional. The maximum of the range to convert the value to. (Default: 1)
/// @desc	Converts a value from one range to another. With the default arguments it normalizes the value between 0 and 1. The value is not clamped, so a value outside the input range lands outside the output range too.
///	@return	{Real}
function normalize(_val, _in_min, _in_max, _out_min = 0, _out_max = 1) {
	if (_in_min == _in_max) {
		trace("(GML-Extended) - ERROR! On function \"normalize()\". \"in_min\" and \"in_max\" cannot be the same value.");
		return _out_min;
	}

	return _out_min + (_val - _in_min) / (_in_max - _in_min) * (_out_max - _out_min);
}

/// @func	snap(value, grid)
/// @param	{Real}	value	The value to snap.
/// @param	{Real}	grid	The size of the grid to snap the value to.
/// @desc	Rounds a value to the closest multiple of `grid`. A grid of 0 returns the value as it is.
///	@return	{Real}
function snap(_val, _grid) {
	if (_grid == 0) return _val;

	return round(_val / _grid) * _grid;
}
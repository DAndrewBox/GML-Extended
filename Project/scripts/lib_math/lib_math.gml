#macro	PI	3.14159265

/// @func	round_dec(x, decimals)
/// @param	{real}	x
/// @param	{real}	decimals
/// @desc	Returns a rounded number with N decimal places.
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
	return random(1) < _chance;
}

/// @func	choice_weighted(values, weights)
/// @param	{array}	values
/// @param	{array}	weights
function choice_weighted(_values, _weights) {
	if (!is_array(_values) || !is_array(_weights)) return noone;
	
	var _chance = random(1);
	var _acc = 0;
	for (var i = 0; i < array_length(_values); i++) {
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
		for (var i = _to; i > _from; i -= _step) {
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
	if (_min > _max) {
		var _tmp = _max;
		_max = _min;
		_min = _tmp;
	}
	
	while (_val < _min || _val > _max) {
		if (_val > _max) {
			_val -= (_max - _min);
		} else if (_val < _min) {
			_val += (_max - _min);
		}
	}
	
	return _val;
}

/// @func	uuid_v4()
function uuid_v4() {
	var _config_data = os_get_info();
	var _uuid = md5_string_unicode(
		string(
			get_timer() * current_second * current_minute * current_hour * current_day * current_month
		) + _config_data[? "udid"]
		+ string(
			_config_data[? "video_adapter_subsysid"]
		)
	);
	ds_map_destroy(_config_data);
	
	return _uuid;
}

/// @func	dec_rgb2rgba(decimal_rgb, alpha)
/// @param	{real}	decimal_rgb
/// @desc	Given Decimal RGB, returns Decimal RGBA.
function dec_rgb2rgba(_dec_rgb, _alpha = 1) {
	var _alpha_ratio = floor(_alpha * 255);
	var _alpha_dec = _alpha_ratio << 24;
	return _alpha_dec | (_dec_rgb & 0xFFFFFF);
}

/// @func	dec2hex(decimal, len)
/// @param	{real}	decimal
/// @param	{real}	len
function dec2hex(_dec, _max_len = 1) {
    static _dig = "0123456789ABCDEF";
	var _len = 1;
	var _hex = "";
	
    if (_dec < 0) {
        _len = max(_len, ceil(logn(16, 2 * abs(_dec))));
    }
	
	var _last_hex_len = 0;
    while (_len-- || _dec) {
		var _char = string_char_at(_dig, (_dec & $F) + 1);
        _hex = _char + _hex;
        _dec = _dec >> 4;
		if (string_length(_hex) == _last_hex_len) {
			_hex = "0" + _hex;
		}
		_last_hex_len = string_length(_hex);
    }
 
    return string_pad_left(_hex, "0", _max_len);
}

/// @func	rgba_dec2hex(rgb_dec, alpha)
/// @param {int}	rgb_dec
/// @param {real}	alpha
/// @return The hexadecimal color string.
function rgba_dec2hex(_rgb_dec, _alpha = 1.) {
	var _dec = (_rgb_dec & 16711680) >> 16 | (_rgb_dec & 65280) | (_rgb_dec & 255) << 16;
	var _hex = dec2hex(_dec, 6);
	var _hex_alpha = dec2hex(floor(_alpha * 255), 2);
    return "$" + hex_rgba2abgr($"{_hex}{_hex_alpha}");
}

/// @func	color_get_alpha(rgba_dec)
/// @param	{real}	rgba_dec
function color_get_alpha(_rgba_dec) {
	return ((_rgba_dec >> 24) & 0xFF) / 255;
}

/// @func hex_rgba2abgr(hex_input)
/// @param {str} hex_input
function hex_rgba2abgr(_input) {
    var _output = "";
    var _length = string_length(_input);
    var _pairCount = _length div 2;
    
    for (var i = 0; i < _pairCount; i++) {
        var _pair = string_copy(_input, i * 2 + 1, 2);
        _output = _pair + _output;
    }
    
    return _output;
}
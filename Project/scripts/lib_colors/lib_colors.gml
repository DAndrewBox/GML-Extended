/// @func	rgb(red, green, blue)
/// @param	{real}	red
/// @param	{real}	green
/// @param	{real}	blue
/// @desc	Returns a decimal value given wrapped RGB values.
function rgb(_r, _g, _b) {
	return make_colour_rgb(
		wrap(_r, 0, 256),
		wrap(_g, 0, 256),
		wrap(_b, 0, 256)
	);
}

/// @func	hsv(hue, saturation, value)
/// @param	{real}	hue
/// @param	{real}	saturation
/// @param	{real}	value
/// @desc	Returns a decimal value given wrapped RGB values.
function hsv(_h, _s, _v) {
	return make_colour_hsv(
		wrap(_h, 0, 256),
		wrap(_s, 0, 256),
		wrap(_v, 0, 256)
	);
}

/// @func	color_get_rgb(color)
/// @param	{real}	color
function color_get_rgb(_color) {
	return [
		color_get_red(_color),
		color_get_green(_color),
		color_get_blue(_color),
	];
}

/// @func	color_get_hsv(color)
/// @param	{real}	color
function color_get_hsv(_color) {
	return [
		color_get_hue(_color),
		color_get_saturation(_color),
		color_get_value(_color),
	];
}

/// @func	dec2hex(decimal, len)
/// @param	{real}	decimal
/// @param	{real}	len
function dec2hex(_dec, _max_len = 6) {
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

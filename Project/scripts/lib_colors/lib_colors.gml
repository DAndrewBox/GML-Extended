/// @func	rgb(red, green, blue)
/// @param	{real}	red
/// @param	{real}	green
/// @param	{real}	blue
/// @desc	Returns a decimal value given wrapped RGB values.
function rgb(_r, _g, _b) {
	return make_colour_rgb(
		wrap(_r, 0, 255),
		wrap(_g, 0, 255),
		wrap(_b, 0, 255)
	);
}

/// @func	hsv(hue, saturation, value)
/// @param	{real}	hue
/// @param	{real}	saturation
/// @param	{real}	value
/// @desc	Returns a decimal value given wrapped RGB values.
function hsv(_h, _s, _v) {
	return make_colour_hsv(
		wrap(_h, 0, 255),
		wrap(_s, 0, 255),
		wrap(_v, 0, 255)
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

/// @func	color_get_alpha(rgba_dec)
/// @param	{real}	rgba_dec
function color_get_alpha(_rgba_dec) {
	return ((_rgba_dec >> 24) & 0xFF) / 255;
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
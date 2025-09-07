/// @func	rgb(red, green, blue)
/// @param	{Real}	red		The red value of the color. (0-255)
/// @param	{Real}	green	The green value of the color. (0-255)
/// @param	{Real}	blue	The blue value of the color. (0-255)
/// @desc	Returns a decimal value given wrapped RGB values.
///	@return	{Real}
function rgb(_r, _g, _b) {
	_r = int8(_r);
	_g = int8(_g);
	_b = int8(_b);
	
	return make_colour_rgb(_r, _g, _b);
}

/// @func	hsv(hue, saturation, value)
/// @param	{Real}	hue			The hue value of the color. (0-255)
/// @param	{Real}	saturation	The saturation value of the color. (0-255)
/// @param	{Real}	value		The value of the color. (0-255)
/// @desc	Returns a decimal value given wrapped RGB values.
///	@return	{Real}
function hsv(_h, _s, _v) {
	_h = int8(_h);
	_s = int8(_s);
	_v = int8(_v)
	
	return make_colour_hsv(_h, _s, _v);
}

/// @func	color_get_rgb(color)
/// @param	{Real|Constant.Color}	color	The color to get the RGB values from.
/// @desc	Gets the RGB values of the color passed as argument. Serves as a shortcut for `color_get_red`, `color_get_green`, and `color_get_blue`.
///	@return	{Array<Real>}
function color_get_rgb(_color) {
	return [
		color_get_red(_color),
		color_get_green(_color),
		color_get_blue(_color),
	];
}

/// @func	color_get_hsv(color)
/// @param	{Real|Constant.Color}	color	The color to get the HSV values from.
/// @desc	Gets the HSV values of the color passed as argument. Serves as a shortcut for `color_get_hue`, `color_get_saturation`, and `color_get_value`.
///	@return	{Array<Real>}
function color_get_hsv(_color) {
	return [
		color_get_hue(_color),
		color_get_saturation(_color),
		color_get_value(_color),
	];
}

/// @func	color_get_rgb_normalized(color)
/// @param	{Real|Constant.Color}	color	The color to get the normalized RGB values from.
/// @desc	Gets the RGB values of the color passed as argument, normalized between 0 and 1. Works the same way as `color_get_rgb`, but the values are divided by 255.
///	@return	{Array<Real>}
function color_get_rgb_normalized(_color) {
	return [
		color_get_red(_color) / 255,
		color_get_green(_color) / 255,
		color_get_blue(_color) / 255,
	];
}

/// @func	color_get_hsv_normalized(color)
/// @param	{Real|Constant.Color}	color	The color to get the normalized HSV values from.
/// @desc	Gets the HSV values of the color passed as argument, normalized between 0 and 1. Works the same way as `color_get_hsv`, but the values are divided by 255.
///	@return	{Array<Real>}
function color_get_hsv_normalized(_color) {
	return [
		color_get_hue(_color) / 255,
		color_get_saturation(_color) / 255,
		color_get_value(_color) / 255,
	];
}

/// @func	color_to_hex_rgb(color)
/// @param	{Real|Constant.Color}	color	The decimal color value to convert to an hex string.
/// @desc	Converts a decimal color value to a hexadecimal string. The resulting string will be in the format `RRGGBB`.
///	@return	{String}
function color_to_hex_rgb(_color) {
    return dec2hex(_color, 6);
}

/// @func	color_to_hex_rgba(color_rgb, alpha)
/// @param	{Real|Constant.Color}	color_rgb	The decimal color value to convert to an hex string.
/// @param	{Real}					alpha		Optional. The normalized alpha value of the color. (0.0-1.0)
/// @desc	Converts a decimal color given a normalized alpha value to a 8-char long hexadecimal string. The resulting string will be in the format `RRGGBBAA`.
///	@return	{String}
function color_to_hex_rgba(_rgb_dec, _alpha = 1.) {
	var _dec = (_rgb_dec & 16711680) >> 16 | (_rgb_dec & 65280) | (_rgb_dec & 255) << 16;
	var _hex = color_to_hex_rgb(_dec);
	var _hex_alpha = dec2hex(floor(_alpha * 255), 2);
	
	return _hex + _hex_alpha;
}

/// @func color_hex_rgba_to_abgr(hex_input)
/// @param	{String}	hex_input	The hexadecimal color string to convert in "RRGGBB".
///	@desc	Converts a hexadecimal color string in the format `RRGGBBAA` to a decimal color value in the ABGR format `AABBGGRR` to comply with GameMaker color code.
///	@return	{String}
function color_hex_rgba_to_abgr(_input) {
    var _output = "";
    var _length = string_length(_input);
    var _pairCount = _length div 2;
    
    for (var i = 0; i < _pairCount; i++) {
        var _pair = string_copy(_input, i * 2 + 1, 2);
        _output = _pair + _output;
    }
    
    return _output;
}

/// @func	color_rgba_get_alpha(color_rgba)
/// @param	{Real|Constant.Color}	color_rgba	The color to get the alpha from.
/// @desc	Gets the alpha value of a color in the range of 0 to 1.
///	@return	{Real}
function color_rgba_get_alpha(_color_rgba) {
	return ((_color_rgba >> 24) & 0xFF) / 255;
}
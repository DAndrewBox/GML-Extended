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

/// @func	color_rgba_get_alpha(rgba_dec)
/// @param	{real}	rgba_dec
function color_rgba_get_alpha(_rgba_dec) {
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
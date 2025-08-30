/// @func	dec_rgb2rgba(decimal_rgb, alpha)
/// @param	{Real}	decimal_rgb
/// @desc	Given Decimal RGB, returns Decimal RGBA.
function dec_rgb2rgba(_dec_rgb, _alpha = 1) {
	var _alpha_ratio = floor(_alpha * 255);
	var _alpha_dec = _alpha_ratio << 24;
	return _alpha_dec | (_dec_rgb & 0xFFFFFF);
}
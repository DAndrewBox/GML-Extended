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
		wrap(_r, 0, 255),
		wrap(_g, 0, 255),
		wrap(_b, 0, 255)
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

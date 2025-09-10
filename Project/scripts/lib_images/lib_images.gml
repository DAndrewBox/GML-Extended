/// @func	image_loop_index(start_index, end_index, speed)
/// @param	{Real}	start_index		The first index of the image
/// @param	{Real}	end_index		The last index of the image
/// @param	{Real}	speed			The speed of the animation
/// @desc	Loops the index of an image between a start and end index (end frame included).
function image_loop_index(_frame_start, _frame_end, _spd) {
	var _frame_next = image_index + _spd;
	var _frame =
		(floor(_frame_next) <= _frame_end)
		? _frame_next
		: _frame_start;

	return _frame;
}

/// @func	image_set(index, speed, xscale, yscale, angle, blend, alpha)
/// @param	{Real}					index		Optional. The index of the image
/// @param	{Real}					speed		Optional. The speed of the animation
/// @param	{Real}					xscale		Optional. The horizontal scale of the image
/// @param	{Real}					yscale		Optional. The vertical scale of the image
/// @param	{Real}					angle		Optional. The angle of the image
/// @param	{Real|Constant.Color}	blend		Optional. The blend mode of the image
/// @param	{Real}					alpha		Optional. The alpha value of the image
/// @desc	Sets the image properties. This function is used to set the image properties of the instance. The properties are the index, speed, xscale, yscale, angle, blend, and alpha.
function image_set(_index = image_index, _spd = image_speed, _xscale = image_xscale, _yscale = image_yscale, _angle = image_angle, _blend = image_blend, _alpha = image_alpha) {
	image_index		= _index;
	image_speed		= _spd;
	image_xscale	= _xscale;
	image_yscale	= _yscale;
	image_angle		= _angle;
	image_blend		= _blend;
	image_alpha		= _alpha;
}

/// @func	image_set_scale(xscale, yscale)
/// @param	{Real}	xscale		The horizontal scale of the image
/// @param	{Real}	yscale		The vertical scale of the image
/// @desc	Sets the image xscale and yscale properties.
function image_set_scale(_xscale, _yscale) {
	image_xscale = _xscale;
	image_yscale = _yscale;
}


/// @func	image_smooth_rotate(direction, speed_factor)
/// @param	{Real}	direction		The angle to rotate the image to
/// @param	{Real}	speed_factor	Optional. The speed of the rotation. (Default: 0.1)
///	@desc	Rotates the image smoothly to a given angle. This function should be used on the step event.
function image_smooth_rotate(_dir, _factor = .1) {
	var _diff = angle_difference(_dir, image_angle);
	image_angle = lerp(image_angle, image_angle + _diff, _factor);
}
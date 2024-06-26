/// @func	image_loop_index(start_index, end_index, speed)
/// @param	{real}	start_index
/// @param	{real}	end_index
/// @param	{real}	speed
/// @desc	Loops image_index value from start_index to end_index USING end_index as the last frame.
function image_loop_index(_frame_start, _frame_end, _spd) {
	var _frame_next = image_index + _spd;
	var _frame =
		(floor(_frame_next) <= _frame_end)
		? _frame_next
		: _frame_start;

	return _frame;
}

/// @func	image_set(index, speed, xscale, yscale, angle, blend, alpha)
/// @param	{real}	index
/// @param	{real}	speed
/// @param	{real}	xscale
/// @param	{real}	yscale
/// @param	{real}	angle
/// @param	{real}	blend
/// @param	{real}	alpha
/// @desc	Sets image_* parameters shortcut
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
/// @param	{real}	xscale
/// @param	{real}	yscale
/// @desc	Sets image_xscale and image_yscale parameters
function image_set_scale(_xscale, _yscale) {
	image_xscale = _xscale;
	image_yscale = _yscale;
}


/// @func	image_smooth_rotate(direction, speed_factor)
/// @param	{real}	direction
/// @param	{real}	speed_factor
function image_smooth_rotate(_dir, _factor = .1) {
	var _diff = angle_difference(_dir, image_angle);
	image_angle = lerp(image_angle, image_angle + _diff, _factor);
}
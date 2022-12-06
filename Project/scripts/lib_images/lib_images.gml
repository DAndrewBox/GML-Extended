/// @func	image_loop_index(start_index, end_index, speed)
/// @param	{real}	start_index
/// @param	{real}	end_index
/// @param	{float}	speed
/// @desc	Loops image_index value from start_index to end_index USING end_index as the last frame.
function image_loop_index(_frame_start, _frame_end, _spd) {
	var _frame_next = image_index + _spd;
	var _frame =
		(floor(_frame_next) <= _frame_end)
		? _frame_next
		: _frame_start;

	return _frame;
}
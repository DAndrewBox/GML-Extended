#region Internal definitions
#macro	gui_width	display_get_gui_width()
#macro	gui_height	display_get_gui_height()
#macro	mouse_gui_x	device_mouse_x_to_gui(0)
#macro	mouse_gui_y	device_mouse_y_to_gui(0)
#endregion

/// @func	mouse_in_gui_area(x1, y1, x2, y2)
/// @param	{Real}	x1		The left x position of the area
/// @param	{Real}	y1		The top y position of the area
/// @param	{Real}	x2		The right x position of the area
/// @param	{Real}	y2		The bottom y position of the area
///	@desc	Returns a boolean if the mouse is inside a GUI area.
function mouse_in_gui_area(_x1, _y1, _x2, _y2) {
	return point_in_rectangle(mouse_gui_x, mouse_gui_y, _x1, _y1, _x2, _y2);
}

/// @func	mouse_in_area(x1, y1, x2, y2)
/// @param	{Real}	x1		The left x position of the area
/// @param	{Real}	y1		The top y position of the area
/// @param	{Real}	x2		The right x position of the area
/// @param	{Real}	y2		The bottom y position of the area
///	@desc	Returns a boolean if the mouse is inside a room area (not GUI).
function mouse_in_area(_x1, _y1, _x2, _y2) {
	return point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2);
}

/// @func	mouse_in_instance(inst_id)
/// @param	{Id.Instance|Asset.GMObject}	inst_id		The instance to check
/// @desc	Returns a boolean if the mouse is inside an instance boundary box.
///	@return	{Bool}
function mouse_in_instance(_inst_id) {
	if (!instance_exists(_inst_id)) return false;
	return bool(collision_point(mouse_x, mouse_y, _inst_id, true, false));
}

/// @func	mouse_is_moving()
///	@desc	[WARNING] This function is not available in GameMaker versions before v2024.1. Returns a boolean if the mouse is moving.
function mouse_is_moving() {
	static _use_compatibility = GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 8;
	if (_use_compatibility) {
		global.__gml_ext.custom_mouse_x_last = global.__gml_ext.custom_mouse_x;
		global.__gml_ext.custom_mouse_y_last = global.__gml_ext.custom_mouse_y;

		global.__gml_ext.custom_mouse_x = window_mouse_get_x();
		global.__gml_ext.custom_mouse_y = window_mouse_get_y();
		
		return (global.__gml_ext.custom_mouse_x_last == global.__gml_ext.custom_mouse_x && global.__gml_ext.custom_mouse_y_last == global.__gml_ext.custom_mouse_y);
	}
	
	return bool(abs(window_mouse_get_delta_x()) + abs(window_mouse_get_delta_y()));
}

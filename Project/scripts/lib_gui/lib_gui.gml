#region Internal definitions
#macro	gui_width	display_get_gui_width()
#macro	gui_height	display_get_gui_height()
#macro	mouse_gui_x	device_mouse_x_to_gui(0)
#macro	mouse_gui_y	device_mouse_y_to_gui(0)
#endregion

/// @func	mouse_in_gui_area(x1, y1, x2, y2)
/// @param	{real}	x1
/// @param	{real}	y1
/// @param	{real}	x2
/// @param	{real}	y2
function mouse_in_gui_area(_x1, _y1, _x2, _y2) {
	return point_in_rectangle(mouse_gui_x, mouse_gui_y, _x1, _y1, _x2, _y2);
}

/// @func	mouse_in_area(x1, y1, x2, y2)
/// @param	{real}	x1
/// @param	{real}	y1
/// @param	{real}	x2
/// @param	{real}	y2
function mouse_in_area(_x1, _y1, _x2, _y2) {
	return point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2);
}

/// @func	mouse_in_instance(inst_id)
/// @param	{Id.Instance|Asset.Object}	inst_id
function mouse_in_instance(_inst_id) {
	if (!instance_exists(_inst_id)) return false;
	return !!collision_point(mouse_x, mouse_y, _inst_id, true, false);
}

/// @func	mouse_is_moving()
function mouse_is_moving() {
	static _use_compatibility = GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 8;
	if (_use_compatibility) {
		global.__gml_ext_mouse_x_last = global.__gml_ext_mouse_x;
		global.__gml_ext_mouse_y_last = global.__gml_ext_mouse_y;

		global.__gml_ext_mouse_x = window_mouse_get_x();
		global.__gml_ext_mouse_y = window_mouse_get_y();
		
		return (global.__gml_ext_mouse_x_last == global.__gml_ext_mouse_x && global.__gml_ext_mouse_y_last == global.__gml_ext_mouse_y);
	}
	
	return bool(abs(window_mouse_get_delta_x()) + abs(window_mouse_get_delta_y()));
}


/// @func	gui_mouse_x()
function gui_mouse_x() {
	return device_mouse_x_to_gui(0);
}

/// @func	gui_mouse_y()
function gui_mouse_y() {
	return device_mouse_y_to_gui(0);
}

/// @func	gui_width()
function gui_width() {
	return display_get_gui_width();
}
/// @func	gui_height()
function gui_height() {
	return display_get_gui_height();
}
/// @description 
if (keyboard_check_pressed(ord("Q"))) {
	page_index = wrap(page_index - 1, 0, get_size(page));
}

if (keyboard_check_pressed(ord("E"))) {
	page_index = wrap(page_index + 1, 0, get_size(page));
}

if (keyboard_check_pressed(vk_space)) {
	room_goto(r_gml_ext_test_ease);
}

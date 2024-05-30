/// @description 
var _count = 0;
var _val = abs(dsin(t));

if (inactive_t < 0) {
	t++;

	if (t > 0 && t mod 90 == 0) {
		inactive_t = game_get_speed(gamespeed_fps) * .01;
	}
	
	if (t > 0 && t mod 180 == 0) {
		t = 0;
	}
}

inactive_t--;

if (!surface_exists(surf_lines)) {
	event_user(0);
}
draw_surface_ext(surf_lines, 0, 0, 1, 1, 0, c_white, .25 + _val * .16);

for (var _xx = 0; _xx < 5; _xx++) {
	for (var _yy = 0; _yy < 6; _yy++) {
		var _ret_value = script_execute_ext(callbacks[_count], [_val]);
		var _x = _yy * 192;
		var _y = _xx * 128;
		
		var _color = merge_colour(c_navy, c_red, (_count div 3 / 10));
		draw_set_color(_color);
		draw_set_alpha(.10 + _val * .06);
		draw_roundrect_ext(96 + _x, 64 + _y, 192 + 80 + _x, 128 + 48 + _y, 16, 16, false);
	
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text(192 + _x - 8, 128 + _y + 64, script_get_name(callbacks[_count]));
		
		_color = merge_colour(c_gray, _color, .50);
		draw_set_color(_color);
		draw_set_alpha(.33 + _val * .16);
		
		draw_circle(96 + _x + (176 * _val), 80 + _y + (80 * (1 - _ret_value)), 4, false);
		
		_x = 120 + _x + (128 * _ret_value);
		_y = 128 + _y;
		_color = merge_colour(c_aqua, c_purple, _count / 30);
		draw_set_color(_color);
		
		draw_set_alpha(1);
		draw_figure(_x, _y, 4, 14, 45, 0);
		
		_count++;
	}
}
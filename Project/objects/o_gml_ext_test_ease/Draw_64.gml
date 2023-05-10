/// @description 
var _count = 0;
var _val = abs(dsin(t));

if (inactive_t < 0) {
	t++;

	if (t mod 90 == 0) {
		inactive_t = room_speed * .05;
	}
}

inactive_t--;

for (var _xx = 0; _xx < 5; _xx++) {
	for (var _yy = 0; _yy < 6; _yy++) {
		var _ret_value = callbacks[_count](_val);
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
		draw_text(192 + _x - 8, 128 + _y - 32, script_get_name(callbacks[_count]));
		
		_color = merge_colour(c_gray, _color, .50);
		draw_set_color(_color);
		draw_set_alpha(.33 + _val * .16);
		draw_circle(96 + _x + (176 * _val), 80 + _y + (80 * (1 - _ret_value)), 6, false);
		
		
		_x = 128 + _x + (96 * _ret_value);
		_y = 128 + _y;
		_color = merge_colour(c_aqua, c_purple, _count / 30);
		draw_set_color(_color);
		
		draw_set_alpha(1);
		draw_figure(_x, _y, 4, 20, _val * 360 + 45, 3);
		
		_count++;
	}
}
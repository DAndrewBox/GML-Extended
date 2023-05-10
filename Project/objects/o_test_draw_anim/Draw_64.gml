/// @description 
var _count = 0;

for (var _xx = 0; _xx < 6; _xx++) {
	for (var _yy = 0; _yy < 5; _yy++) {
		draw_set_color(c_blue);
		draw_set_alpha(.16);
		draw_roundrect_ext(96 + _xx * 192, 64 + _yy * 128, 192 + 80 + (_xx * 192), 128 + 48 + (_yy * 128), 16, 16, false);
		
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text(192 + _xx * 192 - 8, 128 + _yy * 128 - 24, script_get_name(callbacks[_count]) + "\n" + abs(dsin(current_time / 10));

		
		var _color = merge_colour(c_teal, c_green, _count / 30);
		draw_set_color(_color);
		var _x = 96 + _xx * 192 + (80 * callbacks[_count](abs(dsin(current_time / 10))));
		var _y = 128 + _yy * 128;
		draw_circle(_x, _y, 20, false);
		_count++;
	}
}
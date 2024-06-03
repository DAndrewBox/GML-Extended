/// @description Draw lines surface
surf_lines = surface_create(room_width, room_height);

surface_set_target(surf_lines);
surface_clear(c_black, .0);

var _count = 0;
for (var _xx = 0; _xx < 5; _xx++) {
	for (var _yy = 0; _yy < 6; _yy++) {
		var _x = _yy * 192;
		var _y = _xx * 128;
		
		var _y_bot = 80 + _y + 80;
		var _y_top = 80 + _y;
		var _x_left = 96 + _x;
		var _x_right = 96 + _x + 176;
		
		draw_set_alpha(.75);
		draw_set_color(c_white);
		draw_line(_x_left, _y_top, _x_right, _y_top);
		draw_line(_x_left, _y_bot, _x_right, _y_bot);
		
		draw_set_alpha(1);
		var _color = merge_colour(c_navy, c_red, (_count div 3 / 10));
		_color = merge_colour(c_gray, _color, .50);
		draw_set_color(_color);
		var _total_lines = 10 * (_xx + 1);
		
		
		for (var _zz = 0; _zz < _total_lines; _zz ++) {
			var _x_start = 96 + _x + (176 * (_zz / _total_lines));
			var _y_start = 80 + _y + (80 * (1 - script_execute_ext(callbacks[_count], [_zz / _total_lines])));
			var _x_end = 96 + _x + (176 * ((_zz + 1) / _total_lines));
			var _y_end = 80 + _y + (80 * (1 - script_execute_ext(callbacks[_count], [(_zz + 1) / _total_lines])));
			draw_line_width(_x_start, _y_start, _x_end, _y_end, 2);
		}
		
		_count++;
	}
}

surface_reset_target();

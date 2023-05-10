/// @description 
draw_set_alpha(1);
draw_set_color(c_white);
t++;
var _count = 0;

for (var _xx = 0; _xx < 6; _xx++) {
	for (var _yy = 0; _yy < 5; _yy++) {
		var _x = 64 + _xx * 128 + callbacks[_count](t);
		var _y = 64 + _yy * 128;
		draw_circle(_x, _y, 20, false);
		_count++;
	}
}
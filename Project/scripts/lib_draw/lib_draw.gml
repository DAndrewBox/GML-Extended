///@func	draw_self_ext(sprite, index, x, y, xscale, yscale, rot, col, alpha)
///@param	{real}	sprite
///@param	{real}	index
///@param	{real}	x
///@param	{real}	y
///@param	{real}	rot
///@param	{real}	col
///@param	{real}	alpha
function draw_self_ext(_spr=sprite_index, _index=image_index, _x=x, _y=y, _xscale=image_xscale, _yscale=image_yscale, _rot=image_angle, _col=image_blend, _alpha=image_alpha) {
	draw_sprite_ext(_spr, _index, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
}

/// @func	draw_figure(x, y, sides, size, rotation, width)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{real}	sides
/// @param	{real}	size
/// @param	{real}	rotation
/// @param	{real}	width
function draw_figure(_x, _y, _sides, _size, _rot = 0, _width = 1) {
	for(var i = _rot; i<=360 + _rot; i += 360/_sides) {
		var _xFrom = _x + lengthdir_x(_size, i);
		var _yFrom = _y + lengthdir_y(_size, i);
		var _xTo = _x + lengthdir_x(_size, i + 360/_sides);
		var _yTo = _y + lengthdir_y(_size, i + 360/_sides);
		draw_line_width(_xFrom, _yFrom, _xTo, _yTo, _width);
	}
}

/// @func	draw_quad(cord_1, cord_2, cord_3, cord_4, color_init, color_final, alpha)
/// @param  {array}	cord_1
/// @param  {array}	cord_2
/// @param  {array}	cord_3
/// @param  {array}	cord_4
/// @param  {real}	color_init
/// @param  {real}	color_final
/// @param  {float}	alpha
/// @desc	Draws 2 triangles to simulate a quad
function draw_quad(_xy1, _xy2, _xy3, _xy4, _col_i, _col_f, _alpha) {
	draw_primitive_begin(pr_trianglelist);

	draw_vertex_color(_xy1[0], _xy1[1], _col_i, _alpha);
	draw_vertex_color(_xy2[0], _xy2[1], _col_i, _alpha);
	draw_vertex_color(_xy3[0], _xy3[1], _col_f, _alpha);
	
	draw_vertex_color(_xy2[0], _xy2[1], _col_i, _alpha);
	draw_vertex_color(_xy3[0], _xy3[1], _col_f, _alpha);
	draw_vertex_color(_xy4[0], _xy4[1], _col_f, _alpha);
	
	draw_primitive_end();
}

/// @func	draw_rectangle_width(x1, y1, x2, y2, width)
/// @param	{real}	x1
/// @param	{real}	y1
/// @param	{real}	x2
/// @param	{real}	y2
/// @param	{real}	width
function draw_rectangle_width(_x1, _y1, _x2, _y2, _w = 1) {	
	draw_line_width(_x1, _y1, _x2, _y1, _w);	// TOP
	draw_line_width(_x2, _y1, _x2, _y2, _w);	// RIGHT
	draw_line_width(_x1, _y2, _x2, _y2, _w);	// BOTTOM
	draw_line_width(_x1, _y1, _x1, _y2, _w);	// LEFT
}

/// @func	draw_rectangle_rotated(x, y, width, height, rot, outline)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{real}	width
/// @param	{real}	height
/// @param	{real}	rot
/// @param	{bool}	outline
function draw_rectangle_rotated(_x, _y, _w, _h, _rot, _outline = true) {
	var _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4;
	var _sxx = dcos(_rot);
	var _sxy = -dsin(_rot);
	var _syx = -dsin(_rot);
	var _syy = -dcos(_rot);

	_x1 = (_x - _sxx * _w - _syx * _h);
	_x2 = (_x + _sxx * _w - _syx * _h);
	_x3 = (_x + _sxx * _w + _syx * _h);
	_x4 = (_x - _sxx * _w + _syx * _h);

	_y1 = (_y - _sxy * _w - _syy * _h);
	_y2 = (_y + _sxy * _w - _syy * _h);
	_y3 = (_y + _sxy * _w + _syy * _h);
	_y4 = (_y - _sxy * _w + _syy * _h);

	draw_primitive_begin(( _outline ? pr_linestrip : pr_trianglestrip));
	
	draw_vertex(_x1, _y1);
	
	if (_outline) {
		draw_vertex(_x2, _y2);
		draw_vertex(_x3, _y3);
		draw_vertex(_x4, _y4);
		draw_vertex(_x1, _y1);
	} else {
		draw_vertex(_x2, _y2);
		draw_vertex(_x4, _y4);
		draw_vertex(_x3, _y3);
	}
	
	draw_primitive_end();
}

/// @func	draw_text_outline(x, y, string, outline_width, colour, outline_colour, xscale, yscale, angle)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{str}	string
/// @param	{real}	outline_width
/// @param	{str}	colour
/// @param	{str}	outline_colour
/// @param	{real}	xscale
/// @param	{real}	yscale
/// @param	{real}	angle
function draw_text_outline(_x, _y, _string, _width, _colour=c_white, _outline_colour=c_black, _xscale=1, _yscale=1, _angle=0) {
	draw_set_colour(_outline_colour);
	var i = -_width, j = -_width;
	while (i < _width || j < _width) {
		if (i == _width) {
			j++;
			i = -_width;
		}
		
		draw_text_transformed(_x + i, _y + j, _string, _xscale, _yscale, _angle);
		i++;
	}
	
	draw_set_colour(_colour);
	draw_text_transformed(_x, _y, _string, _xscale, _yscale, _angle);
}

/// @func	draw_text_shadow(x, y, string, shadow_xoff, shadow_yoff, text_colour, shadow_colour)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{str}	string
/// @param	{real}	shadow_xoff
/// @param	{real}	shadow_yoff
/// @param	{real}	shadow_height
/// @param	{real}	text_colour
/// @param	{real}	shadow_colour
/// @param	{real}	xscale
/// @param	{real}	yscale
/// @param	{real}	angle
function draw_text_shadow(_x, _y, _string, _shadow_xoff = 1, _shadow_yoff = 1, _text_col = c_white, _shadow_col = c_black, _xscale = 1, _yscale = 1, _angle = 0) {
	draw_set_colour(_shadow_col);
	draw_text_transformed(_x + _shadow_xoff, _y + _shadow_yoff, _string, _xscale, _yscale, _angle);

	draw_set_colour(_text_col);
	draw_text_transformed(_x, _y, _string, _xscale, _yscale, _angle);
}

/// @func	draw_text_size(x, y, string, size)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{str}	string
/// @param	{real}	size
/// @desc	Draws a text scaled by font size. Read documentation to make this work properly.
function draw_text_size(_x, _y, _string, _font_size) {
	var _scale = _font_size / font_get_size(draw_get_font());
	
	draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
}

/// @func draw_fps(x, y)
/// @param	{real}	x
/// @param	{real}	y
/// @desc	Draws game fps.
function draw_fps(_x, _y) {
	draw_text(_x, _y, string("{0}/{1} FPS", fps, game_get_speed(gamespeed_fps)));
}

/// @func draw_fps_real(x, y)
/// @param	{real}	x
/// @param	{real}	y
/// @desc	Draws game real fps.
function draw_fps_real(_x, _y) {
	draw_text(_x, _y, string("{0} RFPS", fps_real));
}

/// @func	draw_set_align(halign, valign)
/// @param	{real}	halign
/// @param	{real}	valign
function draw_set_align(_h, _v) {
	draw_set_halign(_h);
	draw_set_valign(_v);
}

/// @function	gpu_set_alpha_overwrite(flag)
/// @param	{bool}	flag
function gpu_set_alpha_overwrite(_flag) {
	gpu_set_colorwriteenable(true, true, true, _flag);
}
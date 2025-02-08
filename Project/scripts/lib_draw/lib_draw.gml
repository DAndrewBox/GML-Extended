#region // Definitions
#macro	current_draw_alpha	draw_get_alpha()
#macro	current_draw_color	draw_get_color()
#macro	current_draw_halign	draw_get_halign()
#macro	current_draw_valign	draw_get_valign()
#macro	current_draw_font	draw_get_font()
#endregion

///@func	draw_self_ext(sprite, index, x, y, xscale, yscale, rot, col, alpha)
///@param	{real}	sprite
///@param	{real}	index
///@param	{real}	x
///@param	{real}	y
///@param	{real}	xscale
///@param	{real}	yscale
///@param	{real}	rot
///@param	{real}	col
///@param	{real}	alpha
function draw_self_ext(_spr=sprite_index, _index=image_index, _x=x, _y=y, _xscale=image_xscale, _yscale=image_yscale, _rot=image_angle, _col=image_blend, _alpha=image_alpha) {
	draw_sprite_ext(_spr, _index, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
}

/// @func	draw_figure(x, y, sides, size, rotation, line_width)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{real}	sides
/// @param	{real}	size
/// @param	{real}	rotation
/// @param	{real}	line_width
function draw_figure(_x, _y, _sides, _size, _rot = 0, _width = 1) {
	draw_primitive_begin(_width > 0 ? pr_trianglestrip : pr_trianglefan);
	_sides = round(_sides);
	
	for(var i = _rot; i <= 360 + _rot; i += 360/_sides) {
		var _xOut = _x + lengthdir_x(_size, i);
		var _yOut = _y + lengthdir_y(_size, i);
		var _xIn  = _x + lengthdir_x(_size + _width, i);
		var _yIn  = _y + lengthdir_y(_size + _width, i);
		
		draw_vertex(_xOut, _yOut);
		draw_vertex(_xIn, _yIn);
	}
	draw_primitive_end();
}

/// @func	draw_quad(cord_1, cord_2, cord_3, cord_4, color_init, color_final, alpha)
/// @param  {array}	cord_1
/// @param  {array}	cord_2
/// @param  {array}	cord_3
/// @param  {array}	cord_4
/// @param  {real}	color_init
/// @param  {real}	color_final
/// @param  {real}	alpha
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
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex(_x1, _y1);
	draw_vertex(_x1 + _w, _y1 + _w);
	
	draw_vertex(_x2, _y1);
	draw_vertex(_x2 - _w, _y1 + _w);
	
	draw_vertex(_x2, _y2);
	draw_vertex(_x2 - _w, _y2 - _w);
	
	draw_vertex(_x1, _y2);
	draw_vertex(_x1 + _w, _y2 - _w);
	
	draw_vertex(_x1, _y1);
	draw_vertex(_x1 + _w, _y1 + _w);
	draw_primitive_end();
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
/// @param	{real}		x
/// @param	{real}		y
/// @param	{string}	string
/// @param	{real}		outline_width
/// @param	{real}		colour
/// @param	{real}		outline_colour
/// @param	{real}		xscale
/// @param	{real}		yscale
/// @param	{real}		angle
function draw_text_outline(_x, _y, _string, _width, _colour=c_white, _outline_colour=c_black, _xscale=1, _yscale=1, _angle=0) {
	draw_set_colour(_outline_colour);
	for (var i = -_width; i <= _width; i++) {
		for (var j = -_width; j <= _width; j++) {
			if (i == 0 && j == 0) continue;
			draw_text_transformed(_x + i, _y + j, _string, _xscale, _yscale, _angle);
		}
	}
	
	draw_set_colour(_colour);
	draw_text_transformed(_x, _y, _string, _xscale, _yscale, _angle);
}

/// @func	draw_text_shadow(x, y, string, shadow_xoff, shadow_yoff, text_colour, shadow_colour)
/// @param	{real}	x
/// @param	{real}	y
/// @param	{string}	string
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
/// @param	{string}	string
/// @param	{real}	size
/// @desc	Draws a text scaled by font size. Read documentation to make this work properly.
function draw_text_size(_x, _y, _string, _font_size) {
	var _font = draw_get_font();
	var _font_max_size = _font ? font_get_size(_font) : 16;
	var _scale = _font_size / _font_max_size;
	
	draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
}

/// @func draw_fps(x, y)
/// @param	{real}	x
/// @param	{real}	y
/// @desc	Draws game fps.
function draw_fps(_x, _y) {
	static _game_speed = game_get_speed(gamespeed_fps);
	draw_text(_x, _y, __gml_ext_comp_string_ext("{0}/{1} FPS", [fps, _game_speed]));
}

/// @func draw_fps_real(x, y)
/// @param	{real}	x
/// @param	{real}	y
/// @desc	Draws game real fps.
function draw_fps_real(_x, _y) {
	draw_text(_x, _y, __gml_ext_comp_string_ext("{0} RFPS", [fps_real]));
}

/// @func	draw_set_align(halign, valign)
/// @param	{real}	halign
/// @param	{real}	valign
function draw_set_align(_h, _v) {
	draw_set_halign(_h);
	draw_set_valign(_v);
}

/// @func	draw_surface_from_center(surface, x, y, xscale, yscale, rot, color, alpha)
/// @param	{Id.Surface}	surface
/// @param	{real}		x
/// @param	{real}		y
/// @param	{real}		xscale
/// @param	{real}		yscale
/// @param	{real}		rot
/// @param	{real}		color
/// @param	{real}		alpha
function draw_surface_from_center(_surf, _x, _y, _xscale = 1, _yscale = 1, _rot = 0, _col = -1, _alpha = draw_get_alpha()) {
	var _surf_w = surface_get_width(_surf) * _xscale;
	var _surf_h = surface_get_height(_surf) * _yscale;
	
	var _new_x = _x + lengthdir_x(-_surf_w / 2, _rot) - lengthdir_y(-_surf_h / 2, _rot);
	var _new_y = _y + lengthdir_y(-_surf_w / 2, _rot) + lengthdir_x(-_surf_h / 2, _rot);
	draw_surface_ext(_surf, _new_x, _new_y, _xscale, _yscale, _rot, _col, _alpha);
}

/// @func	draw_set_gui_scale(scale)
/// @param	{real}	scale
function draw_set_gui_scale(_scale) {
	display_set_gui_maximize(_scale, _scale);
}

/// @func	draw_set_blendmode(mode_src, mode_dest)
/// @param	{real}	mode
function draw_set_blendmode(_bm, _bm_ext = undefined) {
	if (is_undefined(_bm_ext)) {
		gpu_set_blendmode(_bm);
		return;
	}
	
	gpu_set_blendmode_ext(_bm, _bm_ext);
}

/// @func	draw_reset_blendmode()
function draw_reset_blendmode() {
	gpu_set_blendmode(bm_normal);
}

/// @func	gpu_set_alpha_overwrite(flag)
/// @param	{bool}	flag
function gpu_set_alpha_overwrite(_flag) {
	gpu_set_colorwriteenable(true, true, true, _flag);
}

/// @func	surface_clear(color, alpha)
/// @param	{real}	color
/// @param	{real}	alpha
function surface_clear(_col = c_black, _alpha = .0) {
	draw_clear_alpha(_col, _alpha);
}

/// @func	draw_set_depth(depth)
/// @param	{real}	depth
function draw_set_depth(_depth) {
	static _warn_msg = false;
	if (GM_VERSION_IS_2022 || GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 8) {
		if (!_warn_msg) {
			trace("(GML-Extended) WARN - On function \"draw_set_depth\". Not available before GM_VERSION 2023.8");
			_warn_msg = true;
		}
		return;
	}
	
	script_execute(gpu_set_depth, _depth);
}

/// @func	draw_reset_depth()
function draw_reset_depth() {
	static _warn_msg = false;
	if (GM_VERSION_IS_2022 || GM_VERSION_IS_2023 && GM_CURRENT_VERSION.minor < 8) {
		if (!_warn_msg) {
			trace("(GML-Extended) WARN - On function \"draw_reset_depth\". Not available before GM_VERSION 2023.8");
			_warn_msg = true;
		}
		return;
	}
	
	script_execute(gpu_set_depth, depth);
}

/// @func	draw_reset_alpha()
function draw_reset_alpha() {
	draw_set_alpha(1);
}

/// @func	draw_reset_color()
function draw_reset_color() {
	draw_set_color(c_white);
}

/// @func	draw_reset()
function draw_reset() {
	draw_reset_blendmode();
	draw_reset_depth();
	draw_reset_alpha();
	draw_reset_color();
	draw_set_align(fa_left, fa_top);
}

/// @func	draw_create_profile(profile_name, alpha, color, font, halign, valign, depth, blendmode)
/// @param	{string}	profile_name
/// @param	{real}	alpha
/// @param	{real}	color
/// @param	{real}	font
/// @param	{real}	halign
/// @param	{real}	valign
/// @param	{real}	depth
/// @param	{real|array}	blendmode
function draw_create_profile(_name, _alpha = undefined, _color = undefined, _font = undefined, _halign = undefined, _valign = undefined, _depth = undefined, _blendmode = undefined) {
	if (!variable_global_exists("__gml_ext_draw_profiles")) {
		variable_global_set("__gml_ext_draw_profiles", {});
	}
	
	if (!is_string(_name)) {
		static _error_msg = false;
		if (!_error_msg) {
			trace("(GML-Extended) ERROR! - On function draw_add_profile(). Name \"", _name, "\" is not a string.");
			_error_msg = true;
		}
		return;
	}
	
	global.__gml_ext_draw_profiles[$ _name] = {
		alpha:	_alpha,
		color:	_color,
		font:	_font,
		hAlign:	_halign,
		vAlign:	_valign,
		depth:	_depth,
		blendmode:	_blendmode
	}
}

/// @func	draw_set_profile(profile_name)
/// @param	{string}	profile_name
function draw_set_profile(_name) {
	if (!variable_global_exists("__gml_ext_draw_profiles")) {
		static _error_msg_1 = false;
		if (!_error_msg_1) {
			trace("(GML-Extended) ERROR! - On function draw_set_profile(). No profiles created, please use draw_create_profile() first.");
			_error_msg_1 = true;
		}
		return;
	}
	
	if (is_undefined(global.__gml_ext_draw_profiles[$ _name])) {
		static _error_msg_2 = false;
		if (!_error_msg_2) {
			trace("(GML-Extended) ERROR! - On function draw_set_profile(). Profile with name \"", _name, "\" does not exists.");
			_error_msg_2 = true;
		}
		return;
	}
	
	static _props = [
		"alpha",
		"color",
		"font",
		"hAlign",
		"vAlign",
		"depth",
		"blendmode",
	];
	static _props_callbacks = [
		draw_set_alpha,
		draw_set_color,
		draw_set_font,
		draw_set_halign,
		draw_set_valign,
		draw_set_depth,
		draw_set_blendmode,
	];
	static _props_size = get_size(_props);
	var _profile = global.__gml_ext_draw_profiles[$ _name];

	for (var i = 0; i < _props_size; i++) {
		var _value = _profile[$ _props[i]];
		if (!is_undefined(_value)) {
			script_execute_ext(_props_callbacks[i], is_array(_value) ? _value : [_value]);
		}
	}
}

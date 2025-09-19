#region // Definitions
#macro	current_draw_alpha	draw_get_alpha()
#macro	current_draw_color	draw_get_color()
#macro	current_draw_font	draw_get_font()
#macro	current_draw_halign	draw_get_halign()
#macro	current_draw_valign	draw_get_valign()
#endregion

///@func	draw_self_ext(sprite, index, x, y, xscale, yscale, rot, color, alpha)
///@param	{Asset.GMSprite}		sprite		Optional. The sprite to draw. (Default: sprite_index)
///@param	{Real}					index		Optional. The index of the sprite to draw (Default: image_index)
///@param	{Real}					x			Optional. The x position of the sprite (Default: instance.x)
///@param	{Real}					y			Optional. The y position of the sprite (Default: instance.y)
///@param	{Real}					xscale		Optional. The x scale of the sprite (Default: instance.image_xscale)
///@param	{Real}					yscale		Optional. The y scale of the sprite (Default: instance.image_yscale)
///@param	{Real}					rot			Optional. The rotation of the sprite (Default: instance.image_angle)
///@param	{Real|Constant.Color}	color		Optional. The color of the sprite (Default: instance.image_blend)
///@param	{Real}					alpha		Optional. The alpha of the sprite (Default: instance.image_alpha)
/// @desc	Draw the sprite of the object with the specified position, scale and rotation. This function is similar to the `draw_self` function, but it allows you to specify the position, scale and rotation of the sprite.
function draw_self_ext(_spr=sprite_index, _index=image_index, _x=x, _y=y, _xscale=image_xscale, _yscale=image_yscale, _rot=image_angle, _col=image_blend, _alpha=image_alpha) {
	draw_sprite_ext(_spr, _index, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
}

/// @func	draw_figure(x, y, sides, size, rotation, line_width)
/// @param	{Real}	x				The x position of the figure
/// @param	{Real}	y				The y position of the figure
/// @param	{Real}	sides			The number of sides of the figure
/// @param	{Real}	size			The size of the figure
/// @param	{Real}	rotation		Optional. The rotation of the figure (Default: 0)
/// @param	{Real}	line_width		Optional. The width of the figure (Default: 1)
/// @desc	Draw a figure of specified sides with the specified position, scale and rotation.
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
/// @param  {Array<Real>}	cord_1					The x and y position of the first point
/// @param  {Array<Real>}	cord_2					The x and y position of the second point
/// @param  {Array<Real>}	cord_3					The x and y position of the third point
/// @param  {Array<Real>}	cord_4					The x and y position of the fourth point
/// @param  {Real|Constant.Color}	color_init		The color in the top points of the quad 
/// @param  {Real|Constant.Color}	color_final		The color in the bottom points of the quad
/// @param  {Real}	alpha							The alpha of the quad 
/// @desc	Draw a quad on the screen using 4 points and a gradient color. The color_init and color_final arguments are the colors of the top and bottom points of the quad.
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
/// @param	{Real}	x1			The x position of the first point
/// @param	{Real}	y1			The y position of the first point
/// @param	{Real}	x2			The x position of the second point 
/// @param	{Real}	y2			The y position of the second point
/// @param	{Real}	width		Optional. The width of the line (Default: 1)
/// @desc	Draw a rectangle on the specified position with a line width specified by the user.
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
/// @param	{Real}	x			The x position of the rectangle
/// @param	{Real}	y			The y position of the rectangle
/// @param	{Real}	width		The width of the rectangle
/// @param	{Real}	height		The height of the rectangle 
/// @param	{Real}	rot			The rotation of the rectangle
/// @param	{Bool}	outline		Optional. If the rectangle should be filled or not (Default: true)
/// @desc	Draw a rectangle on the specified position with a rotation specified by the user. The rotation is in degrees. The rectangle is drawn from the center of the rectangle. The rectangle is drawn with a line width of 1 if the outline argument is true.
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

/// @func	draw_text_outline(x, y, text, outline_width, colour, outline_colour, xscale, yscale, angle)
/// @param	{Real}					x				The x position of the text
/// @param	{Real}					y				The y position of the text
/// @param	{String}				text			The text to be drawn
/// @param	{Real}					outline_width	The width of the outline
/// @param	{Real|Constant.Color}	colour			Optional. The color of the text (Default: c_white)
/// @param	{Real|Constant.Color}	outline_colour	Optional. The color of the outline (Default: c_black)
/// @param	{Real}					xscale			Optional. The x scale of the text (Default: 1)
/// @param	{Real}					yscale			Optional. The y scale of the text (Default: 1)
/// @param	{Real}					angle			Optional. The angle of the text (Default: 0)
/// @desc	Draw a text on the specified position with a outline specified by the user.
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

/// @func	draw_text_shadow(x, y, text, shadow_xoff, shadow_yoff, text_colour, shadow_colour)
/// @param	{Real}					x				The x position of the text
/// @param	{Real}					y				The y position of the text
/// @param	{String}				text			The text to be drawn
/// @param	{Real}					shadow_xoff		Optional. The x offset of the shadow (Default: 1)
/// @param	{Real}					shadow_yoff		Optional. The y offset of the shadow (Default: 1)
/// @param	{Real|Constant.Color}	text_colour		Optional. The color of the text (Default: c_white)
/// @param	{Real|Constant.Color}	shadow_colour	Optional. The color of the shadow (Default: c_black)
/// @param	{Real}					xscale			Optional. The x scale of the text (Default: 1)
/// @param	{Real}					yscale			Optional. The y scale of the text (Default: 1) 
/// @param	{Real}					angle			Optional. The angle of the text (Default: 0)
/// @desc	Draw a text on the specified position with a shadow specified. The shadow offset is defined in pixels.
function draw_text_shadow(_x, _y, _string, _shadow_xoff = 1, _shadow_yoff = 1, _text_col = c_white, _shadow_col = c_black, _xscale = 1, _yscale = 1, _angle = 0) {
	draw_set_colour(_shadow_col);
	draw_text_transformed(_x + _shadow_xoff, _y + _shadow_yoff, _string, _xscale, _yscale, _angle);

	draw_set_colour(_text_col);
	draw_text_transformed(_x, _y, _string, _xscale, _yscale, _angle);
}

/// @func	draw_text_size(x, y, text, size)
/// @param	{Real}		x		The x position of the text
/// @param	{Real}		y		The y position of the text
/// @param	{String}	text	The text to be drawn
/// @param	{Real}		size	The size of the font
/// @desc	Draws a text using a font size specified by the user. The font size is given in pixels by the last font defined by the user in the draw event. Is recommended to create a font with the "No Scale" option enabled on "Glyph Options" so the font will not be pixelated. [Dev Note: I recommend to set it up to a pixel size of 32 in the editor. Read documentation to make this work properly.]
function draw_text_size(_x, _y, _string, _font_size) {
	var _font = draw_get_font();
	var _font_max_size = _font ? font_get_size(_font) : 16;
	var _scale = _font_size / _font_max_size;
	
	draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
}

/// @func draw_fps(x, y)
/// @param	{Real}	x	The x position of the text
/// @param	{Real}	y	The y position of the text
/// @desc	Draws the current fps on the specified position. The fps is calculated automatically by the engine.
function draw_fps(_x, _y) {
	static _game_speed = game_get_speed(gamespeed_fps);
	draw_text(_x, _y, __gml_ext_comp_string_ext("{0}/{1} FPS", [fps, _game_speed]));
}

/// @func draw_fps_real(x, y)
/// @param	{Real}	x	The x position of the text
/// @param	{Real}	y	The y position of the text
/// @desc	Draws the current fps_real on the specified position. The fps_real is calculated automatically by the engine. The fps_real is the real fps of the game, it is not affected by the fps cap.
function draw_fps_real(_x, _y) {
	draw_text(_x, _y, __gml_ext_comp_string_ext("{0} RFPS", [fps_real]));
}

/// @func	draw_set_align(halign, valign)
/// @param	{Constant.HAlign}	halign		The horizontal alignment of the text
/// @param	{Constant.VAlign}	valign		The vertical alignment of the text
/// @desc	A 1-liner to set the alignment of the text to be drawn.
function draw_set_align(_h, _v) {
	draw_set_halign(_h);
	draw_set_valign(_v);
}

/// @func	draw_surface_from_center(surface, x, y, xscale, yscale, rot, color, alpha)
/// @param	{Id.Surface}			surface		The surface to be drawn
/// @param	{Real}					x			The x position of the surface
/// @param	{Real}					y			The y position of the surface
/// @param	{Real}					xscale		Optional. The x scale of the surface (Default: 1)
/// @param	{Real}					yscale		Optional. The y scale of the surface (Default: 1)
/// @param	{Real}					rot			Optional. The rotation of the surface (Default: 0)
/// @param	{Real|Constant.Color}	color		Optional. The color of the surface (Default: c_white)
/// @param	{Real}					alpha		Optional. The alpha of the surface (Default: 1)
/// @desc	Draws a surface on the specified position from the center of the surface. The surface is drawn with the specified scale, rotation, color and alpha.
function draw_surface_from_center(_surf, _x, _y, _xscale = 1, _yscale = 1, _rot = 0, _col = -1, _alpha = draw_get_alpha()) {
	var _surf_w = surface_get_width(_surf) * _xscale;
	var _surf_h = surface_get_height(_surf) * _yscale;
	
	var _new_x = _x + lengthdir_x(-_surf_w / 2, _rot) - lengthdir_y(-_surf_h / 2, _rot);
	var _new_y = _y + lengthdir_y(-_surf_w / 2, _rot) + lengthdir_x(-_surf_h / 2, _rot);
	draw_surface_ext(_surf, _new_x, _new_y, _xscale, _yscale, _rot, _col, _alpha);
}

/// @func	draw_set_gui_scale(scale)
/// @param	{Real}	scale	The scale of the GUI
/// @desc	Sets the GUI scale of the game. The GUI scale is used to scale the GUI elements of the game. The GUI scale is a multiplier that is applied to the GUI elements of the game. After setting the GUI scale, all the GUI elements of the game will be scaled by the specified scale. You should reset the GUI scale after drawing the GUI elements to avoid scaling other elements of the game.
function draw_set_gui_scale(_scale) {
	display_set_gui_maximize(_scale, _scale);
}

/// @func	draw_set_blendmode(mode_src, mode_dest)
/// @param	{Constant.BlendMode|Constant.BlendModeFactor}	mode_src	The source blend mode
/// @param	{Constant.BlendModeFactor}						mode_dest	Optional. The destination blend mode
/// @desc	Sets the blend mode of the game. Is a replacement for the `gpu_set_blendmode` and `gpu_set_blendmode_ext` functions.
function draw_set_blendmode(_bm, _bm_ext = undefined) {
	if (is_undefined(_bm_ext)) {
		gpu_set_blendmode(_bm);
		return;
	}
	
	gpu_set_blendmode_ext(_bm, _bm_ext);
}

/// @func	draw_reset_blendmode()
/// @desc	Resets the blend mode of the game. Is a replacement for the `gpu_set_blendmode(bm_normal)` function.
function draw_reset_blendmode() {
	gpu_set_blendmode(bm_normal);
}

/// @func	gpu_set_alpha_overwrite(flag)
/// @param	{Bool}	flag	The flag to be set.
/// @desc	Sets the alpha overwrite flag. If the flag is set to true, the alpha channel of the color will be ignored and the alpha channel of the texture will be used instead. If the flag is set to false, the alpha channel of the color will be used instead.
function gpu_set_alpha_overwrite(_flag) {
	gpu_set_colorwriteenable(true, true, true, _flag);
}

/// @func	surface_clear(color, alpha)
/// @param	{Real|Constant.Color}	color	The color of the surface
/// @param	{Real}					alpha	Optional. The alpha of the surface
/// @desc	Clears the surface with the specified color and alpha. It's a replacement for the draw_clear and draw_clear_alpha function.
function surface_clear(_col = c_black, _alpha = .0) {
	draw_clear_alpha(_col, _alpha);
}

/// @func	draw_set_depth(depth)
/// @param	{Real}	depth	The depth of the drawing
/// @desc	[WARNING - This function will only work on GameMaker versions 2023.8+. Version before this will not work and will show a message in console instead.] Sets the depth of the drawing. The depth is used to determine the order in which the objects are drawn. The objects with a higher depth are drawn on top of the objects with a lower depth.
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
/// @desc	[WARNING - This function will only work on GameMaker versions 2023.8+. Version before this will not work and will show a message in console instead.] Resets the depth of the drawing. The depth is used to determine the order in which the objects are drawn. The objects with a higher depth are drawn on top of the objects with a lower depth.
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
/// @desc	Resets the alpha of the drawing. Sets the alpha of the drawing to 1.
function draw_reset_alpha() {
	draw_set_alpha(1);
}

/// @func	draw_reset_color()
///	@desc	Resets the color of the drawing. Sets the color of the drawing to `c_white`.
function draw_reset_color() {
	draw_set_color(c_white);
}

/// @func	draw_reset()
///	@desc	Resets the drawing settings. Sets the alpha of the drawing to 1, the color of the drawing to `c_white`, the horizontal alignment of the text to `fa_left`, the vertical alignment of the text to `fa_top` and the blend mode of the drawing to `bm_normal`.
function draw_reset() {
	draw_reset_blendmode();
	draw_reset_depth();
	draw_reset_alpha();
	draw_reset_color();
	draw_set_align(fa_left, fa_top);
}

/// @func	draw_create_profile(profile_name, alpha, color, font, halign, valign, depth, blendmode)
/// @param	{String}												profile_name	The name of the profile
/// @param	{Real}													alpha			The alpha of the profile
/// @param	{Real|Constant.Color}									color			The color of the profile
/// @param	{Asset.GMFont}											font			The font of the profile
/// @param	{Constant.HAlign}										halign			The horizontal alignment of the text
/// @param	{Constant.VAlign}										valign			The vertical alignment of the text
/// @param	{Real}													depth			The depth of the profile
/// @param	{Constant.BlendMode|Array<Constant.BlendModeFactor>}	blendmode		The blend mode of the profile
/// @desc	Creates a new profile for the drawing functions. The profile is used to store the drawing settings and can be used to switch between different drawing settings.
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
	
	global.__gml_ext.draw_profiles[$ _name] = {
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
/// @param	{String}	profile_name	The name of the profile to set
/// @desc	Sets the profile for the drawing functions. The profile is used to store the drawing settings and can be used to switch between different drawing settings.
function draw_set_profile(_name) {
	if (!variable_global_exists("__gml_ext_draw_profiles")) {
		static _error_msg_1 = false;
		if (!_error_msg_1) {
			trace("(GML-Extended) ERROR! - On function draw_set_profile(). No profiles created, please use draw_create_profile() first.");
			_error_msg_1 = true;
		}
		return;
	}
	
	if (is_undefined(global.__gml_ext.draw_profiles[$ _name])) {
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
	var _profile = global.__gml_ext.draw_profiles[$ _name];

	for (var i = 0; i < _props_size; i++) {
		var _value = _profile[$ _props[i]];
		if (!is_undefined(_value)) {
			script_execute_ext(_props_callbacks[i], is_array(_value) ? _value : [_value]);
		}
	}
}

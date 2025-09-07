///	@func	shader_set_ext(shader, params)
/// @param	{Asset.GMShader}	shader
/// @param	{Struct}			params
/// @desc	Setup a shader with uniform params
function shader_set_ext(_shader, _params) {	
	var _keys = struct_keys(_params);
	var _shd_callbacks = {
		u_float:	[shader_set_uniform_f, shader_set_uniform_f_array],
		u_int:		[shader_set_uniform_i, shader_set_uniform_i_array],
		u_texture:	shader_get_sampler_index,
	};
	
	shader_set(_shader);
	var _keys_len = array_length(_keys);
	for (var i = 0; i < _keys_len; i++) {
		var _key = _keys[i];
		var _uniforms = _params[$ _key];
		var _u_names = struct_keys(_uniforms);

		var _u_len = array_length(_u_names);
		for (var j = 0; j < _u_len; j++) {
			var _shd_u = undefined;
			var _value = _uniforms[$ _u_names[j]];
			
			if (_key == "u_texture") {
				_shd_u = _shd_callbacks[$ _key](_shader, _uniforms[i]);
				texture_set_stage(_shd_u, _value);
				continue;
			}
			_shd_u = shader_get_uniform(_shader, _u_names[j]);
			_shd_callbacks[$ _key][is_array(_value)](_shd_u, _value);
		}
	}
	
	delete _params;
}


/// @func	draw_sprite_recolor(sprite, index, x, y, color, blend, xscale, yscale, rot, alpha)
///@param	{Asset.GMSprite}		sprite
/// @param	{Real}					index
/// @param	{Real}					x
/// @param	{Real}					y
/// @param	{Real|Constant.Color}	color
/// @param	{Real}					blend
/// @param	{Real}					xscale
/// @param	{Real}					yscale
/// @param	{Real}					rot
/// @param	{Real}					alpha
function draw_sprite_recolor(_spr, _index, _x, _y, _color, _blend, _xscale = image_xscale, _yscale = image_yscale, _rot = 0, _alpha = 1) {
	var _color_normalized = [
		color_get_red(_color) / 255,
		color_get_green(_color) / 255,
		color_get_blue(_color) / 255
	];
	shader_set_ext(shd_gml_ext_recolor, {
		u_float: {
			u_color: _color_normalized,
			u_blend: _blend
		}
	});
	draw_sprite_ext(_spr, _index, _x, _y, _xscale, _yscale, _rot, -1, _alpha);
	shader_reset();
}

/// @func	draw_sprite_blur(sprite, index, x, y, blur_amount, xscale, yscale, rot, col, alpha)
///@param	{Asset.GMSprite}		sprite
/// @param	{Real}					index
/// @param	{Real}					x
/// @param	{Real}					y
/// @param	{Real}					blur_amount
/// @param	{Real}					xscale
/// @param	{Real}					yscale
/// @param	{Real}					rot
/// @param	{Real|Constant.Color}	color
/// @param	{Real}					alpha
function draw_sprite_blur(_spr, _index, _x, _y, _amount, _xscale = 1, _yscale = 1, _rot = 0, _col = -1, _alpha = 1) {
	var _w, _h;
	_w = sprite_get_width(_spr);
	_h = sprite_get_height(_spr);
	shader_set_ext(shd_gml_ext_blur_gauss, {
		u_float: {
			size: [_w, _h, 25 * _amount],
		}
	});
	draw_sprite_ext(_spr, _index, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
	shader_reset();
}

/// @func	draw_surface_blur(surf, blur_amount, x, y, xscale, yscale, rot, col, alpha)
/// @param	{Real}	surf
/// @param	{Real}	blur_amount
/// @param	{Real}	x
/// @param	{Real}	y
/// @param	{Real}	xscale
/// @param	{Real}	yscale
/// @param	{Real}	rot
/// @param	{Real|Constant.Color}	color
/// @param	{Real}	alpha
function draw_surface_blur(_surf, _amount, _x, _y, _xscale = 1, _yscale = 1, _rot = 0, _col = -1, _alpha = 1) {
	if !(surface_exists(_surf)) return;
	
	var _w, _h;
	_w = surface_get_width(_surf);
	_h = surface_get_height(_surf);
	shader_set_ext(shd_gml_ext_blur_gauss, {
		u_float: {
			size: [_w, _h, 25 * _amount],
		}
	});
	draw_surface_ext(_surf, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
	shader_reset();
}

/// @func	draw_surface_recolor(surf, color, blend, x, y, xscale, yscale, rot, col, alpha)
/// @param	{Real}					surf
/// @param	{Real|Constant.Color}	color
/// @param	{Real}					blend
/// @param	{Real}					x
/// @param	{Real}					y
/// @param	{Real}					xscale
/// @param	{Real}					yscale
/// @param	{Real}					rot
/// @param	{Real|Constant.Color}	color
/// @param	{Real}					alpha
function draw_surface_recolor(_surf, _color, _blend, _x, _y, _xscale = 1, _yscale = 1, _rot = 0, _col = -1, _alpha = 1) {
	if !(surface_exists(_surf)) return;

	var _color_normalized = [
		color_get_red(_color) / 255,
		color_get_green(_color) / 255,
		color_get_blue(_color) / 255
	];
	shader_set_ext(shd_gml_ext_recolor, {
		u_float: {
			u_color: _color_normalized,
			u_blend: _blend
		}
	});
	draw_surface_ext(_surf, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
	shader_reset();
}
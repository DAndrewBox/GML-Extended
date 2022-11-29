///	@func	shader_set_ext(params)
/// @param	{any}	params
/// @desc	Setup a shader with uniform params
function shader_set_ext(_shader, _params) {	
	var _keys = struct_keys(_params);
	var _shd_callbacks = {
		u_float:	[shader_set_uniform_f, shader_set_uniform_f_array],
		u_int:		[shader_set_uniform_i, shader_set_uniform_i_array],
		u_texture:	shader_get_sampler_index,
	};
	
	shader_set(_shader);
	
	for (var i = 0; i = array_length(_keys); i++) {
		var _key = _keys[i];
		var _uniforms = _params[$ _key];
		var _u_names = struct_keys(_uniforms);
		
		for (var j = 0; j < array_length(_u_names); j++) {
			var _shd_u;
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
}
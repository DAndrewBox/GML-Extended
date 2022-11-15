/// @func	struct_keys(struct)
/// @param	{any}	struct
/// @desc	Return an array with all keys from a struct.
function struct_keys(_struct) {
	return variable_struct_get_names(_struct);
}

/// @func	struct_merge(struct1, struct2, override)
/// @param	{any}	struct1
/// @param	{any}	struct2
/// @param	{bool}	override
/// @desc	Return a merged struct from 2 different structs.
function struct_merge(_st_1, _st_2, _override=true) {
	var _new_struct = _st_1;
	var _new_keys = variable_struct_get_names(_st_2);
	
	for (var i = 0; i < array_length(_new_keys); i++) {
		var _key_exists = (variable_struct_get(_new_struct, _new_keys[i]) == undefined);
		if (_key_exists && !_override) continue;

		_new_struct[$ _new_keys[i]] = _st_2[$ _new_keys[i]];
	}
	
	return _new_struct;
}
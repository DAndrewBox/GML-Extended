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
function struct_merge(_st_1, _st_2, _override = true) {
	var _new_struct = _st_1;
	var _new_keys = variable_struct_get_names(_st_2);
	
	for (var i = 0; i < array_length(_new_keys); i++) {
		var _key_exists = is_undefined(variable_struct_get(_new_struct, _new_keys[i]));
		if (_key_exists && !_override) continue;

		_new_struct[$ _new_keys[i]] = _st_2[$ _new_keys[i]];
	}
	
	return _new_struct;
}

/// @func	struct_key_exists(struct, key)
/// @param	{any}	struct
/// @param	{str}	key
/// @desc	Return an array with all keys from a struct.
function struct_key_exists(_struct, _key) {
	return array_contains(struct_keys(_struct), _key);
}

/// @func	struct_equal(struct1, struct2)
/// @param	{any}	struct1
/// @param	{any}	struct2
function struct_equal(_struct_1, _struct_2) {
	// Check if all keys are in struct1 & struct2
	var _struct_keys = struct_keys(_struct_1);
	
	if (get_size(_struct_1) != get_size(_struct_2)) return false;
	for (var i = 0; i < get_size(_struct_keys); i++) {
		var _key = _struct_keys[i];
		if (is_undefined(_struct_2[$ _key])) return false;
		if (_struct_1[$ _key] != _struct_2[$ _key]) return false;
	}
	
	return true;
}

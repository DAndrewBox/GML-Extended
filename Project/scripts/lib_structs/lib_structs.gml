/// @func	struct_keys(struct)
/// @param	{Struct}	struct	The struct to get the keys.
/// @desc	Returns an array with the keys of a struct. Same behavior as `variable_struct_get_names`.
function struct_keys(_struct) {
	return variable_struct_get_names(_struct);
}

/// @func	struct_merge(struct1, struct2, [override])
/// @param	{Struct}	struct1		The first struct to merge
/// @param	{Struct}	struct2		The second struct to merge
/// @param	{Bool}		override	Override the values of the first struct with the second struct (Default: true)
/// @desc	Return a merged struct from 2 different structs. If the key exists in both structs, the value of the second struct will be used by default (unless the `override` argument is set to `false`).
///	@return	{Struct}
function struct_merge(_st_1, _st_2, _override = true) {
	var _new_struct = _st_1;
	var _new_keys = variable_struct_get_names(_st_2);
	var _len_keys = array_length(_new_keys);
	var _key, _key_exists;
	
	for (var i = 0; i < _len_keys; i++) {
		_key = _new_keys[i];
		_key_exists = !is_undefined(variable_struct_get(_new_struct, _key));
		if (_key_exists && !_override) continue;

		if (!is_struct(_new_struct[$ _key])) {
			_new_struct[$ _key] = _st_2[$ _key];
		} else {
			_new_struct[$ _key] = struct_merge(_new_struct[$ _key], _st_2[$ _key], _override);
		}
	}
	
	return _new_struct;
}

/// @func	struct_key_exists(struct, key)
/// @param	{Struct}	struct		The struct to get the keys.
/// @param	{String}	key			The key to check.
/// @desc	Returns `true` if the key exists in the struct, `false` otherwise.
///	@return	{Bool}
function struct_key_exists(_struct, _key) {
	return __gml_ext_comp_array_contains(struct_keys(_struct), _key);
}

/// @func	struct_equal(struct1, struct2)
/// @param	{Struct}	struct1		The first struct to check
/// @param	{Struct}	struct2		The second struct to check
/// @desc	Compare two structs and returns a boolean to check if the structs are equal.
function struct_equal(_struct_1, _struct_2) {
	// Check if all keys are in struct1 & struct2
	var _struct_keys = struct_keys(_struct_1);
	var _struct_len = get_size(_struct_keys);
	
	if (get_size(_struct_1) != get_size(_struct_2)) return false;
	for (var i = 0; i < _struct_len; i++) {
		var _key = _struct_keys[i];
		if (is_undefined(_struct_2[$ _key])) return false;
		if (_struct_1[$ _key] != _struct_2[$ _key]) return false;
	}
	
	return true;
}

/// @func	struct_entries(struct)
/// @param	{Struct}	struct		The struct to get the entries
/// @desc	Returns an array with the entries of a struct. Each entry is an array with 2 elements: the key and the value.
///	@return	{Array<Array<Any>>}
function struct_entries(_struct) {
	var _struct_keys = struct_keys(_struct);
	var _struct_len = get_size(_struct_keys);
	var _array = [];
	
	for (var i = 0; i < _struct_len; i++) {
		var _key = _struct_keys[i];
		var _value = _struct[$ _key];
		if (is_undefined(_value)) continue;
		array_push(_array, [_key, _value]);
	}
	
	return _array;
}
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
/// @desc	Return a merged struct from 2 different structs. If the key exists in both structs, the value of the second struct will be used by default (unless the `override` argument is set to `false`). Nested structs are merged key by key and nested arrays are merged index by index, so an array of structs keeps the keys of both sides. The result never shares a reference with either source struct.
///	@return	{Struct}
function struct_merge(_st_1, _st_2, _override = true) {
	var _new_struct = __gml_ext_comp_variable_clone(_st_1);
	var _new_keys = variable_struct_get_names(_st_2);
	var _len_keys = array_length(_new_keys);
	var _key, _key_exists;
	
	for (var i = 0; i < _len_keys; i++) {
		_key = _new_keys[i];
		_key_exists = variable_struct_exists(_new_struct, _key);
		if (_key_exists && !_override) continue;
		
		_new_struct[$ _key] = _key_exists
			? __gml_ext_internal_merge_values(_new_struct[$ _key], _st_2[$ _key])
			: __gml_ext_comp_variable_clone(_st_2[$ _key]);
	}
	
	return _new_struct;
}

/// @func	__gml_ext_internal_merge_values(value1, value2)
/// @param	{Any}	value1		The value already stored in the merged struct.
/// @param	{Any}	value2		The value coming from the second struct.
/// @desc	Merges the two values of a shared key, walking into nested structs and arrays.
/// @ignore
function __gml_ext_internal_merge_values(_val_1, _val_2) {
	// Only walk into a value when both sides share the same container type.
	if (is_struct(_val_1) && is_struct(_val_2)) {
		return struct_merge(_val_1, _val_2);
	}
	
	if (is_array(_val_1) && is_array(_val_2)) {
		return __gml_ext_internal_merge_arrays(_val_1, _val_2);
	}
	
	return __gml_ext_comp_variable_clone(_val_2);
}

/// @func	__gml_ext_internal_merge_arrays(array1, array2)
/// @param	{Array}	array1		The array already stored in the merged struct.
/// @param	{Array}	array2		The array coming from the second struct.
/// @desc	Merges two arrays index by index, merging the structs found on the same index.
/// @ignore
function __gml_ext_internal_merge_arrays(_arr_1, _arr_2) {
	var _new_array = __gml_ext_comp_variable_clone(_arr_1);
	var _len_1 = array_length(_arr_1);
	var _len_2 = array_length(_arr_2);
	
	for (var i = 0; i < _len_2; i++) {
		// Anything past the end of the first array is simply appended.
		if (i >= _len_1) {
			array_push(_new_array, __gml_ext_comp_variable_clone(_arr_2[i]));
			continue;
		}
		
		_new_array[i] = __gml_ext_internal_merge_values(_new_array[i], _arr_2[i]);
	}
	
	return _new_array;
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
	if (!is_struct(_struct_1) || !is_struct(_struct_2)) return false;
	
	// Check if all keys are in struct1 & struct2
	var _struct_keys = struct_keys(_struct_1);
	var _struct_len = get_size(_struct_keys);
	
	if (get_size(_struct_1) != get_size(_struct_2)) return false;
	for (var i = 0; i < _struct_len; i++) {
		var _key = _struct_keys[i];
		if (!struct_key_exists(_struct_2, _key)) return false;
		
		var _val_1 = _struct_1[$ _key];
		var _val_2 = _struct_2[$ _key];
		
		// Structs and arrays compare by reference, so they have to be walked instead.
		if (is_struct(_val_1) || is_struct(_val_2)) {
			if (!struct_equal(_val_1, _val_2)) return false;
			continue;
		}
		
		if (is_array(_val_1) || is_array(_val_2)) {
			if (!is_array(_val_1) || !is_array(_val_2)) return false;
			if (!array_equals(_val_1, _val_2)) return false;
			continue;
		}
		
		if (_val_1 != _val_2) return false;
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

/// @func	struct_filter(struct, callback)
/// @param	{Struct}					struct		The struct to filter.
/// @param	{Function|Asset.GMScript}	callback	Receives the key and the value, and returns whether to keep the entry.
/// @desc	Returns a new struct holding only the entries the callback returned `true` for. The original struct is left untouched.
///	@return	{Struct}
function struct_filter(_struct, _callback) {
	var _keys = struct_keys(_struct);
	var _len = array_length(_keys);
	var _out = {};

	for (var i = 0; i < _len; i++) {
		var _key = _keys[i];
		if (!_callback(_key, _struct[$ _key])) continue;

		_out[$ _key] = _struct[$ _key];
	}

	return _out;
}

/// @func	struct_map(struct, callback)
/// @param	{Struct}					struct		The struct to map.
/// @param	{Function|Asset.GMScript}	callback	Receives the key and the value, and returns the new value.
/// @desc	Returns a new struct with the same keys, where every value is the result of the callback. The original struct is left untouched.
///	@return	{Struct}
function struct_map(_struct, _callback) {
	var _keys = struct_keys(_struct);
	var _len = array_length(_keys);
	var _out = {};

	for (var i = 0; i < _len; i++) {
		var _key = _keys[i];
		_out[$ _key] = _callback(_key, _struct[$ _key]);
	}

	return _out;
}

/// @func	struct_reduce(struct, callback, [initial])
/// @param	{Struct}					struct		The struct to reduce.
/// @param	{Function|Asset.GMScript}	callback	Receives the accumulator, the key and the value, and returns the new accumulator.
/// @param	{Any}						initial		Optional. The value the accumulator starts with. (Default: undefined)
/// @desc	Runs the callback over every entry of the struct carrying an accumulator, and returns the final accumulator. Key order is not guaranteed, so the callback should not depend on it.
///	@return	{Any}
function struct_reduce(_struct, _callback, _initial = undefined) {
	var _keys = struct_keys(_struct);
	var _len = array_length(_keys);
	var _acc = _initial;

	for (var i = 0; i < _len; i++) {
		var _key = _keys[i];
		_acc = _callback(_acc, _key, _struct[$ _key]);
	}

	return _acc;
}

/// @func	struct_get_path(struct, path, [default])
/// @param	{Struct}	struct		The struct to read from.
/// @param	{String}	path		The dot separated path to the value, e.g. "player.stats.hp".
/// @param	{Any}		default		Optional. The value returned when the path does not exist. (Default: undefined)
/// @desc	Reads a nested value without having to check every level first. A numeric step walks into an array, so "items.0.name" is a valid path. Returns the default value as soon as any step of the path is missing.
///	@return	{Any}
function struct_get_path(_struct, _path, _default = undefined) {
	var _keys = __gml_ext_comp_string_split(_path, ".");
	var _len = array_length(_keys);
	var _current = _struct;

	for (var i = 0; i < _len; i++) {
		var _key = _keys[i];

		// A numeric step walks into an array instead of a struct.
		if (is_array(_current)) {
			if (_key == "" || string_digits(_key) != _key) return _default;

			var _index = real(_key);
			if (_index >= array_length(_current)) return _default;

			_current = _current[_index];
			continue;
		}

		if (!is_struct(_current)) return _default;
		if (!variable_struct_exists(_current, _key)) return _default;

		_current = _current[$ _key];
	}

	return _current;
}

/// @func	struct_flatten(struct, [separator])
/// @param	{Struct}	struct		The struct to flatten.
/// @param	{String}	separator	Optional. The text joining the keys of every level. (Default: ".")
/// @desc	Returns a single level struct where every nested key becomes a path, so `{a: {b: 1}}` becomes `{"a.b": 1}`. Arrays are kept as a single value, and an empty struct is kept as a value too.
///	@return	{Struct}
function struct_flatten(_struct, _separator = ".") {
	var _out = {};
	__gml_ext_internal_struct_flatten(_struct, "", _separator, _out);

	return _out;
}

/// @func	__gml_ext_internal_struct_flatten(struct, prefix, separator, out)
/// @param	{Struct}	struct		The struct being walked.
/// @param	{String}	prefix		The path built so far.
/// @param	{String}	separator	The text joining the keys of every level.
/// @param	{Struct}	out			The struct collecting the flattened entries.
/// @desc	Walks a struct writing every leaf into `out` under its full path.
/// @ignore
function __gml_ext_internal_struct_flatten(_struct, _prefix, _separator, _out) {
	var _keys = struct_keys(_struct);
	var _len = array_length(_keys);

	for (var i = 0; i < _len; i++) {
		var _key = _keys[i];
		var _value = _struct[$ _key];
		var _path = (_prefix == "") ? _key : _prefix + _separator + _key;

		// Only structs with entries are walked, everything else is a leaf.
		if (is_struct(_value) && get_size(_value) > 0) {
			__gml_ext_internal_struct_flatten(_value, _path, _separator, _out);
			continue;
		}

		_out[$ _path] = _value;
	}
}
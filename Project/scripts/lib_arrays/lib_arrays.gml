#region Definitions
#macro	sort_ascending		function (a,b) {return a - b}
#macro	sort_descending		function (a,b) {return b - a}
#macro	sort_elem_size_asc	function (a,b) {return get_size(a) - get_size(b)}
#macro	sort_elem_size_desc	function (a,b) {return get_size(b) - get_size(a)}
#endregion

///	@func	array_fill(array, value)
/// @param	{Array}	array	The array to fill.
/// @param	{Any}	value	The value to fill the array with.
/// @desc	Fills an array with a value.
///	@return	{Undefined}
function array_fill(_array, _val) {
	var _arr_len = array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		_array[@ i] = _val;
	}
}

///	@func	array_clear(array)
/// @param	{Array}	array	The reference array to clear.
/// @desc	Clears an array filling with undefined values to clear memory.
///	@return	{Undefined}
function array_clear(_array) {
	array_delete(_array, 0, array_length(_array));
}

///	@func	array_empty(array)
/// @param	{Array}	array	The array to check
/// @desc	Checks if an array is empty. Returns a boolean.
///	@return	{Bool}
function array_empty(_array) {
	return (array_length(_array) == 0);
}

///	@func	array_find_index_by_value(array, value)
/// @param	{Array}	array	The array to search into.
/// @param	{Any}	value	The value to find.
/// @desc	Checks if a value is inside the array, and then returns its index, else, returns -1.
///	@return	{Real}
function array_find_index_by_value(_array, _val) {
	var _arr_len =  array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		if (_array[@ i] == _val) {
			return i;
		}
	}
	
	return -1;
}

///	@func array_to_ds_list(array)
/// @param	{Array}	array	The array to convert.
/// @desc	Returns the array as a ds list with all its values.
///	@return	{Id.DsList<Any*>}
function array_to_ds_list(_array) {
	var _new_ds_list = ds_list_create();
	var _arr_len = array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		_new_ds_list[| i] = _array[i];
	}
	
	return _new_ds_list;
}

///	@func ds_list_to_array(ds_list)
/// @param	{Id.DsList}	ds_list		The ds_list to convert into array.
/// @desc	Converts a ds list to an array with all its values and the returns it.
///	@return	{Array<Any*>}
function ds_list_to_array(_list) {
	var _ds_list_size = ds_list_size(_list);
	var _new_array = array_create(_ds_list_size);
	
	for (var i = 0; i < _ds_list_size; i++) {
		_new_array[i] = _list[| i];
	}
	
	return _new_array;
}

///	@func array_to_struct(array)
/// @param	{Array}	array	The array to convert
/// @desc	Returns the array as a struct with all its values inside numeric keys. 2D arrays will be converted to structs with arrays inside and not to a 2D struct.
///	@return	{Struct}
function array_to_struct(_array) {
	var _new_struct = {};
	var _arr_len = array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		variable_struct_set(_new_struct, i, _array[i]);
	}
	
	return _new_struct;
}

/// @func	array_chunk(array, size)
/// @param	{Array}	array	The array to split.
/// @param	{Real}	size	The maximum number of elements of every chunk.
/// @desc	Returns an array of arrays, each one holding at most `size` elements of the original array. The last chunk holds the remainder.
///	@return	{Array<Array>}
function array_chunk(_array, _size) {
	var _chunks = [];
	_size = floor(_size);

	if (_size < 1) {
		trace("[GML-Extended] - ERROR! On function \"array_chunk()\". \"size\" must be greater than 0.");
		return _chunks;
	}

	var _len = array_length(_array);
	var _chunk = [];

	for (var i = 0; i < _len; i++) {
		array_push(_chunk, _array[i]);
		if (array_length(_chunk) < _size) continue;

		array_push(_chunks, _chunk);
		_chunk = [];
	}

	if (array_length(_chunk) > 0) array_push(_chunks, _chunk);

	return _chunks;
}

/// @func	array_flatten(array, [depth])
/// @param	{Array}	array	The array to flatten.
/// @param	{Real}	depth	Optional. How many levels of nested arrays to unwrap. (Default: infinity)
/// @desc	Returns a new array with the nested arrays unwrapped up to the given depth. A depth of 0 returns a copy of the array as it is.
///	@return	{Array}
function array_flatten(_array, _depth = infinity) {
	var _out = [];
	var _len = array_length(_array);

	for (var i = 0; i < _len; i++) {
		var _value = _array[i];

		if (is_array(_value) && _depth > 0) {
			var _inner = array_flatten(_value, _depth - 1);
			var _inner_len = array_length(_inner);
			for (var j = 0; j < _inner_len; j++) {
				array_push(_out, _inner[j]);
			}
			continue;
		}

		array_push(_out, _value);
	}

	return _out;
}

/// @func	array_group_by(array, callback)
/// @param	{Array}						array		The array to group.
/// @param	{Function|Asset.GMScript}	callback	Receives the element and its index, and returns the key to group it under.
/// @desc	Returns a struct where every key is a value returned by the callback and every value is the array of elements that returned it. Keys are always converted to a string.
///	@return	{Struct}
function array_group_by(_array, _callback) {
	var _groups = {};
	var _len = array_length(_array);

	for (var i = 0; i < _len; i++) {
		var _key = string(_callback(_array[i], i));
		if (!variable_struct_exists(_groups, _key)) _groups[$ _key] = [];
		array_push(_groups[$ _key], _array[i]);
	}

	return _groups;
}

/// @func	array_sum(array)
/// @param	{Array}	array	The array to add up.
/// @desc	Returns the sum of every numeric element of the array. Elements that are not numbers are ignored.
///	@return	{Real}
function array_sum(_array) {
	var _len = array_length(_array);
	var _sum = 0;

	for (var i = 0; i < _len; i++) {
		if (is_numeric(_array[i])) _sum += _array[i];
	}

	return _sum;
}

/// @func	array_mean(array)
/// @param	{Array}	array	The array to average.
/// @desc	Returns the average of every numeric element of the array. Elements that are not numbers are ignored, and an array without numbers returns 0.
///	@return	{Real}
function array_mean(_array) {
	var _nums = __gml_ext_internal_array_numbers(_array);
	var _len = array_length(_nums);
	if (_len == 0) return 0;

	return array_sum(_nums) / _len;
}

/// @func	array_median(array)
/// @param	{Array}	array	The array to get the median of.
/// @desc	Returns the median of every numeric element of the array. With an even amount of numbers the average of the two middle ones is returned. Elements that are not numbers are ignored, and an array without numbers returns 0.
///	@return	{Real}
function array_median(_array) {
	var _nums = __gml_ext_internal_array_numbers(_array);
	var _len = array_length(_nums);
	if (_len == 0) return 0;

	array_sort(_nums, sort_ascending);
	var _mid = _len div 2;

	return ((_len mod 2) == 1) ? _nums[_mid] : (_nums[_mid - 1] + _nums[_mid]) / 2;
}

/// @func	__gml_ext_internal_array_numbers(array)
/// @param	{Array}	array	The array to filter.
/// @desc	Returns a new array holding only the numeric elements of the given array.
/// @ignore
function __gml_ext_internal_array_numbers(_array) {
	var _len = array_length(_array);
	var _nums = [];

	for (var i = 0; i < _len; i++) {
		if (is_numeric(_array[i])) array_push(_nums, _array[i]);
	}

	return _nums;
}

/// @func	array_sample(array, [count], [unique])
/// @param	{Array}	array	The array to take the elements from.
/// @param	{Real}	count	Optional. How many elements to take. (Default: 1)
/// @param	{Bool}	unique	Optional. Never take the same element twice. (Default: true)
/// @desc	Returns an array with `count` random elements of the given array. An element is never taken twice unless `unique` is set to `false`, so an unique sample is capped to the length of the array. Always returns an array, even for a single element.
///	@return	{Array}
function array_sample(_array, _count = 1, _unique = true) {
	var _len = array_length(_array);
	var _out = [];
	_count = floor(_count);

	if (_len == 0 || _count < 1) return _out;

	if (!_unique) {
		repeat (_count) {
			array_push(_out, _array[irandom(_len - 1)]);
		}
		return _out;
	}

	// The pool is a shallow copy so the sampled elements keep their references.
	var _pool = [];
	array_copy(_pool, 0, _array, 0, _len);
	var _pool_len = _len;

	repeat (min(_count, _len)) {
		var _index = irandom(_pool_len - 1);
		array_push(_out, _pool[_index]);
		_pool[@ _index] = _pool[_pool_len - 1];
		_pool_len--;
	}

	return _out;
}

/// @func	array_swap(array, index1, index2)
/// @param	{Array}	array	The array to modify.
/// @param	{Real}	index1	The index of the first element.
/// @param	{Real}	index2	The index of the second element.
/// @desc	Swaps two elements of an array in place and returns the same array. Nothing is changed if any of the indexes is out of bounds.
///	@return	{Array}
function array_swap(_array, _index_1, _index_2) {
	var _len = array_length(_array);

	if (_index_1 < 0 || _index_1 >= _len || _index_2 < 0 || _index_2 >= _len) {
		trace("[GML-Extended] - ERROR! On function \"array_swap()\". Index out of bounds.");
		return _array;
	}

	var _tmp = _array[_index_1];
	_array[@ _index_1] = _array[_index_2];
	_array[@ _index_2] = _tmp;

	return _array;
}
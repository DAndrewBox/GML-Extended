#region Definitions
#macro	sort_ascending		function (a,b) {return a - b}
#macro	sort_descending		function (a,b) {return b - a}
#macro	sort_elem_size_asc	function (a,b) {return get_size(a) > get_size(b)}
#macro	sort_elem_size_desc	function (a,b) {return get_size(b) < get_size(b)}
#endregion

/// @func	array_create_ext(size, value|callback, args_array)
/// @param	{real}	size
/// @param	{any}	value|callback
/// @param	{array}	args_array
/// @desc	Creates a new array using a callback or value for every element
function array_create_ext(_size, _val=undefined, _args = []) {
	if (!__gml_ext_comp_is_callable(_val)) {
		return array_create(_size, _val);
	}
	
	var _arr = array_create(_size, undefined);
	for (var i = 0; i < _size; i++) {
		_arr[@ i] = script_execute_ext(_val, _args);
	}
	
	return _arr;
}

///	@func array_fill(array, value)
/// @param	{array}	array
/// @param	{any}	value
/// @desc	Fills an array with a value.
function array_fill(_array, _val) {
	var _arr_len = array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		_array[@ i] = _val;
	}
}

///	@func array_clear(array)
/// @param	{array}	array
/// @desc	Clears an array filling with undefined values to clear memory.
function array_clear(_array) {
	array_delete(_array, 0, array_length(_array));
}

///	@func array_empty(array)
/// @param	{array}	array
/// @desc	Checks if an array is empty. Returns a boolean.
function array_empty(_array) {
	return (array_length(_array) == 0);
}

///	@func array_find_index_by_value(array, value)
/// @param	{array}	array
/// @param	{any}	value
/// @desc	Checks if a value is inside the array, and then returns its index, else, returns -1.
function array_find_index_by_value(_array, _val) {
	for (var i = 0; i < array_length(_array); i++) {
		if (_array[@ i] == _val) {
			return i;
		}
	}
	
	return -1;
}

///	@func array_to_ds_list(array)
/// @param	{array}	array
/// @desc	Returns the array as a ds list with all its values.
function array_to_ds_list(_array) {
	var _new_ds_list = ds_list_create();
	var _arr_len = array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		_new_ds_list[| i] = _array[i];
	}
	
	return _new_ds_list;
}

///	@func ds_list_to_array(list)
/// @param	{ds_list}	list
/// @desc	Converts a ds list to an array with all its values and the returns it.
function ds_list_to_array(_list) {
	var _ds_list_size = ds_list_size(_list);
	var _new_array = array_create(_ds_list_size);
	
	for (var i = 0; i < _ds_list_size; i++) {
		_new_array[i] = _list[| i];
	}
	
	return _new_array;
}

///	@func array_to_struct(array)
/// @param	{array}	array
/// @desc	Returns the array as a struct with all its values inside numeric keys.
function array_to_struct(_array) {
	var _new_struct = {};
	var _arr_len = array_length(_array);
	for (var i = 0; i < _arr_len; i++) {
		variable_struct_set(_new_struct, i, _array[i]);
	}
	
	return _new_struct;
}

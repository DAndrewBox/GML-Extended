#region Definitions
#macro	sort_ascending		function (a,b) {return a - b}
#macro	sort_descending		function (a,b) {return b - a}
#macro	sort_elem_size_asc	function (a,b) {return get_size(a) > get_size(b)}
#macro	sort_elem_size_desc	function (a,b) {return get_size(b) < get_size(b)}
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

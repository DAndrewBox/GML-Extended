#region Definitions
#macro	sort_ascending		function (a,b) {return a - b}
#macro	sort_descending		function (a,b) {return b - a}
#macro	sort_elem_size_asc	function (a,b) {return size(a) > size(b)}
#macro	sort_elem_size_desc	function (a,b) {return size(b) < size(b)}
#endregion

///	@func array_fill(array, value)
/// @param	{array}	array
/// @param	{any}	value
/// @desc	Fills an array with a value.
function array_fill(_array, _val) {
	for (var i = 0; i < array_length(_array); i++) {
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

///	@func array_find_index(array, value)
/// @param	{array}	array
/// @param	{any}	value
/// @desc	Checks if a value is inside the array, and then returns its index, else, returns -1.
function array_find_index(_array, _val) {
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
	for (var i = 0; i < array_length(_array); i++) {
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
	for (var i = 0; i < array_length(_array); i++) {
		variable_struct_set(_new_struct, i, _array[i]);
	}
	
	return _new_struct;
}

///	@func array_write(array)
/// @param	{array}	array
/// @desc	Returns an string of the array.
function array_write(_array) {
	var _array_len = array_length(_array); 
	var _new_str = "[";
	
	for (var i = 0; i < _array_len; i++) {
		var _val_is_str = (is_string(_array[i]));
		_new_str += ( _val_is_str ? "\"" : "" ) +
					string(_array[i]) +
					( _val_is_str ? "\"" : "" ) +
					( i < _array_len - 1 ? "," : "" );
	}
	
	_new_str += "]";
	
	return _new_str;
}

/// @func array_foreach(array, callback_fn)
/// @param	{array} array
/// @param	{func}	callback_fn
/// @desc	Execute a callback into every element of the array.
function array_foreach(_array, _callback) {
	var _len = array_length(_array);
	for (var i = 0; i < _len; i++) {
		_callback(_array[@ i]);
	}
}

/// @func	array_map(array, callback_fn, use_index)
/// @param	{array} array
/// @param	{func}	callback_fn
/// @param	{bool}	use_index
/// @desc	Returns the value of a function on every element of the array
function array_map(_array, _callback, _use_index=false) {
	var _new_array = [];
	var _len = array_length(_array);
	
	for (var i = 0; i < _len; i++) {
		if (_use_index) {
			array_push(_new_array, _callback(_array[@ i], i));
		} else {
			array_push(_new_array, _callback(_array[@ i]));
		}
	}
		
	return _new_array;
}

/// @func	array_shuffle(array)
/// @desc	Returns a shuffled array.
function array_shuffle(_array) {
	for (var n_pair__=0; n_pair__<array_length(_array)/2; n_pair__++) {
		var n1__ = irandom(array_length(_array));
		var n2__ = irandom(array_length(_array));
		var tmp__= _array[n1__];
		_array[n1__] = _array[n2__];
		_array[n2__] = tmp__;
	}
	return _array;
}

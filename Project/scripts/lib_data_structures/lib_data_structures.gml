/// @func	ds_grid_write_buffer(grid)
/// @param	{Id.DsGrid}	grid	The numeric grid to serialize.
/// @desc	Returns the contents of a numeric grid as a compressed base64 string. Cells are stored as 64-bit floats, so any non numeric cell is written as 0. Use `ds_grid_read_buffer` to restore it.
///	@return	{String}
function ds_grid_write_buffer(_grid) {
	if (!ds_exists(_grid, ds_type_grid)) {
		trace("(GML-Extended) - ERROR! On function \"ds_grid_write_buffer()\". The given grid does not exist.");
		return "";
	}

	var _w = ds_grid_width(_grid);
	var _h = ds_grid_height(_grid);
	// Two u32 for the size header, then one f64 per cell.
	var _buffer = buffer_create(8 + _w * _h * 8, buffer_fixed, 1);

	buffer_write(_buffer, buffer_u32, _w);
	buffer_write(_buffer, buffer_u32, _h);

	for (var _y = 0; _y < _h; _y++) {
		for (var _x = 0; _x < _w; _x++) {
			var _value = ds_grid_get(_grid, _x, _y);
			buffer_write(_buffer, buffer_f64, is_real(_value) ? _value : 0);
		}
	}

	var _compressed = buffer_compress(_buffer, 0, buffer_tell(_buffer));
	var _b64_str = buffer_base64_encode(_compressed, 0, buffer_get_size(_compressed));

	buffer_delete(_compressed);
	buffer_delete(_buffer);

	return _b64_str;
}

/// @func	ds_grid_read_buffer(grid, b64_string)
/// @param	{Id.DsGrid}	grid		The grid to write the contents into.
/// @param	{String}	b64_string	The string returned by `ds_grid_write_buffer`.
/// @desc	Fills a grid with the contents of a string created by `ds_grid_write_buffer`. The grid is resized to match the stored size and is returned unchanged if the string cannot be read.
///	@return	{Id.DsGrid}
function ds_grid_read_buffer(_grid, _b64_str) {
	if (!ds_exists(_grid, ds_type_grid)) {
		trace("(GML-Extended) - ERROR! On function \"ds_grid_read_buffer()\". The given grid does not exist.");
		return _grid;
	}

	var _compressed = buffer_base64_decode(_b64_str);
	var _buffer = buffer_decompress(_compressed);
	buffer_delete(_compressed);

	if (_buffer < 0) {
		trace("(GML-Extended) - ERROR! On function \"ds_grid_read_buffer()\". The given string is not a valid grid buffer.");
		return _grid;
	}

	var _w = buffer_read(_buffer, buffer_u32);
	var _h = buffer_read(_buffer, buffer_u32);

	// The grid is resized so it always matches the data that was written.
	ds_grid_resize(_grid, _w, _h);

	for (var _y = 0; _y < _h; _y++) {
		for (var _x = 0; _x < _w; _x++) {
			ds_grid_set(_grid, _x, _y, buffer_read(_buffer, buffer_f64));
		}
	}

	buffer_delete(_buffer);

	return _grid;
}

/// @func	ds_list_write_buffer(list)
/// @param	{Id.DsList}	list	The list to serialize.
/// @desc	Returns the contents of a list as a compressed base64 string. Every value type the list can hold is kept, nested lists and maps included. Use `ds_list_read_buffer` to restore it.
///	@return	{String}
function ds_list_write_buffer(_list) {
	if (!ds_exists(_list, ds_type_list)) {
		trace("(GML-Extended) - ERROR! On function \"ds_list_write_buffer()\". The given list does not exist.");
		return "";
	}

	return __gml_ext_internal_string_to_b64(ds_list_write(_list));
}

/// @func	ds_list_read_buffer(list, b64_string)
/// @param	{Id.DsList}	list		The list to write the contents into.
/// @param	{String}	b64_string	The string returned by `ds_list_write_buffer`.
/// @desc	Replaces the contents of a list with the values stored in a string created by `ds_list_write_buffer`. The list is returned unchanged if it does not exist or if the string cannot be read.
///	@return	{Id.DsList}
function ds_list_read_buffer(_list, _b64_str) {
	if (!ds_exists(_list, ds_type_list)) {
		trace("(GML-Extended) - ERROR! On function \"ds_list_read_buffer()\". The given list does not exist.");
		return _list;
	}

	var _str = __gml_ext_internal_b64_to_string(_b64_str);
	if (is_undefined(_str)) {
		trace("(GML-Extended) - ERROR! On function \"ds_list_read_buffer()\". The given string is not a valid list buffer.");
		return _list;
	}

	ds_list_clear(_list);
	ds_list_read(_list, _str);

	return _list;
}

/// @func	ds_map_write_buffer(map)
/// @param	{Id.DsMap}	map		The map to serialize.
/// @desc	Returns the contents of a map as a compressed base64 string. Keys keep their original type, and nested lists and maps are kept too. Use `ds_map_read_buffer` to restore it.
///	@return	{String}
function ds_map_write_buffer(_map) {
	if (!ds_exists(_map, ds_type_map)) {
		trace("(GML-Extended) - ERROR! On function \"ds_map_write_buffer()\". The given map does not exist.");
		return "";
	}

	return __gml_ext_internal_string_to_b64(ds_map_write(_map));
}

/// @func	ds_map_read_buffer(map, b64_string)
/// @param	{Id.DsMap}	map			The map to write the contents into.
/// @param	{String}	b64_string	The string returned by `ds_map_write_buffer`.
/// @desc	Replaces the contents of a map with the values stored in a string created by `ds_map_write_buffer`. The map is returned unchanged if it does not exist or if the string cannot be read.
///	@return	{Id.DsMap}
function ds_map_read_buffer(_map, _b64_str) {
	if (!ds_exists(_map, ds_type_map)) {
		trace("(GML-Extended) - ERROR! On function \"ds_map_read_buffer()\". The given map does not exist.");
		return _map;
	}

	var _str = __gml_ext_internal_b64_to_string(_b64_str);
	if (is_undefined(_str)) {
		trace("(GML-Extended) - ERROR! On function \"ds_map_read_buffer()\". The given string is not a valid map buffer.");
		return _map;
	}

	ds_map_clear(_map);
	ds_map_read(_map, _str);

	return _map;
}

/// @func	struct_write_buffer(struct)
/// @param	{Struct|Array}	struct	The struct or array to serialize.
/// @desc	Returns a struct or an array as a compressed base64 string, nested values included. Uses `json_stringify` under the hood, so methods and `undefined` values are not kept. Use `struct_read_buffer` to restore it.
///	@return	{String}
function struct_write_buffer(_struct) {
	if (!is_struct(_struct) && !is_array(_struct)) {
		trace("(GML-Extended) - ERROR! On function \"struct_write_buffer()\". The given value is not a struct or an array.");
		return "";
	}

	return __gml_ext_internal_string_to_b64(__gml_ext_comp_json_stringify(_struct));
}

/// @func	struct_read_buffer(b64_string)
/// @param	{String}	b64_string	The string returned by `struct_write_buffer`.
/// @desc	Returns the struct or array stored in a string created by `struct_write_buffer`. Returns an empty struct if the string cannot be read.
///	@return	{Struct|Array}
function struct_read_buffer(_b64_str) {
	var _str = __gml_ext_internal_b64_to_string(_b64_str);

	if (!is_undefined(_str)) {
		try {
			return json_parse(_str);
		} catch (e) {
			trace("(GML-Extended) - ERROR! On function \"struct_read_buffer()\". ", e.message);
		}
	}

	trace("(GML-Extended) - ERROR! On function \"struct_read_buffer()\". The given string is not a valid struct buffer.");
	return {};
}

/// @func	__gml_ext_internal_string_to_b64(string)
/// @param	{String}	string	The string to pack.
/// @desc	Packs a string into a compressed base64 string.
/// @ignore
function __gml_ext_internal_string_to_b64(_str) {
	var _buffer = buffer_create(string_byte_length(_str) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _str);

	var _compressed = buffer_compress(_buffer, 0, buffer_tell(_buffer));
	var _b64_str = buffer_base64_encode(_compressed, 0, buffer_get_size(_compressed));

	buffer_delete(_compressed);
	buffer_delete(_buffer);

	return _b64_str;
}

/// @func	__gml_ext_internal_b64_to_string(b64_string)
/// @param	{String}	b64_string	The compressed base64 string to unpack.
/// @desc	Unpacks a string packed by `__gml_ext_internal_string_to_b64`, or `undefined` if it cannot be read.
/// @ignore
function __gml_ext_internal_b64_to_string(_b64_str) {
	if (!is_string(_b64_str) || _b64_str == "") return undefined;

	var _compressed = buffer_base64_decode(_b64_str);
	var _buffer = buffer_decompress(_compressed);
	buffer_delete(_compressed);

	if (_buffer < 0) return undefined;

	var _str = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);

	return _str;
}
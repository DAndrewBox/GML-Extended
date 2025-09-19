/// @func	str(value)
/// @param	{Any}	value	The value to convert to a string.
/// @desc	Converts a value to a string.
///	@return	{String}
function str(_val) {
	return string(_val)
}

/// @func	int(value)
/// @param	{Real}	value	The value to convert to an integer
/// @desc	Converts a value to an integer (removes all decimals).
///	@return	{Real}
function int(_val) {
	return floor(real(_val));
}

/// @func	int8(value)
/// @param	{Real}	value	The value to convert.
/// @desc	Converts a value to an 8-bit integer. (0 - 255)
///	@return	{Real}
function int8(_val) {
	return wrap(int(_val), 0, 256);
}

/// @func	int16(value)
/// @param	{Real}	value	The value to convert.
/// @desc	Converts a value to a 16-bit integer. (0 - 65535)
///	@return	{Real}
function int16(_val) {
	return wrap(int(_val), 0, 65536);
}

/// @func	int8s(value)
/// @param	{Real}	value	The value to convert.
/// @desc	Converts a value to an 8-bit signed integer. (-128 - 127)
///	@return	{Real}
function int8s(_val) {
	return wrap(int(_val), -128, 128);
}

/// @func	int16s(value)
/// @param	{Real}	value	The value to convert.
/// @desc	Converts a value to a 16-bit signed integer. (-32768 - 32767)
///	@return	{Real}
function int16s(_val) {
	return wrap(int(_val), -32768, 32768);
}

/// @func	is_type(element, type)
/// @param	{Any}				element		The value to check the type of.
/// @param	{Array | String}	type		The type(s) to check the value with, can be an array of types.
/// @desc	Checks if a value is of a specific type.
///	@return	{Bool}
function is_type(_elem, _type) {
	if (is_array(_type)) {
		var _len = get_size(_type);
		for (var i = 0; i < _len; i++) {
			if (typeof(_elem) == _type[i]) {
				return true;
			}
		}
	}
	return typeof(_elem) == _type;
}

#region Definitions / Macros
#macro	gm_type_number		"number"
#macro	gm_type_string		"string"
#macro	gm_type_array		"array"
#macro	gm_type_bool		"bool"
#macro	gm_type_int32		"int32"
#macro	gm_type_int64		"int64"
#macro	gm_type_pointer		"ptr"
#macro	gm_type_undefined	"undefined"
#macro	gm_type_method		"method"
#macro	gm_type_struct		"struct"
#macro	gm_type_reference	"ref"
#macro	gm_type_unknown		"unknown"

#macro	null				pointer_null

#macro	gm_unit_seconds		global.__gml_ext[$ "units_seconds"]
#macro	gm_unit_frames		global.__gml_ext[$ "units_frames"]
#endregion


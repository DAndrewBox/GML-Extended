/// @func	str(value)
/// @param	{any}	value
function str(_val) {
	return string(_val)
}

/// @func	int(value)
/// @param	{real}	value
function int(_val) {
	return floor(real(_val));
}

/// @func	int8(value)
/// @param	{real}	value
function int8(_val) {
	return wrap(int(_val), 0, 255);
}

/// @func	int16(value)
/// @param	{real}	value
function int16(_val) {
	return wrap(int(_val), 0, 65535);
}

/// @func	int8s(value)
/// @param	{real}	value
function int8s(_val) {
	return wrap(int(_val), -128, 127);
}

/// @func	int16s(value)
/// @param	{real}	value
function int16s(_val) {
	return wrap(int(_val), -32768, 32767);
}

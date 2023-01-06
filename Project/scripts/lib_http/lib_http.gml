/// @func	http_request_send(url, method, data)
/// @param {str}	url
/// @param {str}	method
/// @param {any}	data
function http_request_send(_url="", _method="GET", _data={}) {
	var _map = ds_map_create();
	_map[? "Connection"]		= "keep-alive";
	_map[? "Cache-Control"]		= "max-age=0";
	_map[? "Content-Type"]		= "application/json";
	_map[? "x-access-tokens"]	= "";
	
	_data = json_stringify(_data);
	return http_request(_url, _method, _map, _data);
}

/// @func	http_async_get_message(show_on_console)
/// @param	{bool}	show_on_console
/// @desc	Get the message from an async request.
function http_async_get_message(_show_on_console = false) {	
	try {
		var _headers = [];
		var _values = [];
		ds_map_keys_to_array(async_load[? "response_headers"], _headers);
		ds_map_values_to_array(async_load[? "response_headers"], _values);

		if (_show_on_console) {
			show_debug_message({
				id: async_load[? "id"],
				url: async_load[? "url"],
				header: _headers,
				header_values: _values,
				result: async_load[? "result"],
			});
		}
	} catch(e) {
		show_debug_message(e.message);
	}
	
	return async_load;
}

/// @func	http_async_handle_request(message_type)
/// @param	{real}	message_type
/// @desc	Handle the result of an async request.
function http_async_handle_request(_msgType) {
	switch (_msgType) {
		default:	show_message_async(_msgType);
	}
}
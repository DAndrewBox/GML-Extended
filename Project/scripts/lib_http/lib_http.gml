#macro	http_method_get		"GET"
#macro	http_method_post	"POST"
#macro	http_method_put		"PUT"
#macro	http_method_delete	"DELETE"

/// @func	http_request_send(url, method, body, headers)
/// @param	{string}	url
/// @param	{string}	method
/// @param	{struct}	body
/// @param	{struct}	headers
function http_request_send(_url="", _method=http_method_get, _body={}, _headers={}) {
	var _map = ds_map_create();
	
	/* Default headers */
	_map[? "Connection"]		= "keep-alive";
	_map[? "Cache-Control"]		= "max-age=0";
	_map[? "Content-Type"]		= "application/json";
	_map[? "x-access-tokens"]	= "";
	
	/* Add headers */
	var _headers_keys = struct_keys(_headers);
	var _headers_size = get_size(_headers_keys);
	for (var i = 0; i < _headers_size; i++) {
		_map[? _headers_keys[i]] = _headers[$ _headers_keys[i]];
	}
	
	return http_request(_url, _method, _map, json_stringify(_body));
}

/// @func	http_async_get_message(show_on_console)
/// @param	{bool}	show_on_console
/// @desc	Get the message from an async request.
function http_async_get_message(_show_on_console = false) {	
	try {
		var _headers = ds_map_keys_to_array(async_load[? "response_headers"]);
		var _values = ds_map_values_to_array(async_load[? "response_headers"]);		

		if (_show_on_console) {
			trace({
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
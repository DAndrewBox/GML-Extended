#region Definitions
global.__SOCKET				= undefined;
global.__SERVER_BUFFER		= undefined;
global.__PING_TIME_START	= current_time;
global.__PING_TIME_END		= current_time;
global.__PING_MS			= 0;
global.__PING_LAST_RECEIVED = current_time;

#macro	SERVER_URL				"127.0.0.1"
#macro	SERVER_PORT				9000
#macro	SERVER_SOCKET			global.__SOCKET
#macro	SERVER_BUFFER			global.__SERVER_BUFFER
#macro	SERVER_DATA_DELIMITER	"|"
#macro	SERVER_TIMEOUT			4000
#macro	BUFFER_SIZE				512
#macro	PING_TIME_START			global.__PING_TIME_START
#macro	PING_TIME_END			global.__PING_TIME_END
#macro	PING_TIME				global.__PING_MS
#macro	PING_TIME_LAST			global.__PING_LAST_RECEIVED

// Add your custom message types here
enum SERVER_MESSAGE_TYPE {
	PING,
}
#endregion

/// @func	server_tcp_init(url, port, buffer_size)
/// @param	{str}	url
/// @param	{real}	port
/// @param	{real}	buffer_size
function server_tcp_init(_url, _port, _size) {
	SERVER_SOCKET = network_create_socket(network_socket_tcp);
	network_set_config(network_config_connect_timeout, SERVER_TIMEOUT);
	network_connect_raw_async(SERVER_SOCKET, _url, _port);
	SERVER_BUFFER = buffer_create(_size, buffer_fixed, 8);
}

/// @func	server_tcp_send_data(data)
/// @param	{any}	data
function server_tcp_send_data(_data) {
	// Convert data from JSON to String
	_data = json_stringify(_data);
	
	// Send data
	buffer_seek(SERVER_BUFFER, buffer_seek_start, 0);
	
	// Write a delimiter that has to be read server-side to separete requests
	// when sent a lot of them per second.
	buffer_write(SERVER_BUFFER, buffer_text, _data + SERVER_DATA_DELIMITER);
	network_send_raw(SERVER_SOCKET, SERVER_BUFFER, buffer_tell(SERVER_BUFFER));
}

/// @func	server_send_ping()
function server_tcp_send_ping() {
	var _data = {
		type: SERVER_MESSAGE_TYPE.PING,
	};
	PING_TIME_START = current_time;
	server_tcp_send_data(_data);
}

/// @func	server_tcp_get_data()
function server_tcp_get_data() {
	var _buffer = async_load[? "buffer"];
	
	if (async_load[? "size"] > 0) {
		try {
			buffer_seek(_buffer, buffer_seek_start, 0);
			var _res = buffer_read(_buffer, buffer_string);
			// Split requests using delimiter so it doens't try to
			// read multiple requests simultaniously
			_res = string_split(_res, SERVER_DATA_DELIMITER);
			for (var i = 0; i < array_length(_res); i++) {
				var _json = json_parse(_res[i]);
				server_tcp_handle_request(_json);
				delete _json;
			}
		} catch(e) {
			show_debug_message(e.message);
			return;
		}
	}
}

/// @func	server_tcp_handle_request(json)
/// @param	{any}	json
function server_tcp_handle_request(_json) {
	try {
		switch (_json.type) {
			case SERVER_MESSAGE_TYPE.PING:
				PING_TIME_END = current_time;
				PING_TIME = (PING_TIME_END - PING_TIME_START);
				PING_TIME_LAST = PING_TIME_END;
				break;
		}
	} catch(e) {
		show_message_async(e);
	}
}
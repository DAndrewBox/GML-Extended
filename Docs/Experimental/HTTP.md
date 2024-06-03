# HTTP

> [!WARNING]
> This is an experimental feature. This functions are subject to change. Use at your own risk.

### Table of Contents

- [http_request_send](#http_request_send)
- [http_async_get_message](#http_async_get_message)
- [http_async_handle_request](#http_async_handle_request)

---

# http_request_send

An extension of the `http_request` function to send any method request with headers included into the function, so you don't need to create a headers map everytime you want to send a request.

### Syntax

```js
http_request_send([(url = "")], [(method = "GET")], [(data = "")]);
```

| Argument |  Type  | Description                        |
| :------- | :----: | :--------------------------------- |
| url      | String | The URL to send the request.       |
| method   | String | The method to send the request.    |
| data     | String | The data to send with the request. |

### Returns

```js
Async Request ID
```

### Example

```js
http_request_send("https://api.github.com/users/dandrewbox", "GET", "");
```

The above code will send a GET request to the URL and return the request ID.

---

# http_async_get_message

Get the message from an async request. This function is used to get the response from a request sent with `http_request_send`, and will return the response message type.

**This function should be called on the Async - HTTP event**

### Syntax

```js
http_async_get_message([(show_on_console = false)]);
```

| Argument        |  Type   | Description                                                |
| :-------------- | :-----: | :--------------------------------------------------------- |
| show_on_console | Boolean | If true, the response object will be shown on the console. |

### Returns

```js
Real;
```

### Example

```js
var _msgType = http_async_get_message(true);

http_async_handle_request(_msgType);
```

The above code will get the message type from the request and set the var `_msgType` to the message type. Then handle the result with the `http_async_handle_request` function.

As the first argument is true, the function will show a debug message with these props:

```js
{
  id: async_load[? "id"],
  url: async_load[? "url"],
  header: async_load[? "response_headers"].keys,
  header_values: async_load[? "response_headers"].values,
  result: async_load[? "result"],
}
```

---

# http_async_handle_request

Handle the result of an async request. This function is used to handle the response from a request sent with `http_request_send`, and will return the response message type.

**This function should be called on the Async - HTTP event**

### Syntax

```js
http_async_handle_request(message_type);
```

| Argument     | Type | Description                                                           |
| :----------- | :--: | :-------------------------------------------------------------------- |
| message_type | Real | The message type returned from the `http_async_get_message` function. |

### Returns

```js
none;
```

### Example

```js
var _msgType = http_async_get_message();

http_async_handle_request(_msgType);
```

The above code will get the message type from the request and set the var `_msgType` to the message type. Then handle the result with the `http_async_handle_request` function and execute the callbacks inside the function.

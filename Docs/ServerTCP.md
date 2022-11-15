# Server (TCP)
### Table of Contents
- [Macros & Constants](#macros--constants)
- [server_tcp_init](#server_tcp_init)
- [server_tcp_send_data](#server_tcp_send_data)
- [server_tcp_send_ping](#server_tcp_send_ping)
- [server_tcp_get_data](#server_tcp_get_data)
- [server_tcp_handle_request](#server_tcp_handle_request)

---
# Macros & Constants
| Name | Type | Description |
| :--- | :---: | :--- |
| SERVER_URL | string | The URL or IP of the server. Should not include "http://" or "https://" at the start. |
| SERVER_PORT | int | The port of the server. |
| SERVER_SOCKET | Integer | The socket used to connect to the server. |
| SERVER_BUFFER | Integer | The buffer used to receive data from the server. |
| BUFFER_SIZE | Integer | The size of the buffer. (default = 512, use power of 2 for perfomance reasons.) |
| SERVER_DATA_LIMITER | String | The limiter used to separate the data received from the server. |
| SERVER_TIMEOUT | Integer | The timeout used to wait for the server to respond in ms. |
| PING_TIME_START | Integer | The time when the ping started. |
| PING_TIME_END | Integer | The time when the ping ended. |
| PING_TIME | Integer | The time it took to ping the server in ms. |
| PING_TIME_LAST | Integer | The last time client received a ping response. |

---

# server_tcp_init
Creates a socket and a buffer to connect to a TCP server.

### Syntax
  ```js
  server_tcp_init(url, port, buffer_size);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| url | String | The URL to send the request. |
| method | String | The method to send the request. |
| data | String | The data to send with the request. |

### Returns
  ```js
  None
  ```

### Example
```js
server_tcp_init(SERVER_URL, SERVER_PORT, BUFFER_SIZE);
```

The above code will create a socket and a buffer to connect to a TCP server. 

---

# server_tcp_send_data
Sends data to the server and waits for a response. Data should be passed as an struct and will be converted to a string internally.

### Syntax
  ```js
  server_tcp_send_data(data);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| data | Struct | The data to send to the server. |

### Returns
  ```js
  None
  ```

### Example
```js
server_tcp_init(SERVER_URL, SERVER_PORT, BUFFER_SIZE);

server_tcp_send_data({
  "type": SERVER_MESSAGE_TYPE.PING,
  "data": "Hello World!"
});
```

The above code will send the following data to the server:
```js
{
  "type": 0,
  "data": "Hello World!"
}
```

---

# server_tcp_send_ping
Sends a ping to the server and waits for a response.

### Syntax
  ```js
  server_tcp_send_ping();
  ```

### Returns
  ```js
  None
  ```

### Example
```js
server_tcp_init(SERVER_URL, SERVER_PORT, BUFFER_SIZE);

server_tcp_send_ping();
```

The above code will send a ping to the server and internally modify the `PING_TIME` variable.

---

# server_tcp_get_data
Gets the data received from the server. Data will be converted to a struct and be handled by the `server_tcp_handle_data` function internally.

**This function should be called on the Async - Networking event**

### Syntax
  ```js
  server_tcp_get_data();
  ```

### Returns
  ```js
  None
  ```

### Example
```js
server_tcp_get_data();
```

The above code will get the data received from the server and internally handle it.

---

# server_tcp_handle_request
Handles the data received from the server. This function should be called on the Async - Networking event.

**This function should be called on the Async - Networking event**

### Syntax
  ```js
  server_tcp_handle_request(json);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| json | Struct | The data received from the server as a struct. |

### Returns
  ```js
  None
  ```

### Example
```js
server_tcp_handle_request();
```

The above code will handle the data received from the server.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Math.md">Math</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Shaders.md">Shaders</a>
    </h3>
  </div>
</div>
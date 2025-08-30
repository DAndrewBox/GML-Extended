# Shortcuts

### Table of Contents

- [del](#del)
- [get_size](#get_size)
- [contains](#contains)
- [trace](#trace)
- [alert](#alert)
- [alert_async](#alert_async)
- [view_get_x](#view_get_x)
- [view_get_y](#view_get_y)

# del ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Deletes an instance and executes the destroy event of the object. Serves as a shortcut for `instance_destroy`.

### Syntax

```js
del(object_index | id);
```

| Argument           |    Type     | Description                                       |
| :----------------- | :---------: | :------------------------------------------------ |
| object_index or id | Real or Ref | The index of the object or the id of the instance |

### Returns

```js
None;
```

### Example

```js
del(obj_Player);
```

The above code will delete the player and execute the destroy event of the object.

---

# get_size

> [!NOTE]
> Since GML-Extended version 1.5.0 can receive a second argument to specify the type of the element. This was added so you can get size of data structs (ds_list, ds_map, ds_grid, etc).

Returns the size or length of the element. If the element is an array, it will return the length of the array. If the element is a string, it will return the length of the string. If the element is a struct, it will return the number of variables in the struct. If the element is a real, it will return the length of a string of the value.

### Syntax

```js
get_size(element, [type]);
```

| Argument |                Type                 | Description                    |
| :------- | :---------------------------------: | :----------------------------- |
| element  | Real, String, Bool, Array or Struct | The element to get the size of |
| type     |             `gm_type_*`             | The type of the element        |

### Returns

```js
Real;
```

### Example

```js
var _array = [0, 1, 2, 3];
var _string = "Hello World!";
var _struct = { a: 0, b: 1, c: 2 };
var _real = 123;

show_debug_message("Array size: " + string(size(_array)));
show_debug_message("String size: " + string(size(_string)));
show_debug_message("Struct size: " + string(size(_struct)));
show_debug_message("Real size: " + string(size(_real)));
```

The above code will show the size of the `_array`, `_string`, `_struct`, and `_real` on console.

The output will be:

```
Array size: 4
String size: 12
Struct size: 3
Real size: 3
```

---

# contains ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Checks if an element is inside a container. Serves as a shortcut for `ds_list_find_index`, `ds_map_find_value`, `ds_grid_value`, `array_find_value`, `string_pos`, and more.

### Syntax

```js
contains(element, container, [container_type]);
```

| Argument       |                Type                 | Description                                 |
| :------------- | :---------------------------------: | :------------------------------------------ |
| element        | Real, String, Bool, Array or Struct | The element to check if it's inside         |
| container      | Real, String, Bool, Array or Struct | The container to check if the element is in |
| container_type |             `gm_type_*`             | The type of the container                   |

### Returns

```js
Real;
```

### Example

```js
var _array = [0, 1, 2, 3];
var _string = "Hello World!";
var _struct = { a: 0, b: 1, c: 2 };
var _real = 123;

show_debug_message("Array contains 2: " + string(contains(2, _array)));
show_debug_message("String contains 'World': " + string(contains("World", _string)));
show_debug_message("Struct contains 'b': " + string(contains("b", _struct)));
show_debug_message("Real contains 3: " + string(contains(3, _real)));
```

The above code will check if the element is inside the container. If it is, it will return the index of the element in the container. If it's not, it will return -1.

---

# trace ![](https://img.shields.io/badge/v1.2.3-3e5f4a?style=flat)

Prints a message to the console. Serves as a shortcut for `show_debug_message`.

### Syntax

```js
trace(*args);
```

| Argument | Type  | Description           |
| :------- | :---: | :-------------------- |
| \*args   |  any  | The messages to print |

### Returns

```js
None;
```

### Example

```js
trace("Hello World!");
```

The above code will print "Hello World!" to the console.

---

# alert ![](https://img.shields.io/badge/v1.2.3-3e5f4a?style=flat)

Shows an alert dialog with the message passed as argument. The dialog will stop anything happening in the game until the user clicks the OK button. Server as a shortcut for `show_message`.

### Syntax

```js
alert(message);
```

| Argument |  Type  | Description         |
| :------- | :----: | :------------------ |
| message  | String | The message to show |

### Returns

```js
None;
```

### Example

```js
alert("Hello World!");
```

The above code will show an alert dialog with the message "Hello World!".

---

# alert_async ![](https://img.shields.io/badge/v1.2.3-3e5f4a?style=flat)

Shows an alert dialog with the message passed as argument. The dialog **will not** stop anything happening in the game. Server as a shortcut for `show_message_async`.

### Syntax

```js
alert_async(message);
```

| Argument |  Type  | Description         |
| :------- | :----: | :------------------ |
| message  | String | The message to show |

### Returns

```js
None;
```

### Example

```js
alert_async("Hello World!");
```

The above code will show an alert dialog with the message "Hello World!".

---

# view_get_x ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Gets the X position of the view passed as argument. Serves as a shortcut for `camera_get_view_x(view_camera[view_current])`.

### Syntax

```js
view_get_x([(view = view_current)]);
```

| Argument | Type  | Description                          |
| :------- | :---: | :----------------------------------- |
| view     | Real  | The view to get the X position from. |

### Returns

```js
Real;
```

### Example

```js
var _vw_x = view_get_x();
var _vw_y = view_get_y();

show_debug_message("View X: " + string(_vw_x));
show_debug_message("View Y: " + string(_vw_y));
```

The above code will get the X and Y position of the current view and print them to the console.

---

# view_get_y ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Gets the Y position of the view passed as argument. Serves as a shortcut for `camera_get_view_y(view_camera[view_current])`.

### Syntax

```js
view_get_y([(view = view_current)]);
```

| Argument | Type  | Description                          |
| :------- | :---: | :----------------------------------- |
| view     | Real  | The view to get the Y position from. |

### Returns

```js
Real;
```

### Example

```js
var _vw_x = view_get_x();
var _vw_y = view_get_y();

show_debug_message("View X: " + string(_vw_x));
show_debug_message("View Y: " + string(_vw_y));
```

The above code will get the X and Y position of the current view and print them to the console.

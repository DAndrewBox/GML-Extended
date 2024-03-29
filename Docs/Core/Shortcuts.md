# Shortcuts

### Table of Contents

- [macros](#macros)
- [del](#del)
- [size](#get_size)
- [trace](#trace)
- [alert](#alert)
- [alert_async](#alert_async)
- [view_get_x](#view_get_x)
- [view_get_y](#view_get_y)
- [gui_mouse_x](#gui_mouse_x)
- [gui_mouse_y](#gui_mouse_y)
- [gui_width](#gui_width)
- [gui_height](#gui_height)
- [int](#int)

# Macros

| Name | Description                       |
| :--- | :-------------------------------- |
| str  | Serves as a shortcut for `string` |

# del

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

Returns the size or length of the element. If the element is an array, it will return the length of the array. If the element is a string, it will return the length of the string. If the element is a struct, it will return the number of variables in the struct. If the element is a real, it will return the length of a string of the value.

### Syntax

```js
get_size(element);
```

| Argument |                Type                 | Description                    |
| :------- | :---------------------------------: | :----------------------------- |
| element  | Real, String, Bool, Array or Struct | The element to get the size of |

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

# trace

Prints a message to the console. Serves as a shortcut for `show_debug_message`.

### Syntax

```js
trace(*args);
```

| Argument | Type | Description           |
| :------- | :--: | :-------------------- |
| \*args   | any  | The messages to print |

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

# alert

# alert

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

# alert_async

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

# view_get_x

Gets the X position of the view passed as argument. Serves as a shortcut for `camera_get_view_x(view_camera[view_current])`.

### Syntax

```js
view_get_x([(view = view_current)]);
```

| Argument | Type | Description                          |
| :------- | :--: | :----------------------------------- |
| view     | Real | The view to get the X position from. |

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

# view_get_y

Gets the Y position of the view passed as argument. Serves as a shortcut for `camera_get_view_y(view_camera[view_current])`.

### Syntax

```js
view_get_y([(view = view_current)]);
```

| Argument | Type | Description                          |
| :------- | :--: | :----------------------------------- |
| view     | Real | The view to get the Y position from. |

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

# gui_mouse_x

Gets the X position of the mouse relative to the GUI. Serves as a shortcut for `device_mouse_x_to_gui(0)`.

### Syntax

```js
gui_mouse_x();
```

### Returns

```js
Real;
```

### Example

```js
var _mouse_x = gui_mouse_x();
var _mouse_y = gui_mouse_y();

show_debug_message("Mouse X: " + string(_mouse_x));
show_debug_message("Mouse Y: " + string(_mouse_y));
```

The above code will get the X and Y position of the mouse relative to the GUI and print them to the console.

---

# gui_mouse_y

Gets the Y position of the mouse relative to the GUI. Serves as a shortcut for `device_mouse_y_to_gui(0)`.

### Syntax

```js
gui_mouse_y();
```

### Returns

```js
Real;
```

### Example

```js
var _mouse_x = gui_mouse_x();
var _mouse_y = gui_mouse_y();

show_debug_message("Mouse X: " + string(_mouse_x));
show_debug_message("Mouse Y: " + string(_mouse_y));
```

The above code will get the X and Y position of the mouse relative to the GUI and print them to the console.

---

# gui_width

Gets the width of the GUI. Serves as a shortcut for `display_get_gui_width()`.

### Syntax

```js
gui_width();
```

### Returns

```js
Real;
```

### Example

```js
var _display_gui_width = gui_width();
var _display_gui_height = gui_height();

show_debug_message("GUI Width: " + string(_display_gui_width));
show_debug_message("GUI Height: " + string(_display_gui_height));
```

The above code will get the width and height of the GUI and print them to the console.

---

# gui_height

Gets the width of the GUI. Serves as a shortcut for `display_get_gui_height()`.

### Syntax

```js
gui_height();
```

### Returns

```js
Real;
```

### Example

```js
var _display_gui_width = gui_width();
var _display_gui_height = gui_height();

show_debug_message("GUI Width: " + string(_display_gui_width));
show_debug_message("GUI Height: " + string(_display_gui_height));
```

The above code will get the width and height of the GUI and print them to the console.

---

# int

Converts the argument passed as argument to an integer. Serves as a shortcut for `floor(real(value))`.

### Syntax

```js
int(argument);
```

| Argument | Type | Description        |
| :------- | :--: | :----------------- |
| value    | Real | The value to round |

### Returns

```js
Real;
```

### Example

```js
var _real = 1.5;
var _int = int(_real);

show_debug_message("Real: " + string(_real));
show_debug_message("Int: " + string(_int));
```

The above code will round the real number 1.5 to 1 and print both the real and the integer to the console.

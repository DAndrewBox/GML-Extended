# GUI & Mouse

### Table of Contents

- [macros](#macros)
- [mouse_in_gui_area](#mouse_in_gui_area)
- [mouse_in_area](#mouse_in_area)
- [mouse_in_instance](#mouse_in_instance)
- [mouse_is_moving](#mouse_is_moving)

# macros

| Macro       | Description                                  |                       Introduced in                        |
| :---------- | :------------------------------------------- | :--------------------------------------------------------: |
| gui_width   | The width of the GUI layer                   | ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat) |
| gui_height  | The height of the GUI layer                  | ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat) |
| mouse_gui_x | The x position of the mouse in the GUI layer | ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat) |
| mouse_gui_y | The y position of the mouse in the GUI layer | ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat) |

# mouse_in_gui_area

Returns a boolean if the mouse is inside a GUI area.

### Syntax

```js
mouse_in_gui_area(x1, y1, x2, y2);
```

| Argument | Type  | Description                       |
| :------- | :---: | :-------------------------------- |
| x1       | Real  | The left x position of the area   |
| y1       | Real  | The top y position of the area    |
| x2       | Real  | The right x position of the area  |
| y2       | Real  | The bottom y position of the area |

### Returns

```js
Bool;
```

### Example

```js
if (mouse_in_gui_area(0, 0, gui_width, gui_height)) {
  show_debug_message("Mouse is inside the GUI area");
}
```

The above code will show on console the message `Mouse is inside the GUI area` if the mouse is inside the GUI area.

---

# mouse_in_area

Returns a boolean if the mouse is inside a room area (not GUI).

### Syntax

```js
mouse_in_area(x1, y1, x2, y2);
```

| Argument | Type  | Description                 |
| :------- | :---: | :-------------------------- |
| x1       | Real  | The x1 position of the area |
| y1       | Real  | The y1 position of the area |
| x2       | Real  | The x2 position of the area |
| y2       | Real  | The y2 position of the area |

### Returns

```js
Bool;
```

### Example

```js
if (mouse_in_area(0, 0, room_width, room_height)) {
  show_debug_message("Mouse is inside the room area");
}
```

The above code will show on console the message `Mouse is inside the room area` if the mouse is inside the room area.

---

# mouse_in_instance

Returns a boolean if the mouse is inside an instance boundary box.

### Syntax

```js
mouse_in_instance(inst_id);
```

| Argument | Type  | Description           |
| :------- | :---: | :-------------------- |
| inst_id  | Inst  | The instance to check |

### Returns

```js
Bool;
```

### Example

```js
if (mouse_in_instance(obj_player)) {
  show_debug_message("Mouse is inside the player instance");
}
```

The above code will show on console the message `Mouse is inside the player instance` if the mouse is inside the player instance.

---

# mouse_is_moving

> [!WARNING]
> This function is not available in GameMaker versions before v2024.1.

Returns a boolean if the mouse is moving.

### Syntax

```js
mouse_is_moving();
```

### Returns

```js
Bool;
```

### Example

```js
if (mouse_is_moving()) {
  show_debug_message("Mouse is moving");
}
```

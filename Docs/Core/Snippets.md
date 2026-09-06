# Snippets

### Table of Contents

- [del](#del)
- [get_size](#get_size)
- [contains](#contains)
- [trace](#trace)
- [alert](#alert)
- [alert_async](#alert_async)
- [view_get_x](#view_get_x)
- [view_get_y](#view_get_y)
- [sprite_get_index](#sprite_get_index)
- [object_get_index](#object_get_index)
- [room_get_index](#room_get_index)
- [font_get_index](#font_get_index)
- [sound_get_index](#sound_get_index)
- [rand](#rand)
- [irand](#irand)
- [rand_linear](#rand_linear)
- [trace_once](#trace_once)

# del ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Deletes an instance and executes the destroy event of the object. Serves as a alias for `instance_destroy`.

### Syntax

```js
del(object_index | instance_id, [execute_event = true]);
```

| Argument           |             Type              | Description                                       |
| :----------------- | :---------------------------: | :------------------------------------------------ |
| object_index or id | Id.Instance or Asset.GMObject | The index of the object or the id of the instance |
| execute_event      |             Bool              | Whether to execute the destroy event or not       |

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

| Argument |                     Type                      | Description                    |
| :------- | :-------------------------------------------: | :----------------------------- |
| element  | Real, String, Bool, Array, Struct or DS Id     | The element to get the size of |
| type     |          `gm_type_*` or `ds_type_*`           | The type of the element        |

Data structures are plain numbers at runtime, so they cannot be detected automatically. Pass the matching `ds_type_*` constant as the second argument to size a `ds_list`, `ds_map`, `ds_grid`, `ds_queue`, `ds_stack` or `ds_priority`. A `ds_grid` returns `width * height`. If the id does not point at a live data structure of that type, `-1` is returned.

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

To size a data structure, pass its type:

```js
var _list = ds_list_create();
ds_list_add(_list, "a", "b", "c");

show_debug_message("List size: " + string(get_size(_list, ds_type_list)));
```

The above code will show `List size: 3` on console.

---

# contains ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Checks if an element is inside a container. Serves as a alias for `ds_list_find_index`, `ds_map_find_value`, `ds_grid_value`, `array_find_value`, `string_pos`, and more.

### Syntax

```js
contains(element, container, [container_type]);
```

| Argument       |                     Type                      | Description                                 |
| :------------- | :-------------------------------------------: | :------------------------------------------ |
| element        | Real, String or Bool                          | The element to check if it's inside         |
| container      | Real, String, Array, Struct or DS Id          | The container to check if the element is in |
| container_type |          `gm_type_*` or `ds_type_*`           | The type of the container                   |

Data structures are plain numbers at runtime, so they cannot be detected automatically. Pass `ds_type_list`, `ds_type_map` or `ds_type_grid` as the third argument to search one. A `ds_list` and a `ds_grid` are searched by value, a `ds_map` is searched by key. Every other container type is detected automatically.

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

The above code will check if the element is inside the container. It returns `true` when the element is found and `false` otherwise.

---

# trace ![](https://img.shields.io/badge/v1.2.3-3e5f4a?style=flat)

Prints a message to the console. Serves as a alias for `show_debug_message`.

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

Shows an alert dialog with the message passed as argument. The dialog will stop anything happening in the game until the user clicks the OK button. Server as a alias for `show_message`.

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

Shows an alert dialog with the message passed as argument. The dialog **will not** stop anything happening in the game. Server as a alias for `show_message_async`.

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

Gets the X position of the view passed as argument. Serves as a alias for `camera_get_view_x(view_camera[view_current])`.

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

Gets the Y position of the view passed as argument. Serves as a alias for `camera_get_view_y(view_camera[view_current])`.

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

---

# sprite_get_index ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

A wrapper for `asset_get_index` that gets the index of a sprite by its name and return the sprite with the correct type to use when Feather is enabled.

### Syntax

```js
sprite_get_index(sprite_name);
```

| Argument    |  Type  | Description                                          |
| :---------- | :----: | :--------------------------------------------------- |
| sprite_name | String | The name of the sprite you want to get the index of. |

### Returns

```js
Asset.GMSprite;
```

### Example

```js
var _sprite_index = sprite_get_index("spr_Player");
draw_sprite(_sprite_index, 0, 100, 100);
```

The above code will get the index of the sprite with the name "spr_Player" and draw it at the position (100, 100). Using `sprite_get_index` ensures that the returned value is of type `Asset.GMSprite`, which is compatible with Feather and will not give an error.

---

# object_get_index ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

A wrapper for `asset_get_index` that gets the index of an object by its name and return the object with the correct type to use when Feather is enabled.

### Syntax

```js
object_get_index(object_name);
```

| Argument    |  Type  | Description                                          |
| :---------- | :----: | :--------------------------------------------------- |
| object_name | String | The name of the object you want to get the index of. |

### Returns

```js
Asset.GMObject;
```

### Example

```js
var _object_index = object_get_index("obj_Player");
instance_create_layer(100, 100, "Instances", _object_index);
```

The above code will get the index of the object with the name "obj_Player" and create an instance of it at the position (100, 100) on the "Instances" layer. Using `object_get_index` ensures that the returned value is of type `Asset.GMObject`, which is compatible with Feather and will not give an error.

---

# room_get_index ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

A wrapper for `asset_get_index` that gets the index of a room by its name and return the room with the correct type to use when Feather is enabled.

### Syntax

```js
room_get_index(room_name);
```

| Argument  |  Type  | Description                                        |
| :-------- | :----: | :------------------------------------------------- |
| room_name | String | The name of the room you want to get the index of. |

### Returns

```js
Asset.GMRoom;
```

### Example

```js
var _room_index = room_get_index("rm_Level1");
room_goto(_room_index);
```

The above code will get the index of the room with the name "rm_Level1" and switch to that room. Using `room_get_index` ensures that the returned value is of type `Asset.GMRoom`, which is compatible with Feather and will not give an error.

---

# font_get_index ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

A wrapper for `asset_get_index` that gets the index of a font by its name and return the font with the correct type to use when Feather is enabled.

### Syntax

```js
font_get_index(font_name);
```

| Argument  |  Type  | Description                                        |
| :-------- | :----: | :------------------------------------------------- |
| font_name | String | The name of the font you want to get the index of. |

### Returns

```js
Asset.GMFont;
```

### Example

```js
var _font_index = font_get_index("fnt_Main");
draw_set_font(_font_index);
draw_text(100, 100, "Hello World!");
```

The above code will get the index of the font with the name "fnt_Main", set it as the current font, and draw the text "Hello World!" at the position (100, 100). Using `font_get_index` ensures that the returned value is of type `Asset.GMFont`, which is compatible with Feather and will not give an error.

---

# sound_get_index ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

A wrapper for `asset_get_index` that gets the index of a sound by its name and return the sound with the correct type to use when Feather is enabled.

### Syntax

```js
sound_get_index(sound_name);
```

| Argument   |  Type  | Description                                         |
| :--------- | :----: | :-------------------------------------------------- |
| sound_name | String | The name of the sound you want to get the index of. |

### Returns

```js
Asset.GMSound;
```

### Example

```js
var _sound_index = sound_get_index("snd_Jump");
audio_play_sound(_sound_index, 1, false);
```

The above code will get the index of the sound with the name "snd_Jump" and play it once. Using `sound_get_index` ensures that the returned value is of type `Asset.GMSound`, which is compatible with Feather and will not give an error.

---

# rand ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

Snippet for `random` and `random_range`. If only one argument is provided, `random` is used, if two parameters are provided, it uses `random_range`.

### Syntax

```js
rand(n1, [n2 = undefined]);
```

| Argument | Type  | Description                                                                    |
| :------- | :---: | :----------------------------------------------------------------------------- |
| n1       | Real  | The minimum value to check. If 'n2' is not provided this is the maximum value. |
| n2       | Real  | The maximum value to check.                                                    |

### Returns

```js
Real;
```

### Example

```js
var _val1 = rand(10);       // Random value between 0 and 10
var _val2 = rand(5, 15);   // Random value between 5 and 15

show_debug_message("Random value 1: " + string(_val1));
show_debug_message("Random value 2: " + string(_val2));
```

The above code will return a random value between `0` and `10` for `_val1`, and a random value between `5` and `15` for `_val2`. Then it will show the random values on console.

---

# irand ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

Snippet for `irandom` and `irandom_range`. If only one argument is provided, `irandom` is used, if two parameters are provided, it uses `irandom_range`.

### Syntax

```js
irand(n1, [n2 = undefined]);
```

| Argument | Type  | Description                                                                    |
| :------- | :---: | :----------------------------------------------------------------------------- |
| n1       | Real  | The minimum value to check. If 'n2' is not provided this is the maximum value. |
| n2       | Real  | The maximum value to check.                                                    |

### Returns

```js
Real;
```

### Example

```js
var _val1 = irand(10);       // Random integer between 0 and 10
var _val2 = irand(5, 15);   // Random integer between 5 and 15

show_debug_message("Random integer 1: " + string(_val1));
show_debug_message("Random integer 2: " + string(_val2));
```

The above code will return a random integer between `0` and `10` for `_val1`, and a random integer between `5` and `15` for `_val2`. Then it will show the random integers on console.

---

# rand_linear ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

Snippet for `random_linear` and `random_linear_range`. If only one argument is provided, `random_linear` is used, if two parameters are provided, it uses `random_linear_range`.

### Syntax

```js
rand_linear(n1, [n2 = undefined]);
```

| Argument | Type  | Description                                                                    |
| :------- | :---: | :----------------------------------------------------------------------------- |
| n1       | Real  | The minimum value to check. If 'n2' is not provided this is the maximum value. |
| n2       | Real  | The maximum value to check.                                                    |

### Returns

```js
Real;
```

### Example

```js
var _val1 = rand_linear(10);       // Random value with linear distribution between 0 and 10
var _val2 = rand_linear(5, 15);   // Random value with linear distribution between 5 and 15

show_debug_message("Random linear value 1: " + string(_val1));
show_debug_message("Random linear value 2: " + string(_val2));
```

The above code will return a random value with a linear distribution between `0` and `10` for `_val1`, and a random value with a linear distribution between `5` and `15` for `_val2`. Then it will show the random values on console.

---

---

# trace_once ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Prints a message to the console the first time it is used and ignores it from then on. Useful inside a Step event where [trace](#trace) would spam the log every frame. Messages are told apart by their text, so a message carrying a changing value prints again every time that value changes.

### Syntax

```js
trace_once(*args);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| *args          | Any                      | The messages to print |

### Returns

```js
Undefined;
```

### Example

```js
// Step event, prints only on the first frame the state is wrong
if (state == undefined) {
  trace_once("Enemy ", id, " has no state!");
}
```

---

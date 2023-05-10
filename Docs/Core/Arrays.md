# Arrays

### Table of Contents

- [array_fill](#array_fill)
- [array_clear](#array_clear)
- [array_empty](#array_empty)
- [array_find_index_by_value](#array_find_index_by_value)
- [array_to_ds_list](#array_to_ds_list)
- [ds_list_to_array](#ds_list_to_array)
- [array_to_struct](#array_to_struct)
- [array_write](#array_write)
- [array_shuffle](#array_shuffle)

---

# array_fill

Fills an array with a value.

### Syntax

```js
array_fill(array, value);
```

| Argument | Type  | Description                      |
| :------- | :---: | :------------------------------- |
| array    | array | The array to fill                |
| value    |  any  | The value to fill the array with |

### Returns

```js
None;
```

### Example

```js
var _array = [0, 1, 2, 3, 4];
array_fill(_array, 1);
```

The above code will set `[1, 1, 1, 1, 1]` into the `_array` variable.

---

# array_clear

Clears an array filling with undefined values to clear memory.

### Syntax

```js
array_clear(array);
```

| Argument | Type  | Description        |
| :------- | :---: | :----------------- |
| array    | array | The array to clear |

### Returns

```js
None;
```

### Example

```js
var _array = [0, 1, 2, 3, 4];
array_clear(_array);
show_debug_message(_array);
```

The above code will clear the `_array` variable and show it as `[]` on the line 3.

---

# array_empty

Checks if an array is empty and returns a boolean.

### Syntax

```js
array_empty(array);
```

| Argument | Type  | Description        |
| :------- | :---: | :----------------- |
| array    | array | The array to check |

### Returns

```js
Bool;
```

### Example

```js
var _array = [0, 1, 2, 3, 4];
var _is_empty = array_empty(_array);
show_debug_message(_is_empty);
```

The above code will return `false` since the var `_array` is not empty.

---

# array_find_index_by_value

Checks if a value is inside the array, and then returns its index, else, returns -1.

### Syntax

```js
array_find_index_by_value(array, value);
```

| Argument | Type  | Description              |
| :------- | :---: | :----------------------- |
| array    | array | The array to search into |
| value    |  any  | The value to find        |

### Returns

```js
Real or -1
```

### Example

```js
var _array = ["a", 1, 3, "b", 5];
var _index = array_find_index_by_value(_array, "b");
show_debug_message(_index);
```

The above code will return `3` since `b` is on the array and it"s index is 3 from 0 to it"s position.

---

# array_to_ds_list

Returns the array as a ds list with all its values.

### Syntax

```js
array_to_ds_list(array);
```

| Argument | Type  | Description          |
| :------- | :---: | :------------------- |
| array    | array | The array to convert |

### Returns

```js
ds_list;
```

### Example

```js
var _array = ["a", 1, 3, "b", 5];
var _list = array_to_ds_list(_array);
show_debug_message(_list[| 0]);
```

The above code will show `a` since it"s the first value of the list.

---

# ds_list_to_array

Converts a ds list to an array with all its values and the returns it.

### Syntax

```js
ds_list_to_array(list);
```

| Argument |  Type   | Description                    |
| :------- | :-----: | :----------------------------- |
| list     | ds_list | The list to convert into array |

### Returns

```js
Array;
```

### Example

```js
var _list = ds_list_create();
_list[| 0] = "a";
_list[| 1] = 1;
_list[| 2] = 3;

var _array = ds_list_to_array(_list);
show_debug_message(_array);
```

The above code will show `["a", 1, 3]` since those are tha values of the list converted into an array.

---

# array_to_struct

Returns the array as a struct with all its values inside numeric keys. 2D arrays will be converted to structs with arrays inside and not to a 2D struct.

### Syntax

```js
array_to_struct(array);
```

| Argument | Type  | Description          |
| :------- | :---: | :------------------- |
| array    | array | The array to convert |

### Returns

```js
Struct;
```

### Example

```js
var _array = ["a", 1, [0, 2]];
var _struct = array_to_struct(_array);
show_debug_message(_struct);
```

The above code will show
`{
  0: "a",
  1: 1,
  2: [0, 2]
}`
since those are tha values of the array converted into an struct.

---

# array_write

Returns an string of the array. If there are strings on the array, they will have be formatted as `"10"`, but numbers will be formatted as `10`.

### Syntax

```js
array_write(array);
```

| Argument | Type  | Description        |
| :------- | :---: | :----------------- |
| array    | array | The array to write |

### Returns

```js
String;
```

### Example

```js
var _array = ["a", 1, 3, 4];
var _string = array_write(_array);
show_debug_message(_string);
```

The above code will show `["a", 1, 3, 4]`.

---

# array_shuffle

Shuffles the array and returns it.

### Syntax

```js
array_shuffle(array);
```

| Argument | Type  | Description          |
| :------- | :---: | :------------------- |
| array    | array | The array to shuffle |

### Returns

```js
Array;
```

### Example

```js
var _array = [0, 1, 2, 3];
var _new_array = array_shuffle(_array);

show_debug_message(_new_array);
```

The above code will show a randomly shuffled array.

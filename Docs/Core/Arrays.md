# Arrays

### Table of Contents

- [array_fill](#array_fill)
- [array_clear](#array_clear)
- [array_empty](#array_empty)
- [array_find_index_by_value](#array_find_index_by_value)
- [array_to_ds_list](#array_to_ds_list)
- [ds_list_to_array](#ds_list_to_array)
- [array_to_struct](#array_to_struct)
- [array_chunk](#array_chunk)
- [array_flatten](#array_flatten)
- [array_group_by](#array_group_by)
- [array_sum](#array_sum)
- [array_mean](#array_mean)
- [array_median](#array_median)
- [array_sample](#array_sample)
- [array_swap](#array_swap)
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

# array_find_index_by_value ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Checks if a value is inside the array, and then returns its index, else, returns -1.

### Syntax

```js
array_find_index_by_value(array, value);
```

| Argument | Type  | Description              |
| :------- | :---: | :----------------------- |
| array    | Array | The array to search into |
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
Id.DsList;
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

| Argument |   Type    | Description                    |
| :------- | :-------: | :----------------------------- |
| list     | Id.DsList | The list to convert into array |

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
| array    | Array | The array to convert |

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

# array_shuffle ![](https://img.shields.io/badge/v1.1.0-59708c?style=flat)

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

# array_chunk ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns an array of arrays, each one holding at most `size` elements of the original array. The last chunk holds the remainder. An empty array is returned if `size` is 0 or less.

### Syntax

```js
array_chunk(array, size);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to split |
| size           | Real                     | Max number of elements per chunk |

### Returns

```js
Array<Array>;
```

### Example

```js
var _pages = array_chunk(global.inventory, 8);
show_debug_message(array_length(_pages)); // one entry per inventory page
```

---

# array_flatten ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a new array with the nested arrays unwrapped up to the given depth. A depth of 0 returns a copy of the array as it is. The original array is left untouched.

### Syntax

```js
array_flatten(array, [(depth = infinity)]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to flatten |
| depth          | Real                     | How many levels of nesting to unwrap |

### Returns

```js
Array;
```

### Example

```js
show_debug_message(array_flatten([1, [2, [3, [4]]]])); // [1, 2, 3, 4]
show_debug_message(array_flatten([1, [2, [3]]], 1)); // [1, 2, [3]]
```

---

# array_group_by ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a struct where every key is a value returned by the callback and every value is the array of elements that returned it. The callback receives the element and its index, and its result is always converted to a string.

### Syntax

```js
array_group_by(array, callback);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to group |
| callback       | Function                 | Receives `(element, index)` and returns the key |

### Returns

```js
Struct;
```

### Example

```js
var _by_type = array_group_by(global.enemies, function (_enemy) {
  return _enemy.type;
});

show_debug_message(array_length(_by_type.flying));
```

---

# array_sum ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the sum of every numeric element of the array. Elements that are not numbers are ignored, so an array without numbers returns 0.

### Syntax

```js
array_sum(array);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to add up |

### Returns

```js
Real;
```

### Example

```js
show_debug_message(array_sum([1, 2, 3, 4])); // 10
```

---

# array_mean ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the average of every numeric element of the array. Elements that are not numbers are ignored and do not count towards the average, so an array without numbers returns 0.

### Syntax

```js
array_mean(array);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to average |

### Returns

```js
Real;
```

### Example

```js
show_debug_message(array_mean([10, 20, 30])); // 20
```

---

# array_median ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the median of every numeric element of the array. With an even amount of numbers the average of the two middle ones is returned. Elements that are not numbers are ignored, and the original array is never reordered.

### Syntax

```js
array_median(array);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to get the median of |

### Returns

```js
Real;
```

### Example

```js
show_debug_message(array_median([5, 1, 3])); // 3
show_debug_message(array_median([1, 2, 3, 4])); // 2.5
```

---

# array_sample ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns an array with `count` random elements of the given array. An element is never taken twice unless `unique` is set to `false`, so an unique sample is capped to the length of the array. Always returns an array, even for a single element, and never reorders the original.

### Syntax

```js
array_sample(array, [(count = 1)], [(unique = true)]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to take the elements from |
| count          | Real                     | How many elements to take |
| unique         | Bool                     | Never take the same element twice |

### Returns

```js
Array;
```

### Example

```js
var _hand = array_sample(global.deck, 5);
var _roll = array_sample(["a", "b"], 3, false); // repeats allowed
```

---

# array_swap ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Swaps two elements of an array in place and returns the same array. Nothing is changed if any of the indexes is out of bounds.

### Syntax

```js
array_swap(array, index1, index2);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| array          | Array                    | The array to modify |
| index1         | Real                     | The index of the first element |
| index2         | Real                     | The index of the second element |

### Returns

```js
Array;
```

### Example

```js
var _arr = [1, 2, 3];
array_swap(_arr, 0, 2);
show_debug_message(_arr); // [3, 2, 1]
```

---

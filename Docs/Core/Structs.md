# Structs

### Table of Contents

- [struct_keys](#struct_keys)
- [struct_merge](#struct_merge)
- [struct_key_exists](#struct_key_exists)
- [struct_equal](#struct_equal)
- [struct_entries](#struct_entries)

---

# struct_keys

Returns an array with the keys of a struct. Same behavior as [variable_struct_get_names](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Variable_Functions/variable_struct_get_names.htm).

### Syntax

```js
struct_keys(struct);
```

| Argument |  Type  | Description                |
| :------- | :----: | :------------------------- |
| struct   | Struct | The struct to get the keys |

### Returns

```js
Array (each entry is a string)
```

### Example

```js
var _str = "";
var _array = variable_struct_get_names(_my_struct);
show_debug_message("Variables for struct: " + string(_array));
for (var i = 0; i < array_length(_array); i++;) {
    _str = _array[i] + ":" + string(variable_struct_get(_my_struct, _array[i]));
    show_debug_message(_str);
}
```

The above code will show on console the keys and values of the struct.

---

# struct_merge

Return a merged struct from 2 different structs. If the key exists in both structs, the value of the second struct will be used by default (unless the `override` argument is set to `false`).

### Syntax

```js
struct_merge(struct1, struct2, [(override = true)]);
```

| Argument |  Type   | Description                                                                     |
| :------- | :-----: | :------------------------------------------------------------------------------ |
| struct1  | Struct  | The first struct to merge                                                       |
| struct2  | Struct  | The second struct to merge                                                      |
| override | Boolean | Override the values of the first struct with the second struct (default = true) |

### Returns

```js
Struct;
```

### Example

```js
var _struct1 = {
  key1: "value1",
  key2: "value2",
};
var _struct2 = {
  key2: "value99",
  key3: "value3",
};
var _struct3 = struct_merge(_struct1, _struct2);

show_debug_message("New struct: " + string(_struct1));
```

The above code will merge the structs `_struct1` and `_struct2` and show on console the result on `_struct3` (the values of `key2` will be overriden by the second struct).

The output will be:

```js
New Struct: {
  "key1": "value1",
  "key2": "value99",
  "key3": "value3"
}
```

---

# struct_key_exists ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Returns `true` if the key exists in the struct, `false` otherwise.

### Syntax

```js
struct_key_exists(struct, key);
```

| Argument |  Type  | Description                |
| :------- | :----: | :------------------------- |
| struct   | Struct | The struct to get the keys |
| key      | String | The key to check           |

### Returns

```js
Boolean;
```

### Example

```js
var _struct = {
  key1: "value1",
  key2: "value2",
};

show_debug_message(
  "Key 'key1' exists: " + string(struct_key_exists(_struct, "key1"))
);
```

The above code will show on console `true` if the key `key1` exists in the struct `_struct`.

---

# struct_equal ![](https://img.shields.io/badge/v1.4.0-916800?style=flat)

Returns `true` if the structs are equal, `false` otherwise.

### Syntax

```js
struct_equal(struct1, struct2);
```

| Argument |  Type  | Description                |
| :------- | :----: | :------------------------- |
| struct1  | Struct | The first struct to check  |
| struct2  | Struct | The second struct to check |

### Returns

```js
Boolean;
```

### Example

```js
var _struct1 = {
  key1: "value1",
  key2: "value2",
};

var _struct2 = {
  key1: "value1",
  key2: "value2",
};

show_debug_message(
  "Structs are equal: " + string(struct_equal(_struct1, _struct2))
);
```

The above code will show on console `true` if the structs `_struct1` and `_struct2` are equal.

---

# struct_entries ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)

Returns an array with the entries of a struct. Each entry is an array with 2 elements: the key and the value.

### Syntax

```js
struct_entries(struct);
```

| Argument |  Type  | Description                   |
| :------- | :----: | :---------------------------- |
| struct   | Struct | The struct to get the entries |

### Returns

```js
Array<[key, value]>
```

### Example

```js
var _my_struct = {
  key1: "value1",
  key2: "value2",
  key3: "value3",
};
var _str = "";
var _array = struct_entries(_my_struct);
show_debug_message("Entries for struct: " + string(_array));
for (var i = 0; i < array_length(_array); i++;) {
    _str = _array[i][0] + ":" + string(_array[i][1]);
    show_debug_message(_str);
}
```

The above code will show on console the keys and values of the struct. The output will be:

```js
Entries for struct: [["key1","value1"],["key2","value2"],["key3","value3"]]
key1:value1
key2:value2
key3:value3
```

---

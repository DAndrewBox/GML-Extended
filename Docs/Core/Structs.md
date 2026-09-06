# Structs

### Table of Contents

- [struct_keys](#struct_keys)
- [struct_merge](#struct_merge)
- [struct_key_exists](#struct_key_exists)
- [struct_equal](#struct_equal)
- [struct_entries](#struct_entries)
- [struct_filter](#struct_filter)
- [struct_map](#struct_map)
- [struct_reduce](#struct_reduce)
- [struct_get_path](#struct_get_path)
- [struct_flatten](#struct_flatten)

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

Nested structs are merged key by key, and since `v1.6.0` nested arrays are merged index by index. When the same index of both arrays holds a struct, those structs are merged too, so an array of structs keeps the keys of both sides. Any element past the end of the first array is appended. The returned struct is a deep copy, so it never shares a struct or array reference with either source.

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

Compare two structs and returns a boolean to check if the structs are equal.

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

---

# struct_filter ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a new struct holding only the entries the callback returned `true` for. The original struct is left untouched.

### Syntax

```js
struct_filter(struct, callback);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| struct         | Struct                   | The struct to filter |
| callback       | Function                 | Receives `(key, value)` and returns whether to keep it |

### Returns

```js
Struct;
```

### Example

```js
var _alive = struct_filter(global.players, function (_key, _player) {
  return _player.hp > 0;
});
```

---

# struct_map ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a new struct with the same keys, where every value is the result of the callback. The original struct is left untouched.

### Syntax

```js
struct_map(struct, callback);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| struct         | Struct                   | The struct to map |
| callback       | Function                 | Receives `(key, value)` and returns the new value |

### Returns

```js
Struct;
```

### Example

```js
var _doubled = struct_map({ a: 1, b: 2 }, function (_key, _value) {
  return _value * 2;
});

show_debug_message(_doubled.b); // 4
```

---

# struct_reduce ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Runs the callback over every entry of the struct carrying an accumulator, and returns the final accumulator. Key order is not guaranteed, so the callback should not depend on it.

### Syntax

```js
struct_reduce(struct, callback, [(initial = undefined)]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| struct         | Struct                   | The struct to reduce |
| callback       | Function                 | Receives `(accumulator, key, value)` |
| initial        | Any                      | The value the accumulator starts with |

### Returns

```js
Any;
```

### Example

```js
var _total = struct_reduce(global.cart, function (_acc, _key, _item) {
  return _acc + _item.price;
}, 0);
```

---

# struct_get_path ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Reads a nested value without having to check every level first. A numeric step walks into an array, so `"items.0.name"` is a valid path. Returns the default value as soon as any step of the path is missing, which makes it safe to use on parsed JSON.

### Syntax

```js
struct_get_path(struct, path, [(default = undefined)]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| struct         | Struct                   | The struct to read from |
| path           | String                   | Dot separated path, e.g. `"player.stats.hp"` |
| default        | Any                      | Returned when the path does not exist |

### Returns

```js
Any;
```

### Example

```js
var _save = file_json_read(_file);

var _hp = struct_get_path(_save, "player.stats.hp", 100);
var _first = struct_get_path(_save, "player.items.0.name", "none");
```

---

# struct_flatten ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a single level struct where every nested key becomes a path, so `{a: {b: 1}}` becomes `{"a.b": 1}`. Arrays are kept as a single value, and an empty struct is kept as a value too. The resulting keys can be read back with [struct_get_path](#struct_get_path).

### Syntax

```js
struct_flatten(struct, [(separator = ".")]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| struct         | Struct                   | The struct to flatten |
| separator      | String                   | Text joining the keys of every level |

### Returns

```js
Struct;
```

### Example

```js
var _flat = struct_flatten({ audio: { music: 0.5, sfx: 0.8 } });

show_debug_message(_flat[$ "audio.music"]); // 0.5
```

---

# Structs

### Table of Contents

- [struct_keys](#struct_keys)
- [struct_merge](#struct_merge)
- [struct_key_exists](#struct_key_exists)

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

# struct_key_exists

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
Boolean
```

### Example

```js
var _struct = {
  key1: "value1",
  key2: "value2",
};

show_debug_message("Key 'key1' exists: " + string(struct_key_exists(_struct, "key1")));
```

The above code will show on console `true` if the key `key1` exists in the struct `_struct`.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Strings.md">Strings</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Surfaces.md">Surfaces</a>
    </h3>
  </div>
</div>

# Types

### Table of Contents

- [macros](#macros)
- [str](#str)
- [int](#int)
- [int8](#int8)
- [int16](#int16)
- [int8s](#int8s)
- [int16s](#int16s)
- [is_type](#is_type)

# macros

| Macro             | Description                                                            | Value                     |
| :---------------- | :--------------------------------------------------------------------- | :------------------------ |
| gm_type_number    | The built-in number type                                               | "number"                  |
| gm_type_string    | The built-in string type                                               | "string"                  |
| gm_type_array     | The built-in array type                                                | "array"                   |
| gm_type_bool      | The built-in boolean type                                              | "bool"                    |
| gm_type_int32     | The built-in int32 type                                                | "int32"                   |
| gm_type_int64     | The built-in int64 type                                                | "int64"                   |
| gm_type_pointer   | The built-in pointer type                                              | "pointer"                 |
| gm_type_undefined | The built-in undefined type                                            | "undefined"               |
| gm_type_method    | The built-in method type                                               | "method"                  |
| gm_type_struct    | The built-in struct type                                               | "struct"                  |
| gm_type_reference | The built-in reference type                                            | "ref"                     |
| gm_type_unknown   | The unknown type. Should never be used but its build-in into GameMaker | "unknown"                 |
| null              | The null value                                                         | pointer_null              |
| gm_unit_seconds   | The unit of time in seconds                                            | time_source_units_seconds |
| gm_unit_frames    | The unit of time in frames                                             | time_source_units_frames  |

# str ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Converts a value to a string.

### Syntax

```js
str(value);
```

| Argument | Type  | Description                      |
| :------- | :---: | :------------------------------- |
| value    |  Any  | The value to convert to a string |

### Returns

```js
String;
```

### Example

```js
var str_value = str(10);
```

The above code will convert the number 10 to a string.

---

# int ![](https://img.shields.io/badge/v1.4.0-916800?style=flat)

Converts a value to an integer.

### Syntax

```js
int(value);
```

| Argument | Type  | Description                        |
| :------- | :---: | :--------------------------------- |
| value    |  Any  | The value to convert to an integer |

### Returns

```js
Real;
```

### Example

```js
var int_value = int(10.5);
```

The above code will convert the number 10.5 to an integer. The result will be 10.

---

# int8 ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Converts a value to an 8-bit integer.

### Syntax

```js
int8(value);
```

| Argument | Type  | Description                              |
| :------- | :---: | :--------------------------------------- |
| value    |  Any  | The value to convert to an 8-bit integer |

### Returns

```js
Real;
```

### Example

```js
var int8_value = int8(300);
```

The above code will convert the number 300 to an 8-bit integer. The result will be 44 since 300 is out of the 8-bit not signed integer range, so it will wrap around.

---

# int16 ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Converts a value to a 16-bit integer.

### Syntax

```js
int16(value);
```

| Argument | Type  | Description                              |
| :------- | :---: | :--------------------------------------- |
| value    |  Any  | The value to convert to a 16-bit integer |

### Returns

```js
Real;
```

### Example

```js
var int16_value = int16(100000);
```

The above code will convert the number 100000 to a 16-bit integer. The result will be 34464 since 100000 is out of the 16-bit not signed integer range, so it will wrap around.

---

# int8s ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Converts a value to an 8-bit signed integer.

### Syntax

```js
int8s(value);
```

| Argument | Type  | Description                                     |
| :------- | :---: | :---------------------------------------------- |
| value    |  Any  | The value to convert to an 8-bit signed integer |

### Returns

```js
Real;
```

### Example

```js
var int8s_value = int8s(200);
```

The above code will convert the number 200 to an 8-bit signed integer. The result will be -56 since 200 is out of the 8-bit signed integer range, so it will wrap around.

---

# int16s ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Converts a value to a 16-bit signed integer.

### Syntax

```js
int16s(value);
```

| Argument | Type  | Description                                     |
| :------- | :---: | :---------------------------------------------- |
| value    |  Any  | The value to convert to a 16-bit signed integer |

### Returns

```js
Real;
```

### Example

```js
var int16s_value = int16s(100000);
```

The above code will convert the number 100000 to a 16-bit signed integer. The result will be -31072 since 100000 is out of the 16-bit signed integer range, so it will wrap around.

---

# is_type ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Checks if a value is of a specific type.

### Syntax

```js
is_type(value, type);
```

| Argument |      Type       | Description                                                 |
| :------- | :-------------: | :---------------------------------------------------------- |
| value    |       Any       | The value to check the type of                              |
| type     | String or Array | The type to check the value with, can be an array of types. |

### Returns

```js
Bool;
```

### Example

```js
if (is_type(10, gm_type_number)) {
  show_debug_message("The value is a number");
}
```

The above code will show on console the message `The value is a number` if the value is a number.

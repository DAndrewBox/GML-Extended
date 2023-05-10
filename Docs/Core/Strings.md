# Strings

### Table of Contents

- [string_pad_left](#string_pad_left)
- [string_pad_right](#string_pad_right)
- [string_contains](#string_contains)
- [string_title](#string_title)
- [string_remove](#string_remove)

---

# string_pad_left

Returns a string with the specified number of characters on the left side. If the string is already bigger than the specified size, the string will be returned as is. If the string is smaller than the specified size, the string will be filled with the specified character on the left side.

### Syntax

```js
string_pad_left(string, char, size);
```

| Argument |  Type  | Description                      |
| :------- | :----: | :------------------------------- |
| string   | String | The string to fill               |
| char     | String | The character to fill the string |
| size     |  Int   | The final size of the string     |

### Returns

```js
String;
```

### Example

```js
var _str = "123";
var _size = 9;
var _score_str = string_pad_left(_str, "0", _size);

show_debug_message(_str_filled);
```

The above code will set the var `_str_filled` as an string filled with 0's on the left side and the show on console. The result will be `000000123`.

---

# string_pad_right

Returns a string with the specified number of characters on the right side. If the string is already bigger than the specified size, the string will be returned as is. If the string is smaller than the specified size, the string will be filled with the specified character on the right side.

### Syntax

```js
string_pad_left(string, char, size);
```

| Argument |  Type  | Description                      |
| :------- | :----: | :------------------------------- |
| string   | String | The string to fill               |
| char     | String | The character to fill the string |
| size     |  Int   | The final size of the string     |

### Returns

```js
String;
```

### Example

```js
var _str = "123";
var _size = 9;
var _score_str = string_pad_right(_str, "0", _size);

show_debug_message(_str_filled);
```

The above code will set the var `_str_filled` as an string filled with 0's on the right side and the show on console. The result will be `123000000`.

---

# string_split

Returns an array from a string divided on substrings by a separator.

### Syntax

```js
string_split(string, separator);
```

| Argument  |  Type  | Description                        |
| :-------- | :----: | :--------------------------------- |
| string    | String | The string to strip                |
| separator | String | The separator to divide the string |

### Returns

```js
Array;
```

### Example

```js
var _str = "Hello, World!";
var _sep = ", ";
var _str_arr = string_split(_str, _sep);

show_debug_message(_str_arr);
```

The above code will set the var `_str_arr` as an array with the string divided on substrings and the show on console. The result will be `["Hello", "World!"]`.

---

# string_contains

Returns true if the string contains the substring.

### Syntax

```js
string_contains(string, substring);
```

| Argument  |  Type  | Description          |
| :-------- | :----: | :------------------- |
| string    | String | The string to check  |
| substring | String | The substring to use |

### Returns

```js
Bool;
```

### Example

```js
var _str = "Hello, World!";
var _sub = "World";

if (string_contains(_str, _sub)) {
  show_debug_message("World found!");
}
```

The above code will show on console the message `World Found!` since the string contains the substring.

---

# string_title

Returns a string with the first letter of each word capitalized.

### Syntax

```js
string_title(string);
```

| Argument |  Type  | Description         |
| :------- | :----: | :------------------ |
| string   | String | The string to check |

### Returns

```js
String;
```

### Example

```js
var _str = "hello world!";
show_debug_message(string_title(_str));
```

The above code will show on console the message `Hello World!`.

---

# string_remove

Returns a string with the specified substring removed.

### Syntax

```js
string_remove(string, substring);
```

| Argument  |      Type       | Description                              |
| :-------- | :-------------: | :--------------------------------------- |
| string    |     String      | The string to check                      |
| substring | String or Array | The array of strings or substring to use |

### Returns

```js
String;
```

### Example

```js
var _str = "Hello, World!";
var _sub = ["Hello", "World"];

show_debug_message(string_remove(_str, _sub));
```

The above code will show on console the message `, !` since the substring was removed.

---

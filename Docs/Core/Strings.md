# Strings

### Table of Contents

- [string_contains](#string_contains)
- [string_title](#string_title)
- [string_remove](#string_remove)
- [string_remove_duplicate_chars](#string_remove_duplicate_chars)
- [string_pad_left](#string_pad_left)
- [string_pad_right](#string_pad_right)
- [string_percentage](#string_percentage)
- [string_truncate](#string_truncate)
- [string_to_snake](#string_to_snake)
- [string_to_camel](#string_to_camel)
- [string_slugify](#string_slugify)

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

# string_title ![](https://img.shields.io/badge/v1.2.2-3e5f4a?style=flat)

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

# string_remove_duplicate_chars ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a string where every run of the given character is collapsed into a single one. Useful to turn double spaces into one space, `..` into `.`, and so on. The character can also be a multi character sequence.

### Syntax

```js
string_remove_duplicate_chars(string, [(char = " ")]);
```

| Argument |  Type  | Description                                        |
| :------- | :----: | :------------------------------------------------- |
| string   | String | The string to clean up                             |
| char     | String | The character or sequence to collapse (default " ") |

### Returns

```js
String;
```

### Example

```js
show_debug_message(string_remove_duplicate_chars("Hello    World"));      // "Hello World"
show_debug_message(string_remove_duplicate_chars("Wait...", "."));        // "Wait."
show_debug_message(string_remove_duplicate_chars("a---b", "-"));          // "a-b"
```

The above code collapses every run of the given character into a single one. Passing an empty `char` returns the string unchanged.

---

# string_pad_left ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

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

# string_pad_right ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

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

# string_percentage

Returns a string with the percentage of the given values.

### Syntax

```js
string_percentage(current_value, total_value);
```

| Argument      | Type  | Description                |
| :------------ | :---: | :------------------------- |
| current_value | Real  | The current value          |
| total_value   | Real  | The total value to compare |

### Returns

```js
String;
```

### Example

```js
var _current = 10;
var _total = 100;

show_debug_message(string_percentage(_current, _total));
```

The above code will show on console the message `10%` since the current value is 10% of the total value.

# string_truncate ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a string no longer than `max_length`, adding the suffix at the end when it had to be cut. If the suffix does not fit in `max_length` the suffix itself is cut instead.

### Syntax

```js
string_truncate(string, max_length, [(suffix = "...")]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| string         | String                   | The string to truncate |
| max_length     | Real                     | Max length of the result, suffix included |
| suffix         | String                   | Text added when the string is cut (default `"..."`) |

### Returns

```js
String;
```

### Example

```js
show_debug_message(string_truncate("A very long item name", 10)); // "A very ..."
show_debug_message(string_truncate("Short", 10)); // "Short"
```

---

# string_to_snake ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the string in `snake_case`. Spaces, dashes and underscores separate words, and a capital letter right after a lowercase one starts a new word.

### Syntax

```js
string_to_snake(string);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| string         | String                   | The string to convert |

### Returns

```js
String;
```

### Example

```js
show_debug_message(string_to_snake("Hello World")); // "hello_world"
show_debug_message(string_to_snake("myVariableName")); // "my_variable_name"
```

---

# string_to_camel ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the string in `camelCase`. Spaces, dashes and underscores separate words, the first letter is always lowercased and every following word is capitalized.

### Syntax

```js
string_to_camel(string);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| string         | String                   | The string to convert |

### Returns

```js
String;
```

### Example

```js
show_debug_message(string_to_camel("hello_world")); // "helloWorld"
show_debug_message(string_to_camel("My Cool Key")); // "myCoolKey"
```

---

# string_slugify ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a lowercase URL friendly version of the string. Letters and digits are always kept, every character listed in `allowed` is kept too, and any run of the remaining characters becomes a single separator. Leading and trailing separators are removed.

### Syntax

```js
string_slugify(string, [(allowed = "")], [(separator = "-")]);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| string         | String                   | The string to convert |
| allowed        | String                   | Special characters to keep as they are |
| separator      | String                   | Text replacing every other character (default `"-"`) |

### Returns

```js
String;
```

### Example

```js
show_debug_message(string_slugify("My Cool Game Title!")); // "my-cool-game-title"
show_debug_message(string_slugify("save_file.02", "_.")); // "save_file.02"
```

---

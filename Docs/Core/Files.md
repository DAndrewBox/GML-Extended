# Files

### Table of Contents

- [file_text_read_whole](#file_text_read_whole)
- [file_json_read](#file_json_read)
- [file_text_get_lines_array](#file_text_get_lines_array)
- [file_json_create](#file_json_create)

---

# file_text_read_whole ![](https://img.shields.io/badge/v1.2.2-3e5f4a?style=flat)

Read all lines of a file and returns it as a string. If there's no file previously opened, it will return an empty string. To open files view the [official manual page](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Text_Files/file_text_open_read.htm) about it.

### Syntax

```js
file_text_read_whole(file);
```

| Argument |    Type     | Description                 |
| :------- | :---------: | :-------------------------- |
| file     | Id.TextFile | The id of the file to check |

### Returns

```js
String;
```

### Example

```js
var _file = file_text_open_read("./my_file.txt");
var _str = file_text_read_whole(_file);
file_text_close(_file);

show_debug_message("File content: " + _str);
```

The above code will set the var `_str` as an string of the whole file and the show on console if the file exitst.

---

# file_json_read ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Read all lines file and returns it as a struct. If there's no file previously opened, it will return an empty object. To open files view the [official manual page](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Text_Files/file_text_open_read.htm) about it.

### Syntax

```js
file_json_read(file);
```

| Argument |    Type     | Description                 |
| :------- | :---------: | :-------------------------- |
| file     | Id.TextFile | The id of the file to check |

### Returns

```js
Struct;
```

### Example

```js
var _file = file_text_open_read("./my_file.json");
var _json = file_to_json(_file);
file_text_close(_file);

show_debug_message("File content: " + _json);
```

The above code will create a struct based on the contents of the file and the show on console the GM struct.

---

# file_text_get_lines_array

Read all lines of a file and returns it as an array. If there's no file previously opened, it will return an empty array. To open files view the [official manual page](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Text_Files/file_text_open_read.htm) about it.

### Syntax

```js
file_text_get_lines_array(file);
```

| Argument |    Type     | Description                 |
| :------- | :---------: | :-------------------------- |
| file     | Id.TextFile | The id of the file to check |

### Returns

```js
Array;
```

### Example

```js
var _file = file_text_open_read("./my_file.txt");
var _lines = file_text_get_lines_array(_file);
file_text_close(_file);

show_debug_message("File content: " + _lines);
```

The above code will set the var `_lines` as an array of the whole file and the show on console if the file exitst. The array will have the lines of the file as elements. The first element will be the first line of the file, the second element will be the second line of the file and so on.

---

# file_json_create ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Create a file with the contents of a struct. The filename must have the extension `.json`. If the file already exists, it will be overwritten.

### Syntax

```js
file_json_create(filename, struct, [iteration]);
```

| Argument  |  Type   | Description                                                                                          |
| :-------- | :-----: | :--------------------------------------------------------------------------------------------------- |
| filename  | String  | The name of the file to create                                                                       |
| struct    | Struct  | The struct to convert to .JSON                                                                       |
| iteration | Integer | (Internal use. Do not use) The number of iterations to do. If not specified, it will do 1 iteration. |

### Returns

```js
String;
```

### Example

```js
var _struct = {
  name: "John Doe",
  age: 30,
  city: "New York",
};
var _str = file_json_create("./my_file.json", _struct);
show_debug_message("File content: " + _str);
```

The above code will create a file called `my_file.json` with the contents of the struct and the show on console the GM struct.

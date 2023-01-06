# Files
### Table of Contents
- [file_text_read_whole](#file_text_read_whole)
- [file_to_json](#file_to_json)
- [file_text_get_lines_array](#file_text_get_lines_array)

---
# file_text_read_whole
Read all lines of a file and returns it as a string. If there's no file previously opened, it will return an empty string. To open files view the [official manual page](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Text_Files/file_text_open_read.htm) about it.

### Syntax
  ```js
  file_text_read_whole(file);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| file | Text File ID | The id of the file to check |
### Returns
  ```js
  String
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

# file_to_json
Read all lines file and returns it as a struct. If there's no file previously opened, it will return an empty object. To open files view the [official manual page](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/Text_Files/file_text_open_read.htm) about it.

### Syntax
  ```js
  file_to_json(file);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| file | Text File ID | The id of the file to check |
### Returns
  ```js
  Struct
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

| Argument | Type | Description |
| :--- | :---: | :--- |
| file | Text File ID | The id of the file to check |
### Returns
  ```js
  Array
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

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Arrays.md">Arrays</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="HTTP.md">HTTP</a>
    </h3>
  </div>
</div>
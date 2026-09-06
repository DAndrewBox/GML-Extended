# Data Structures

### Table of Contents

- [ds_grid_write_buffer](#ds_grid_write_buffer)
- [ds_grid_read_buffer](#ds_grid_read_buffer)
- [ds_list_write_buffer](#ds_list_write_buffer)
- [ds_list_read_buffer](#ds_list_read_buffer)
- [ds_map_write_buffer](#ds_map_write_buffer)
- [ds_map_read_buffer](#ds_map_read_buffer)
- [struct_write_buffer](#struct_write_buffer)
- [struct_read_buffer](#struct_read_buffer)

> [!NOTE]
> `get_size` and `contains` can also work on data structures when you pass the matching `ds_type_*` constant. See [Snippets](https://github.com/DAndrewBox/GML-Extended/blob/main/Docs/Core/Snippets.md).

---

# ds_grid_write_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the contents of a numeric grid as a compressed base64 string, ready to be saved to a file or sent over the network. Cells are stored as 64-bit floats, so every real value survives the round trip without losing precision. A cell that does not hold a real is written as `0`.

Returns an empty string if the grid does not exist.

### Syntax

```js
ds_grid_write_buffer(grid);
```

| Argument |   Type    | Description                 |
| :------- | :-------: | :-------------------------- |
| grid     | Id.DsGrid | The numeric grid to serialize |

### Returns

```js
String;
```

### Example

```js
var _grid = ds_grid_create(64, 64);
ds_grid_set(_grid, 0, 0, 1234.5);

var _saved = ds_grid_write_buffer(_grid);
file_json_create("save.json", { map: _saved });
```

The above code serializes the grid into a string and stores it inside a JSON save file.

---

# ds_grid_read_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Fills a grid with the contents of a string created by [ds_grid_write_buffer](#ds_grid_write_buffer). The grid is resized to match the stored size, so the destination grid does not need to be created with the right dimensions.

The grid is returned unchanged if it does not exist or if the string is not a valid grid buffer.

### Syntax

```js
ds_grid_read_buffer(grid, b64_string);
```

| Argument   |   Type    | Description                                  |
| :--------- | :-------: | :------------------------------------------- |
| grid       | Id.DsGrid | The grid to write the contents into          |
| b64_string |  String   | The string returned by `ds_grid_write_buffer` |

### Returns

```js
Id.DsGrid;
```

### Example

```js
var _save = file_json_read(file_text_open_read("save.json"));
var _grid = ds_grid_create(1, 1);

ds_grid_read_buffer(_grid, _save.map);

show_debug_message(ds_grid_width(_grid)); // 64
show_debug_message(ds_grid_get(_grid, 0, 0)); // 1234.5
```

The above code restores the grid from the save file. The grid is resized automatically to the size it had when it was written.

# ds_list_write_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the contents of a list as a compressed base64 string. Every value type the list can hold is kept, nested lists and maps included. Returns an empty string if the list does not exist.

### Syntax

```js
ds_list_write_buffer(list);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| list           | Id.DsList                | The list to serialize |

### Returns

```js
String;
```

### Example

```js
var _saved = ds_list_write_buffer(global.high_scores);
file_json_create("scores.json", { scores: _saved });
```

---

# ds_list_read_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Replaces the contents of a list with the values stored in a string created by [ds_list_write_buffer](#ds_list_write_buffer). The list is returned unchanged if it does not exist or if the string cannot be read.

### Syntax

```js
ds_list_read_buffer(list, b64_string);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| list           | Id.DsList                | The list to write the contents into |
| b64_string     | String                   | The string returned by `ds_list_write_buffer` |

### Returns

```js
Id.DsList;
```

### Example

```js
global.high_scores = ds_list_create();
ds_list_read_buffer(global.high_scores, _save.scores);
```

---

# ds_map_write_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the contents of a map as a compressed base64 string. Keys keep their original type, and nested lists and maps are kept too. Returns an empty string if the map does not exist.

### Syntax

```js
ds_map_write_buffer(map);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| map            | Id.DsMap                 | The map to serialize |

### Returns

```js
String;
```

### Example

```js
var _saved = ds_map_write_buffer(global.settings);
```

---

# ds_map_read_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Replaces the contents of a map with the values stored in a string created by [ds_map_write_buffer](#ds_map_write_buffer). The map is returned unchanged if it does not exist or if the string cannot be read.

### Syntax

```js
ds_map_read_buffer(map, b64_string);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| map            | Id.DsMap                 | The map to write the contents into |
| b64_string     | String                   | The string returned by `ds_map_write_buffer` |

### Returns

```js
Id.DsMap;
```

### Example

```js
global.settings = ds_map_create();
ds_map_read_buffer(global.settings, _save.settings);
```

---

# struct_write_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns a struct or an array as a compressed base64 string, nested values included. Returns an empty string if the value is not a struct or an array.

> [!NOTE]
> This uses `json_stringify` under the hood, which is native and faster than walking the struct into a `ds_map` first. Methods and `undefined` values are not kept, exactly like any other JSON round trip.

### Syntax

```js
struct_write_buffer(struct);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| struct         | Struct or Array          | The value to serialize |

### Returns

```js
String;
```

### Example

```js
var _saved = struct_write_buffer({
  player: { hp: 100, pos: [32, 64] },
  items: ["sword", "shield"],
});
```

---

# struct_read_buffer ![](https://img.shields.io/badge/v1.6.0-6ed35c?style=flat)

Returns the struct or array stored in a string created by [struct_write_buffer](#struct_write_buffer). Returns an empty struct if the string cannot be read. Unlike the `ds_*` functions this one creates the value instead of filling an existing one.

### Syntax

```js
struct_read_buffer(b64_string);
```

| Argument       | Type                     | Description |
| :------------- | :----------------------- | :---------- |
| b64_string     | String                   | The string returned by `struct_write_buffer` |

### Returns

```js
Struct or Array;
```

### Example

```js
var _save = struct_read_buffer(_saved);

show_debug_message(struct_get_path(_save, "player.hp")); // 100
```

---

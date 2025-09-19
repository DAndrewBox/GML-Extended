# Game

### Table of Contents

- [game_params](#game_params)
- [game_get_param_value](#game_get_param_value)
- [game_get_param_exists](#game_get_param_exists)
- [game_throw_error](#game_throw_error)
- [game_get_framerate](#game_get_framerate)

---

# game_params ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Returns the game launch parameters.

### Syntax

```js
game_params();
```

### Returns

```js
Array (each entry is a string)
```

### Example

```js
var _params = game_params();
show_debug_message("GAME PARAMETERS: " + string(_params));

if (game_get_param_exists("--fullscreen")) {
  window_set_fullscreen(true);
} else if (
  game_get_param_exists("--windowWidth") &&
  game_get_param_exists("--windowHeight")
) {
  var _w = game_get_param_value("--windowWidth");
  var _h = game_get_param_value("--windowHeight");
  window_set_fullscreen(false);
  window_set_size(real(_w), real(_h));
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--fullscreen", "--windowWidth", "800", "--windowHeight", "600"]`. Then, if the game launch parameters contains `--fullscreen`, the game will be set to fullscreen. If the game launch parameters contains `--windowWidth` and `--windowHeight`, the game window will be resized to the specified width and height.

---

# game_get_param_value ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Returns the value of a game launch parameter if it exists, if not returns 0. The value of the parameter is the next string after the parameter name.

### Syntax

```js
game_get_param_value(parameter);
```

| Argument  |  Type  | Description        |
| :-------- | :----: | :----------------- |
| parameter | String | The parameter name |

### Returns

```js
String;
```

### Example

```js
var _params = game_params();
show_debug_message("GAME PARAMETERS: " + string(_params));

if (game_get_param_exists("--fullscreen")) {
  window_set_fullscreen(true);
} else if (
  game_get_param_exists("--windowWidth") &&
  game_get_param_exists("--windowHeight")
) {
  var _w = game_get_param_value("--windowWidth");
  var _h = game_get_param_value("--windowHeight");
  window_set_fullscreen(false);
  window_set_size(real(_w), real(_h));
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--fullscreen", "--windowWidth", "800", "--windowHeight", "600"]`. Then, if the game launch parameters contains `--fullscreen`, the game will be set to fullscreen. If the game launch parameters contains `--windowWidth` and `--windowHeight`, the game window will be resized to the specified width and height.

---

# game_get_param_exists ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Returns true if the game launch parameter exists, if not returns false.

### Syntax

```js
game_get_param_exists(parameter);
```

| Argument  |  Type  | Description        |
| :-------- | :----: | :----------------- |
| parameter | String | The parameter name |

### Returns

```js
Bool;
```

### Example

```js
var _params = game_params();
show_debug_message("GAME PARAMETERS: " + string(_params));

if (game_get_param_exists("--fullscreen")) {
  window_set_fullscreen(true);
} else if (
  game_get_param_exists("--windowWidth") &&
  game_get_param_exists("--windowHeight")
) {
  var _w = game_get_param_value("--windowWidth");
  var _h = game_get_param_value("--windowHeight");
  window_set_fullscreen(false);
  window_set_size(real(_w), real(_h));
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--fullscreen", "--windowWidth", "800", "--windowHeight", "600"]`. Then, if the game launch parameters contains `--fullscreen`, the game will be set to fullscreen. If the game launch parameters contains `--windowWidth` and `--windowHeight`, the game window will be resized to the specified width and height.

---

# game_throw_error ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Throws an error and stops the game. The error message will be shown on the console.

### Syntax

```js
game_throw_error(message);
```

| Argument |  Type  | Description       |
| :------- | :----: | :---------------- |
| message  | String | The error message |

### Returns

```js
None;
```

### Example

```js
if (game_get_param_exists("--error")) {
  var _error = game_get_param_value("--error");
  game_throw_error(_error);
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--error", "This is an error message"]`. Then, if the game launch parameters contains `--error`, the game will throw an error and stop.

---

# game_get_framerate ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

Returns the current game set framerate.

### Syntax

```js
game_get_framerate();
```

### Returns

```js
Real;
```

### Example

```js
var _framerate = game_get_framerate();

show_debug_message("Current framerate: " + string(_framerate));
```

The above code will return the current game set framerate and show on console. The result will be `60` if the game framerate is set to `60`.

---

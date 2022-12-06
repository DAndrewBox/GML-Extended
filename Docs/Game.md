# Game
### Table of Contents
- [game_params](#game_params)
- [game_get_param_value](#game_get_param_value)
- [game_get_param_exists](#game_get_param_exists)
- [game_throw_error](#game_throw_error)

---
# game_params
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
} else if (game_get_param_exists("--windowWidth") && game_get_param_exists("--windowHeight")) {
  var _w = game_get_param_value("--windowWidth");
  var _h = game_get_param_value("--windowHeight");
  window_set_fullscreen(false);
  window_set_size(real(_w), real(_h));
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--fullscreen", "--windowWidth", "800", "--windowHeight", "600"]`. Then, if the game launch parameters contains `--fullscreen`, the game will be set to fullscreen. If the game launch parameters contains `--windowWidth` and `--windowHeight`, the game window will be resized to the specified width and height.

---
# game_get_param_value
Returns the value of a game launch parameter if it exists, if not returns 0. The value of the parameter is the next string after the parameter name.

### Syntax
  ```js
  game_get_param_value(parameter);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| parameter | String | The parameter name |

### Returns
  ```js
  String
  ```

### Example
```js
var _params = game_params();
show_debug_message("GAME PARAMETERS: " + string(_params));

if (game_get_param_exists("--fullscreen")) {
  window_set_fullscreen(true);
} else if (game_get_param_exists("--windowWidth") && game_get_param_exists("--windowHeight")) {
  var _w = game_get_param_value("--windowWidth");
  var _h = game_get_param_value("--windowHeight");
  window_set_fullscreen(false);
  window_set_size(real(_w), real(_h));
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--fullscreen", "--windowWidth", "800", "--windowHeight", "600"]`. Then, if the game launch parameters contains `--fullscreen`, the game will be set to fullscreen. If the game launch parameters contains `--windowWidth` and `--windowHeight`, the game window will be resized to the specified width and height.

---
# game_get_param_exists
Returns true if the game launch parameter exists, if not returns false.

### Syntax
  ```js
  game_get_param_exists(parameter);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| parameter | String | The parameter name |

### Returns
  ```js
  Bool
  ```

### Example
```js
var _params = game_params();
show_debug_message("GAME PARAMETERS: " + string(_params));

if (game_get_param_exists("--fullscreen")) {
  window_set_fullscreen(true);
} else if (game_get_param_exists("--windowWidth") && game_get_param_exists("--windowHeight")) {
  var _w = game_get_param_value("--windowWidth");
  var _h = game_get_param_value("--windowHeight");
  window_set_fullscreen(false);
  window_set_size(real(_w), real(_h));
}
```

The above code will set the var `_params` as an array with the game launch parameters and show on console. The result will be `["--fullscreen", "--windowWidth", "800", "--windowHeight", "600"]`. Then, if the game launch parameters contains `--fullscreen`, the game will be set to fullscreen. If the game launch parameters contains `--windowWidth` and `--windowHeight`, the game window will be resized to the specified width and height.

---
# game_throw_error
Throws an error and stops the game. The error message will be shown on the console.

### Syntax
  ```js
  game_throw_error(message);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| message | String | The error message |

### Returns
  ```js
  None
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

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Draw.md">Draw</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Instances_and_Events.md">Instances & Events</a>
    </h3>
  </div>
</div>
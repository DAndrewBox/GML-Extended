# Instances & Events
### Table of Contents
- [instance_create](#instance_create)
- [instance_create_unique](#instance_create_unique)
- [instance_any_exists](#instance_any_exists)
- [instance_in_room](#instance_in_room)
- [instance_get_all](#instance_get_all)
- [instance_number_if](#instance_number_if)
- [event_user_exec](#event_user_exec)

---
# instance_create
Creates an instance of an object at the specified position. Similar of how `instance_create` worked before GameMaker Studio 2, but with some extra features. The object index is the index of the object in the object list (not the id). The depth is the depth of the instance (if the layer doesn't exists, it will be created). The params argument is a struct with the parameters to pass to the instance at creation.

### Syntax
  ```js
  instance_create(x, y, object_index, [depth|layer_name = 0], [params = {}]);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| x | Real | The x position of the instance |
| y | Real | The y position of the instance |
| object_index | Real | The index of the object to create |
| depth or layer_name | Real or String | The depth of the instance or the layer to use(default = 0) |
| params | Struct | The parameters to pass to the instance at creation |
### Returns
  ```js
  Ref
  ```

### Example
```js
var _player = instance_create(0, 0, obj_Player, -100, {
    "image_xscale": -1,
    "can_jump": true
});

instance_create(0, 0, obj_Enemy, "layer_enemies", {
    "image_xscale": _player.x < x ? -1 : 1,
});
```

The above code will create a player and an enemy. The player will be created on a layer with -100 depth (if exists or will create a new one). The enemy will face the player and will be created on a layer called "layer_enemies".

---
# instance_create_unique
Functions the same as `instance_create`, but **if an instance of the object already exists, it will return -1 and will not create the instance**. The object index is the index of the object in the object list (not the id). The depth is the depth of the instance (if the layer doesn't exists, it will be created). The params argument is a struct with the parameters to pass to the instance at creation.

### Syntax
  ```js
  instance_create_unique(x, y, object_index, [depth|layer_name = 0], [params = {}]);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| x | Real | The x position of the instance |
| y | Real | The y position of the instance |
| object_index | Real | The index of the object to create |
| depth or layer_name | Real or String | The depth of the instance or the layer to use(default = 0) |
| params | Struct | The parameters to pass to the instance at creation |
### Returns
  ```js
  Ref or -1
  ```

### Example
```js
var _player = instance_create(128, 100, obj_Player, -100, {
    "image_xscale": -1,
    "can_jump": true
});

instance_create_unique(32, 100, obj_Enemy, "layer_enemies", {
    "image_xscale": _player.x < x ? -1 : 1,
});

instance_create_unique(160, 100, obj_Enemy, "layer_enemies", {
    "image_xscale": _player.x < x ? -1 : 1,
});
```

The above code will create a player and two enemies. The player will be created on a layer with -100 depth (if exists or will create a new one). The enemies will face the player and will be created on a layer called "layer_enemies". The enemies will be created only if there is no other enemy, so only the first enemy will be created but not the second one.

---
# instance_any_exists
Returns true if any instance of the objects passed as arguments exists.

### Syntax
  ```js
  instance_any_exists(*args);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| *args | Refs | The arguments to pass to the function |

### Returns
  ```js
  Boolean
  ```

### Example
```js
if (instance_any_exists(obj_Player, obj_Enemy)) {
    show_debug_message("There is a player or an enemy in the room");
}
```

The above code will show a debug message if there is a player or an enemy in the room.

---
# instance_in_room
Returns true if an instance of the object exists inside the boundaries of the room.

### Syntax
  ```js
  instance_in_room(object_index | id);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| object_index or id | Real or Ref | The index of the object or the id of the instance |

### Returns
  ```js
  Boolean
  ```

### Example
```js
if (instance_in_room(obj_Player)) {
    show_debug_message("There is a player inside the room");
}
```

The above code will show a debug message if there is a player inside the room.

---

# instance_get_all
Returns an array of all instances of the object passed as argument.

### Syntax
  ```js
  instance_get_all(object_index);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| object_index | Real Ref | The index of the object |

### Returns
  ```js
  Array
  ```

### Example
```js
var _players = instance_get_all(obj_Player);
for (var i = 0; i < _players.length; i++) {
    show_debug_message("Player " + i + " x: " + _players[i].x);
}
```

The above code will show the x position of all players in the room.

---

# instance_number_if
Returns a number of instances of the object passed as argument that match the condition passed as callback argument.

### Syntax
  ```js
  instance_number_if(object_index, callback);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| object_index | Real Ref | The index of the object |
| callback | Function | The callback function |

### Returns
  ```js
  Real
  ```

### Example
```js
var _players_with_guns = instance_number_if(obj_Player, function() {
    return gun_id > -1;
});
show_debug_message("There are " + _players_with_guns + " players with guns");
```

The above code will show the number of players with guns in the room. The callback function will be executed for each player and will return true if the player has a gun.

---

# event_user_exec
Executes an event of an object. The event must be a user event. The event_number is the id of the event to execute.

### Syntax
  ```js
  event_user_exec(instance_id, event_number);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| instance_id | Ref | The id of the instance to execute the event |
| event_number | Real | The id of the event to execute |

### Returns
  ```js
  None
  ```

### Example
```js
event_user_exec(obj_Player, 5);
```

The above code will execute `event_user(5)` on the player instance.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Game.md">Game</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Layers.md">Layers</a>
    </h3>
  </div>
</div>
# Layers

### Table of Contents

- [macros](#macros)
- [layer_get_element_ids_fixed](#layer_get_element_ids_fixed)
- [layer_get_background](#layer_get_background)
- [layer_get_tileset](#layer_get_tileset)

# macros ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

| Macro                              | Description                                                                         | Value                           |
| :--------------------------------- | :---------------------------------------------------------------------------------- | :------------------------------ |
| layer_element_type_background      | The layer element type for backgrounds                                              | layerelementtype_background     |
| layer_element_type_instance        | The layer element type for instances                                                | layerelementtype_instance       |
| layer_element_type_sprite          | The layer element type for sprites                                                  | layerelementtype_sprite         |
| layer_element_type_tilemap         | The layer element type for tilemaps                                                 | layerelementtype_tilemap        |
| layer_element_type_particle_system | The layer element type for particle systems                                         | layerelementtype_particlesystem |
| layer_element_type_sequence        | The layer element type for sequences                                                | layerelementtype_sequence       |
| layer_element_type_undefined       | The layer element type for undefined                                                | layerelementtype_undefined      |
| layer_element_type_tile            | The layer element type for tiles. Used only on projects imported from GM:S 1        | layerelementtype_tile           |
| layer_element_type_tilemap_old     | The layer element type for old tilemaps. Used only on projects imported from GM:S 1 | layerelementtype_oldtilemap     |

---

# layer_get_element_ids_fixed ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

A way to get the elements of a dynamically created layer. This is a fix for the original `layer_get_element_ids` function that doesn't work with dynamically created layers. This function is based on the [original](https://itch.io/post/2224479) by [YellowAfterLife](https://yal.cc).

### Syntax

```js
layer_get_element_ids_fixed(layer_id, layer_element_type);
```

| Argument           |   Type   | Description                                                                                                                                                                                 |
| :----------------- | :------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| layer_id           | Id.Layer | The layer id                                                                                                                                                                                |
| layer_element_type |   Real   | The layer element type (see [Layer Element Types](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Rooms/General_Layer_Functions/layer_get_element_type.htm)) |

### Returns

```js
Real;
```

### Example

```js
var _layer_id = layer_create();
var _layer_element_type = layer_get_element_type(_layer_id);
var _layer_element_ids = layer_get_element_ids_fixed(
  _layer_id,
  _layer_element_type
);
```

The above code will show on console the keys and values of the struct.

---

# layer_get_background ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

A way to get the background of a layer using the ID or the name. This only serves to simplify the process of getting the background of a layer with multiple functions and different variables storing the ids on every step.

### Syntax

```js
layer_get_background(layer_id | layer_name);
```

| Argument            |        Type        | Description                                                |
| :------------------ | :----------------: | :--------------------------------------------------------- |
| layer_id/layer_name | Id.Layer or String | The layer id or the layer name to get the background from. |

### Returns

```js
Asset.GMSprite;
```

### Example

```js
var _layer_id = layer_create();
layer_background_create(_layer_id, "background_name");

var _layer_background = layer_get_background(_layer_id);
```

The above code will return the background id of the layer.

---

# layer_get_tileset ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

A way to get the tileset of a layer using the ID or the name. This only serves to simplify the process of getting the tileset of a layer with multiple functions and different variables storing the ids on every step.

### Syntax

```js
layer_get_tileset(layer_id | layer_name);
```

| Argument            |        Type        | Description                                             |
| :------------------ | :----------------: | :------------------------------------------------------ |
| layer_id/layer_name | Id.Layer or String | The layer id or the layer name to get the tileset from. |

### Returns

```js
Real;
```

### Example

```js
var _layer_id = layer_create();
layer_tilemap_create(_layer_id, "tileset_name");

var _layer_tileset = layer_get_tileset(_layer_id);
```

The above code will return the tileset id of the layer.

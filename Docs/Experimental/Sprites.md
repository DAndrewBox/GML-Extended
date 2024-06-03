# Sprites

> [!WARNING]
> This is an experimental feature. This functions are subject to change. Use at your own risk.

This is a new Sprites struct type that allows to work with sprites in a more convenient way.

To create a new sprite object, you should use `sprite_var = new Sprite(sprite_id)`.

### Internal Parameters

| Parameter   |  Type   | Description                                                                                                       |
| :---------- | :-----: | :---------------------------------------------------------------------------------------------------------------- |
| index       |  Real   | The sprite index                                                                                                  |
| speed       |  Real   | The sprite internal speed                                                                                         |
| width       |  Real   | The sprite width                                                                                                  |
| height      |  Real   | The sprite height                                                                                                 |
| origin      |  Array  | The sprite origin as [x, y]                                                                                       |
| image_type  |  Real   | The sprite image type (0: BMP, 1: SWF or 2: Spine)                                                                |
| bbox        |  Array  | The sprite bounding box as [x1, y1, x2, y2]                                                                       |
| bbox_mode   |  Real   | The sprite bounding box mode (0: Full, 1: Manual or 2: Automatic)                                                 |
| name        | String  | The sprite name                                                                                                   |
| frames      |  Real   | The sprite frames                                                                                                 |
| frames_info |  Array  | Array of frames for this sprite, where each frame is a struct containing information on its timing.               |
| use_mask    | Boolean | Whether the sprite uses a mask                                                                                    |
| num_masks   |  Real   | The number of masks                                                                                               |
| messages    |  Array  | Array of messages for this sprite, where each broadcast message is a struct containing information on the message |
| nineslice   | Struct  | The sprite nineslice struct                                                                                       |
| smooth      | Boolean | Whether the sprite is smoothed                                                                                    |
| transparent | Boolean | Whether the sprite is transparent                                                                                 |
| texture     |  Real   | The sprite texture                                                                                                |
| uvs         |  Array  | The sprite UVs                                                                                                    |

The following methods are available:

### Table of Contents

- [getSize](#getSize)
- [getOrigin](#getOrigin)
- [getSpriteType](#getSpriteType)
- [getBbox](#getBbox)
- [getBboxMode](#getBboxMode)
- [getFrames](#getFrames)
- [getFramesInfo](#getFramesInfo)
- [getTexture](#getTexture)
- [getUVS](#getUVS)
- [getMessages](#getMessages)
- [isNineslice](#isNineslice)

---

# getSize

Returns the sprite size as [width, height].

### Syntax

```js
Sprite.getSize();
```

### Returns

```js
Array;
```

### Example

```js
var sprite = new Sprite(s_mySprite);
var size = sprite.getSize();

show_debug_message("Sprite size: " + string(size[0]) + "x" + string(size[1]));
```

The above code will output the following message:

```
Sprite size: 32x32
```

---

# getOrigin

Returns an array with the orgin coords of the sprite as [x, y].

### Syntax

```js
Sprite.getOrigin();
```

### Returns

```js
Array;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _origin = sprite.getOrigin();

show_debug_message(
  "Sprite origin: " + string(_origin[0]) + ", " + string(_origin[1])
);
```

The above code will output the following message:

```
Sprite origin: 16, 16
```

---

# getSpriteType

Returns the sprite type as a real.

### Syntax

```js
Sprite.getSpriteType();
```

### Returns

```js
Real;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _type = sprite.getSpriteType();

show_debug_message("Sprite type: " + string(_type));
```

The above code will output the following message:

```
Sprite type: 0
```

---

# getBbox

Returns the sprite bounding box as [x1, y1, x2, y2].

### Syntax

```js
Sprite.getBbox();
```

### Returns

```js
Array;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _bbox = sprite.getBbox();

show_debug_message(
  "Sprite bbox: " +
    string(_bbox[0]) +
    ", " +
    string(_bbox[1]) +
    ", " +
    string(_bbox[2]) +
    ", " +
    string(_bbox[3])
);
```

The above code will output the following message:

```
Sprite bbox: 0, 0, 32, 32
```

---

# getBboxMode

Returns the sprite bounding box mode as a real.

### Syntax

```js
Sprite.getBboxMode();
```

### Returns

```js
Real;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _mode = sprite.getBboxMode();

show_debug_message("Sprite bbox mode: " + string(_mode));
```

The above code will output the following message:

```
Sprite bbox mode: 0
```

---

# getFrames

Returns the sprite frames as a real. Same behavior as `image_number`.

### Syntax

```js
Sprite.getFrames();
```

### Returns

```js
Real;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _frames = sprite.getFrames();

show_debug_message("Sprite frames: " + string(_frames));
```

The above code will output the following message:

```
Sprite frames: 10
```

---

# getFramesInfo

Returns an array with the frames information of the sprite.

### Syntax

```js
Sprite.getFramesInfo();
```

### Returns

```js
Array;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _frames_info = sprite.getFramesInfo();

show_debug_message("Sprite frames info: " + string(_frames_info));
```

The above code will output the following message:

```
Sprite frames info: [
  {frame: 0, duration: 1, image_index: 0},
  {frame: 1, duration: 1, image_index: 1},
  {frame: 2, duration: 1, image_index: 2},
  ...,
  {frame: 9, duration: 1, image_index: 9}
]
```

---

# getTexture

Returns the sprite texture id as a real.

### Syntax

```js
Sprite.getTexture();
```

### Returns

```js
Real;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _tex = sprite.getTexture();

show_debug_message("Sprite texture: " + string(_tex));
```

The above code will output the following message:

```
Sprite texture: 0
```

---

# getUVS

Returns the sprite UVs as an array.

### Syntax

```js
Sprite.getUVS();
```

### Returns

```js
Array;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _uvs = sprite.getUVS();

show_debug_message("Sprite UVs: " + string(_uvs));
```

The above code will output the following message:

```
Sprite UVs: [0, 0, 1, 1]
```

---

# getMessages

Returns the sprite messages as an array.

### Syntax

```js
Sprite.getMessages();
```

### Returns

```js
Array;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _msgs_ = sprite.getMessages();

show_debug_message("Sprite messages: " + string(_msgs_));
```

The above code will output the following message:

```
Sprite messages: [
  {frame: 2, message: "first broadcast message"},
  {frame: 9, message: "second broadcast message"}
]
```

---

# isNineslice

Returns true if the sprite is a nineslice sprite.

### Syntax

```js
Sprite.isNineslice();
```

### Returns

```js
Array;
```

### Example

```js
var _sprite = new Sprite(s_mySprite);
var _is_nineslice = sprite.isNineslice();

show_debug_message("Sprite is nineslice: " + string(_is_nineslice));
```

The above code will output the following message:

```
Sprite is nineslice: false
```

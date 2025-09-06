# Surfaces

> [!WARNING]
> This is an experimental feature. This functions are subject to change. Use at your own risk.

This is a new way to work with Surfaces as objects. It is still in development and not all features are implemented yet. The goal is to make it easier to work with surfaces.

To create a new surface object, you should use `surf = new Surface(width, height, [name])` (`name` parameter is optional).

### Internal Parameters

| Parameter |    Type    | Description                              |
| :-------- | :--------: | :--------------------------------------- |
| surf      | Id.Surface | The surface object managed by GameMaker. |
| width     |    Real    | The width of the surface.                |
| height    |    Real    | The height of the surface.               |
| name      |   String   | The name of the surface.                 |

The following methods are available:

### Table of Contents

- [exists](#exists)
- [free](#free)
- [setTarget](#settarget)
- [resetTarget](#resettarget)
- [clear](#clear)
- [resize](#resize)
- [save](#save)
- [getWidth](#getwidth)
- [getHeight](#getheight)
- [getTexture](#gettexture)
- [getPixel](#getpixel)
- [getPixelExt](#getpixelext)
- [draw](#draw)
- [drawPart](#drawpart)
- [drawStretched](#drawstretched)
- [drawTiled](#drawtiled)

---

# exists

Returns a boolean value indicating whether the surface exists.

### Syntax

```js
Surface.exists();
```

### Returns

```js
Real;
```

### Example

```js
if (!surf.exists()) {
  surf = new Surface(128, 128);
}
```

The above example will create a new surface if it doesn't exist.

---

# free

Frees the surface from memory. You should always call this method when you are done with the surface and will not be using it again.

### Syntax

```js
Surface.free();
```

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

if (random(1) < 0.5) {
  surf.free();
}
```

The above example will free the surface from memory 50% of the time.

---

# setTarget

Sets the surface as the target for drawing. You should always call `Surface.resetTarget()` after you are done drawing.

### Syntax

```js
Surface.setTarget();
```

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 1);
surf.resetTarget();
```

The above example will set the surface as draw target, then clear the surface to black and finally reset the draw target.

---

# resetTarget

Resets the draw target to the `application_surface`.

### Syntax

```js
Surface.resetTarget();
```

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 1);
surf.resetTarget();
```

The above example will set the surface as draw target, then clear the surface to black and finally reset the draw target.

---

# clear

Clears the surface to the specified color and alpha.

### Syntax

```js
Surface.clear([(color = c_fuchsia)], [(alpha = 0.0)]);
```

| Argument | Type  | Description                        |
| :------- | :---: | :--------------------------------- |
| color    | Color | The color to clear the surface to. |
| alpha    | Real  | The alpha to clear the surface to. |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();
```

The above example will set the surface as draw target, then clear the surface to black with 50% oppacity and finally reset the draw target.

---

# resize

Resizes the surface to the specified width and height. The surface will not be cleared.

### Syntax

```js
Surface.resize(width, height);
```

| Argument | Type  | Description                    |
| :------- | :---: | :----------------------------- |
| width    | Real  | The new width of the surface.  |
| height   | Real  | The new height of the surface. |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();

surf.resize(256, 256);
```

The above example will set the surface as draw target and paint it black with 50% oppacity. Then it will reset the draw target and resize the surface to 256x256 pixels.

---

# save

Save the surface to a file. The file will be saved in the `working_directory` directory.

### Syntax

```js
Surface.save(
  filename,
  [(x = 0)],
  [(y = 0)],
  [(width = Surface.width)],
  [(height = Surface.height)]
);
```

| Argument |  Type  | Description                                                |
| :------- | :----: | :--------------------------------------------------------- |
| filename | String | The name of the file to save the surface to.               |
| x        |  Real  | The x position to start saving from. (default = 0)         |
| y        |  Real  | The y position to start saving from. (default = 0)         |
| width    |  Real  | The width of the area to save. (default = Surface.width)   |
| height   |  Real  | The height of the area to save. (default = Surface.height) |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();

surf.resize(256, 256);

surf.save("surface.png", 16, 16, 64, 64);
```

The above example will save a 64x64 area of the surface to a file named `surface.png` from the (16, 16) coordinates to (80, 80).

---

# getWidth

Returns the width of the surface.

### Syntax

```js
Surface.getWidth();
```

### Returns

```js
Real;
```

### Example

```js
surf = new Surface(128, 128);
var _w = surf.getWidth();
var _h = surf.getHeight();

show_message("Surface size: (" + string(_w) + ", " + string(_h) + ")");
```

The above example will create a new surface and show a message box with the surface size.

---

# getHeight

Returns the height of the surface.

### Syntax

```js
Surface.getHeight();
```

### Returns

```js
Real;
```

### Example

```js
surf = new Surface(128, 128);
var _w = surf.getWidth();
var _h = surf.getHeight();

show_message("Surface size: (" + string(_w) + ", " + string(_h) + ")");
```

The above example will create a new surface and show a message box with the surface size.

---

# getTexture

Returns the texture of the surface. This is used internally by the engine.

### Syntax

```js
Surface.getTexture();
```

### Returns

```js
Texture ID
```

### Example

```js
surf = new Surface(128, 128);
var _tex = surf.getTexture();
```

The above example will create a new surface and get the texture ID of the surface.

---

# getPixel

Returns the color of the pixel at the specified coordinates.

### Syntax

```js
Surface.getPixel(x, y);
```

| Argument | Type  | Description                  |
| :------- | :---: | :--------------------------- |
| x        | Real  | The x position of the pixel. |
| y        | Real  | The y position of the pixel. |

### Returns

```js
Real;
```

### Example

```js
surf = new Surface(128, 128);
var _col = surf.getPixel(64, 64);

show_message("Pixel color: " + string(_col));
```

The above example will create a new surface and get the color of the pixel at (64, 64) and show a message box with the color.

---

# getPixelExt

Returns the color and alpha of the pixel at the specified coordinates.

### Syntax

```js
Surface.getPixelExt(x, y);
```

| Argument | Type  | Description                  |
| :------- | :---: | :--------------------------- |
| x        | Real  | The x position of the pixel. |
| y        | Real  | The y position of the pixel. |

### Returns

```js
Real;
```

### Example

```js
surf = new Surface(128, 128);
var _alpha = (col >> 24) & 255;
var _blue = (col >> 16) & 255;
var _green = (col >> 8) & 255;
var _red = col & 255;

show_message(
  "Pixel color: " +
    string(_red) +
    ", " +
    string(_green) +
    ", " +
    string(_blue) +
    ", " +
    string(_alpha)
);
```

The above example will create a new surface and get the color and alpha of the pixel at (64, 64) and show a message box with the color and alpha.

---

# draw

Draws the surface to the screen. The surface will be drawn at the specified coordinates.

### Syntax

```js
Surface.draw(
  x,
  y,
  [(xscale = 1)],
  [(yscale = 1)],
  [(angle = 0)],
  [(color = c_white)],
  [(alpha = 1)],
  [(from_center = false)]
);
```

| Argument    |  Type   | Description                                                           |
| :---------- | :-----: | :-------------------------------------------------------------------- |
| x           |  Real   | The x position to draw the surface at.                                |
| y           |  Real   | The y position to draw the surface at.                                |
| xscale      |  Real   | The x scale of the surface. (default = 1)                             |
| yscale      |  Real   | The y scale of the surface. (default = 1)                             |
| angle       |  Real   | The angle to rotate the surface. (default = 0)                        |
| color       |  Real   | The color to tint the surface. (default = -1)                         |
| alpha       |  Real   | The alpha of the surface. (default = 1)                               |
| from_center | Boolean | If true, the surface will be drawn from the center. (default = false) |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();

surf.draw(0, 0, 2, 2);
```

The above example will create a new surface and draw it to the screen at (0, 0) with a scale of 2x2.

---

# drawPart

Draws a part of the surface to the screen. The surface will be drawn at the specified coordinates.

### Syntax

```js
Surface.drawPart(
  x,
  y,
  [(left = 0)],
  [(top = 0)],
  [(width = Surface.width)],
  [(height = Surface.height)],
  [(xscale = 1)],
  [(yscale = 1)],
  [(angle = 0)],
  [(color = c_white)],
  [(alpha = 1)]
);
```

| Argument | Type  | Description                                                |
| :------- | :---: | :--------------------------------------------------------- |
| x        | Real  | The x position to draw the surface at.                     |
| y        | Real  | The y position to draw the surface at.                     |
| left     | Real  | The x position of the area to draw. (default = 0)          |
| top      | Real  | The y position of the area to draw. (default = 0)          |
| width    | Real  | The width of the area to draw. (default = Surface.width)   |
| height   | Real  | The height of the area to draw. (default = Surface.height) |
| xscale   | Real  | The x scale of the surface. (default = 1)                  |
| yscale   | Real  | The y scale of the surface. (default = 1)                  |
| angle    | Real  | The angle to rotate the surface. (default = 0)             |
| color    | Real  | The color to tint the surface. (default = -1)              |
| alpha    | Real  | The alpha of the surface. (default = 1)                    |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();

surf.drawPart(0, 0, 16, 16, 64, 64, 2, 2);
```

The above example will create a new surface and draw a part of it from (16, 16) to (80, 80) on the screen at (0, 0) with a scale of 2x2.

---

# drawStretched

Draws the surface to the screen. The surface will be stretched to the specified size.

### Syntax

```js
Surface.drawStretched(
  x,
  y,
  [(width = Surface.width)],
  [(height = Surface.height)],
  [(color = -1)],
  [(alpha = 1)]
);
```

| Argument | Type  | Description                                                      |
| :------- | :---: | :--------------------------------------------------------------- |
| x        | Real  | The x position to draw the surface at.                           |
| y        | Real  | The y position to draw the surface at.                           |
| width    | Real  | The width to stretch the surface to. (default = Surface.width)   |
| height   | Real  | The height to stretch the surface to. (default = Surface.height) |
| color    | Real  | The color to tint the surface. (default = -1)                    |
| alpha    | Real  | The alpha of the surface. (default = 1)                          |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();

surf.drawStretched(0, 0, 256, 256);
```

The above example will create a new surface and draw it to the screen at (0, 0) stretched to 256x256.

---

# drawTiled

Draws the surface to the screen. The surface will be tiled in every direction of the room.

### Syntax

```js
Surface.drawTiled(
  x,
  y,
  [(xscale = 1)],
  [(yscale = 1)],
  [(color = -1)],
  [(alpha = 1)]
);
```

| Argument | Type  | Description                                   |
| :------- | :---: | :-------------------------------------------- |
| x        | Real  | The x position to draw the surface at.        |
| y        | Real  | The y position to draw the surface at.        |
| xscale   | Real  | The x scale of the surface. (default = 1)     |
| yscale   | Real  | The y scale of the surface. (default = 1)     |
| color    | Real  | The color to tint the surface. (default = -1) |
| alpha    | Real  | The alpha of the surface. (default = 1)       |

### Returns

```js
None;
```

### Example

```js
surf = new Surface(128, 128);

surf.setTarget();
surf.clear(c_black, 0.5);
surf.resetTarget();

surf.drawTiled(0, 0, 2, 2);
```

The above example will create a new surface and draw it to the screen at (0, 0) tiled in every direction of the room.

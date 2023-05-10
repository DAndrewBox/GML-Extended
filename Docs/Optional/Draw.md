# Draw

### Table of Contents

- [draw_self_ext](#draw_self_ext)
- [draw_figure](#draw_figure)
- [draw_quad](#draw_quad)
- [draw_rectangle_width](#draw_rectangle_width)
- [draw_rectangle_rotated](#draw_rectangle_rotated)
- [draw_text_outline](#draw_text_outline)
- [draw_text_shadow](#draw_text_shadow)
- [draw_text_size](#draw_text_size)
- [draw_fps](#draw_fps)
- [draw_fps_real](#draw_fps_real)
- [draw_set_align](#draw_set_align)
- [gpu_set_alpha_overwrite](#gpu_set_alpha_overwrite)

---

# draw_self_ext

Draw the sprite of the object with the specified position, scale and rotation. This function is similar to the `draw_self` function, but it allows you to specify the position, scale and rotation of the sprite.

### Syntax

```js
draw_self_ext(
  [sprite],
  [index],
  [x],
  [y],
  [xscale],
  [yscale],
  [rot],
  [color],
  [alpha]
);
```

| Argument |  Type  | Description                                            |
| :------- | :----: | :----------------------------------------------------- |
| sprite   | Sprite | The sprite to draw. (Default: sprite_index)            |
| index    |  Real  | The index of the sprite to draw (Default: image_index) |
| x        |  Real  | The x position of the sprite (Default: object.x)       |
| y        |  Real  | The y position of the sprite (Default: object.y)       |
| xscale   |  Real  | The x scale of the sprite (Default: image_xscale)      |
| yscale   |  Real  | The y scale of the sprite (Default: image_yscale)      |
| rot      |  Real  | The rotation of the sprite (Default: 0)                |
| color    |  Real  | The color of the sprite (Default: c_white)             |
| alpha    |  Real  | The alpha of the sprite (Default: 1)                   |

### Returns

```js
None;
```

### Example

```js
draw_self_ext(,,, y - 2,,,, c_black, 1);
```

The above code will draw a black version of the sprite of the object with the specified position, scale and rotation.

---

# draw_figure

Draw a figure of specified sides with the specified position, scale and rotation.

### Syntax

```js
draw_figure(x, y, sides, size, [(rot = 0)], [(width = 1)]);
```

| Argument | Type | Description                             |
| :------- | :--: | :-------------------------------------- |
| x        | Real | The x position of the figure            |
| y        | Real | The y position of the figure            |
| sides    | Real | The number of sides of the figure       |
| size     | Real | The size of the figure                  |
| rot      | Real | The rotation of the figure (Default: 0) |
| width    | Real | The width of the figure (Default: 1)    |

### Returns

```js
None;
```

### Example

```js
draw_set_colour(c_lime);
draw_figure(x - 100, 128, 3, 32, 25, 2);
draw_set_colour(c_teal);
draw_figure(x, 128, 6, 32, 0, 1);
draw_set_colour(c_purple);
draw_figure(x + 100, 128, 4, 32, 45, 3);
```

The above code will draw a triangle, hexagon and square with the specified position, scale and rotation.

<p style="text-align: center;">
  <img src="https://i.imgur.com/McSU1MO.png" width="auto" height="auto">
</p>

---

# draw_quad

Draw a quad on the screen using 4 points and a gradient color. The color_init and color_final arguments are the colors of the top and bottom points of the quad.

### Syntax

```js
draw_quad(xy1, xy2, xy3, xy4, color_init, color_final, alpha);
```

| Argument    | Type  | Description                                |
| :---------- | :---: | :----------------------------------------- |
| xy1         | Array | The x and y position of the first point    |
| xy2         | Array | The x and y position of the second point   |
| xy3         | Array | The x and y position of the third point    |
| xy4         | Array | The x and y position of the fourth point   |
| color_init  | Real  | The color in the top points of the quad    |
| color_final | Real  | The color in the bottom points of the quad |
| alpha       | Real  | The alpha of the quad                      |

### Returns

```js
None;
```

### Example

```js
draw_quad(
  [x, y],
  [x + 20, y],
  [x - 50, y + 200],
  [x + 150, y + 150],
  c_lime,
  c_blue,
  0.75
);
```

The above code will draw a quad with the specified position, scale and rotation.

<p style="text-align: center;">
  <img src="https://i.imgur.com/kS1AX6I.png" width="auto" height="auto">
</p>

---

# draw_rectangle_width

Draw a rectangle on the specified position with a line width specified by the user.

### Syntax

```js
draw_rectangle_width(x1, y1, x2, y2, [(width = 1)]);
```

| Argument | Type | Description                        |
| :------- | :--: | :--------------------------------- |
| x1       | Real | The x position of the first point  |
| y1       | Real | The y position of the first point  |
| x2       | Real | The x position of the second point |
| y2       | Real | The y position of the second point |
| width    | Real | The width of the line (Default: 1) |

### Returns

```js
None;
```

### Example

```js
draw_set_colour(c_white);
draw_rectangle_width(x - 100, y - 100, x + 150, y + 100, 5);
```

The above code will draw a rectangle with the specified position, scale and rotation.

<p style="text-align: center;">
  <img src="https://i.imgur.com/HY0FjPa.png" width="auto" height="auto">
</p>

---

# draw_rectangle_rotated

Draw a rectangle on the specified position with a rotation specified by the user. The rotation is in degrees. The rectangle is drawn from the center of the rectangle. The rectangle is drawn with a line width of 1 if the outline argument is true.

### Syntax

```js
draw_rectangle_rotated(x, y, width, height, rot, [(outline = true)]);
```

| Argument |  Type   | Description                                              |
| :------- | :-----: | :------------------------------------------------------- |
| x        |  Real   | The x position of the rectangle                          |
| y        |  Real   | The y position of the rectangle                          |
| width    |  Real   | The width of the rectangle                               |
| height   |  Real   | The height of the rectangle                              |
| rot      |  Real   | The rotation of the rectangle                            |
| outline  | Boolean | If the rectangle should be filled or not (Default: true) |

### Returns

```js
None;
```

### Example

```js
draw_set_colour(c_white);
draw_rectangle_rotated(x, y, 64, 32, 45, true);
draw_rectangle_rotated(x + 128, y, 64, 32, -65, false);
```

The above code will drawn 2 rectangles with the specified position, scale and rotation. The first rectangle isn't filled and the second one is.

<p style="text-align: center;">
  <img src="https://i.imgur.com/fvL6ZN6.png" width="auto" height="auto">
</p>

---

# draw_text_outline

Draw a text on the specified position with a outline specified by the user.

### Syntax

```js
draw_text_outline(
  x,
  y,
  string,
  width,
  [(color = c_white)],
  [(color_outline = c_black)],
  [(xscale = 1)],
  [(yscale = 1)],
  [(angle = 0)]
);
```

| Argument      |  Type  | Description                                 |
| :------------ | :----: | :------------------------------------------ |
| x             |  Real  | The x position of the text                  |
| y             |  Real  | The y position of the text                  |
| string        | String | The text to be drawn                        |
| width         |  Real  | The width of the outline                    |
| color         |  Real  | The color of the text (Default: c_white)    |
| color_outline |  Real  | The color of the outline (Default: c_black) |
| xscale        |  Real  | The x scale of the text (Default: 1)        |
| yscale        |  Real  | The y scale of the text (Default: 1)        |
| angle         |  Real  | The angle of the text (Default: 0)          |

### Returns

```js
None;
```

### Example

```js
draw_text_outline(x, y, "Hello World!", 2, c_yellow, c_dkgray);
```

The above code will draw a text with the specified position, color and outline.

<p style="text-align: center;">
  <img src="https://i.imgur.com/arlSbL1.png" width="auto" height="auto">
</p>

---

# draw_text_shadow

Draw a text on the specified position with a shadow specified by the user. The shadow offset is defined in pixels by the user.

### Syntax

```js
draw_text_shadow(
  x,
  y,
  string,
  [(shadow_xoff = 1)],
  [(shadow_yoff = 1)],
  [(color = c_white)],
  [(color_shadow = c_black)],
  [(xscale = 1)],
  [(yscale = 1)],
  [(angle = 0)]
);
```

| Argument     |  Type  | Description                                |
| :----------- | :----: | :----------------------------------------- |
| x            |  Real  | The x position of the text                 |
| y            |  Real  | The y position of the text                 |
| string       | String | The text to be drawn                       |
| shadow_xoff  |  Real  | The x offset of the shadow (Default: 1)    |
| shadow_yoff  |  Real  | The y offset of the shadow (Default: 1)    |
| color        |  Real  | The color of the text (Default: c_white)   |
| color_shadow |  Real  | The color of the shadow (Default: c_black) |
| xscale       |  Real  | The x scale of the text (Default: 1)       |
| yscale       |  Real  | The y scale of the text (Default: 1)       |
| angle        |  Real  | The angle of the text (Default: 0)         |

### Returns

```js
None;
```

### Example

```js
draw_text_shadow(x, y, "Hello World!", 1, 1, c_white, c_red);
```

The above code will draw a text with the specified position, color and shadow.

<p style="text-align: center;">
  <img src="https://i.imgur.com/cpTLg6e.png" width="auto" height="auto">
</p>

---

# draw_text_size

Draws a text using a font size specified by the user. The font size is given in pixels by the last font defined by the user in the draw event. Is recommended to create a font with the "No Scale" option enabled on "Glyph Options" so the font will not be pixelated, also, personally I recommend to set it up to a pixel size of 32 in the editor.

<p style="text-align: center;">
  <img src="https://i.imgur.com/OsJbhb1.png" width="100%" height="auto" />
<p>

### Syntax

```js
draw_text_size(x, y, string, font_size);
```

| Argument  |  Type  | Description                |
| :-------- | :----: | :------------------------- |
| x         |  Real  | The x position of the text |
| y         |  Real  | The y position of the text |
| string    | String | The text to be drawn       |
| font_size |  Real  | The size of the font       |

## Returns

```js
None;
```

### Example

```js
draw_set_align(fa_center, fa_top);
draw_text_size(x, y, "Hello World!", 32);
draw_text_size(x, y + 32, "Hello World!", 24);
draw_text_size(x, y + 64, "Hello World!", 20);
draw_text_size(x, y + 96, "Hello World!", 18);
```

The above code will draw multiple texts with different font sizes.

<p style="text-align: center;">
  <img src="https://i.imgur.com/AWsLa95.png" width="auto" height="auto" />
<p>

---

# draw_fps

Draws the current fps on the specified position. The fps is calculated automatically by the engine.

### Syntax

```js
draw_fps(x, y);
```

| Argument | Type | Description                |
| :------- | :--: | :------------------------- |
| x        | Real | The x position of the text |
| y        | Real | The y position of the text |

## Returns

```js
None;
```

### Example

```js
draw_set_align(fa_left, fa_bottom);
draw_fps_real(0, room_height);
```

The above code will draw the fps on the bottom left corner of the screen.

---

# draw_fps_real

Draws the current fps_real on the specified position. The fps_real is calculated automatically by the engine. The fps_real is the real fps of the game, it is not affected by the fps cap.

### Syntax

```js
draw_fps_real(x, y);
```

| Argument | Type | Description                |
| :------- | :--: | :------------------------- |
| x        | Real | The x position of the text |
| y        | Real | The y position of the text |

## Returns

```js
None;
```

### Example

```js
draw_set_align(fa_right, fa_bottom);
draw_fps_real(room_width, room_height);
```

The above code will draw the fps_real on the bottom right corner of the screen.

---

# draw_set_align

A 1-liner to set the alignment of the text to be drawn. The alignment table is shown below.

| Argument  | Description                   |
| :-------- | :---------------------------- |
| fa_left   | Aligns the text to the left   |
| fa_center | Aligns the text to the center |
| fa_right  | Aligns the text to the right  |
| fa_top    | Aligns the text to the top    |
| fa_middle | Aligns the text to the middle |

### Syntax

```js
draw_set_align(halign, valign);
```

| Argument | Type | Description                          |
| :------- | :--: | :----------------------------------- |
| halign   | Real | The horizontal alignment of the text |
| valign   | Real | The vertical alignment of the text   |

## Returns

```js
None;
```

### Example

```js
draw_set_align(fa_center, fa_center);
draw_text(x, y, "Hello World!");
```

The above code will draw a text with the specified position and centered.

---

# gpu_set_alpha_overwrite

Sets the alpha overwrite flag. If the flag is set to true, the alpha channel of the color will be ignored and the alpha channel of the texture will be used instead. If the flag is set to false, the alpha channel of the color will be used instead.

### Syntax

```js
gpu_set_alpha_overwrite(flag);
```

| Argument |  Type   | Description        |
| :------- | :-----: | :----------------- |
| flag     | Boolean | The flag to be set |

## Returns

```js
None;
```

### Example

```js
gpu_set_alpha_overwrite(false);
draw_rectangle(x, y, x + 32, y + 32, false);
gpu_set_alpha_overwrite(false);
draw_text(x, y, "Hello World!");
```

The above code will draw a rectangle and a text with the specified position and color, then it will draw a rectangle and a text with the specified position and color, but the alpha channel of the color will be ignored and the alpha channel of the texture will be used instead.

# Shaders

> [!WARNING]
> This is an experimental feature. This functions are subject to change. Use at your own risk.

### Table of Contents

- [shader_set_ext](#shader_set_ext)
- [draw_sprite_recolor](#draw_sprite_recolor)
- [draw_sprite_blur](#draw_sprite_blur)
- [draw_surface_recolor](#draw_surface_recolor)
- [draw_surface_blur](#draw_surface_blur)

---

# shader_set_ext

Setup a shader with uniforms and attributes from a parameters struct.

This function will automatically get the shader uniforms by the key names, and define if the uniforms are real numbers or arrays, and use the correct function to set them.

The main structs should be named `u_float`, `u_int` and `u_texture` for the floats, ints and sprite textures respectively. Inside this structs there should be subkeys with uniform name and value as seen on the example below.

### Syntax

```js
shader_set_ext(shader, [(params = {})]);
```

| Argument |  Type  | Description                              |
| :------- | :----: | :--------------------------------------- |
| shader   | Shader | The shader to setup.                     |
| params   | Struct | The parameters to setup the shader with. |

### Returns

```js
None;
```

### Example

```js
var _sprite_tex = sprite_get_texture(sprite_index, 0);
shader_set(shd_passthrough, {
  u_float: {
    uSomethingFloat: 0.8,
    uOtherThingFloat: [0.2, 1.0, 0.5],
  },
  u_int: {
    uSomethingInt: 100,
    uOtherThingInt: [20, 30, 5, 10],
  },
  u_texture: {
    uSomethingTexture: _sprite_tex,
  },
});

draw_self();

shader_reset();
```

The above code will setup the shader with the following uniforms:

```glsl
uniform float uSomethingFloat;
uniform vec3 uOtherThingFloat;
uniform int uSomethingInt;
uniform ivec4 uOtherThingInt;
uniform sampler2D uSomethingTexture;
```

Then, draw the object with the shader, and reset the shader.

---

# draw_sprite_recolor

Draws a sprite and recolors it fully or partially. The recoloring is done by multiplying the color of the sprite with the color specified by the user. If the user specifies a color with `blend` param as 0, the sprite will be drawn with the original color. **This function depends on the `shd_gml_ext_recolor` shader, so it is necessary to import it into the project.**

### Syntax

```js
draw_sprite_recolor(
  sprite,
  subimage,
  x,
  y,
  color,
  blend,
  [(xscale = 1)],
  [(yscale = 1)],
  [(rot = 0)],
  [(alpha = 1)]
);
```

| Argument |  Type  | Description                                |
| :------- | :----: | :----------------------------------------- |
| sprite   | Sprite | The sprite to be drawn                     |
| subimage |  Real  | The subimage of the sprite to be drawn     |
| x        |  Real  | The x position of the sprite               |
| y        |  Real  | The y position of the sprite               |
| color    | Color  | The color to be used to recolor the sprite |
| blend    |  Real  | The blend of the color                     |
| xscale   |  Real  | The x scale of the sprite. (default: 1)    |
| yscale   |  Real  | The y scale of the sprite. (default: 1)    |
| rot      |  Real  | The rotation of the sprite. (default: 0)   |
| alpha    |  Real  | The alpha of the sprite. (default: 1)      |

## Returns

```js
None;
```

### Example

```js
draw_self();
if (is_hit) {
  draw_sprite_recolor(spr_test, 0, x, y, #FF00FF, .66);
}
```

The above code will draw the sprite with the original color if the player is not hit, and will draw the player sprite with the purple color if the is hit.

<p style="text-align: center;">
  <img src="https://i.imgur.com/kROXgGh.png" />
<p>

---

# draw_sprite_blur

Draws a sprite and blurs it fully or partially. The blurring is done by using a gaussian blur shader. **This function depends on the `shd_gml_ext_blur_gauss` shader, so it is necessary to import it into the project.**

### Syntax

```js
draw_sprite_blur(
  sprite,
  subimage,
  x,
  y,
  blur_amount,
  [(xscale = 1)],
  [(yscale = 1)],
  [(rot = 0)],
  [(alpha = 1)]
);
```

| Argument    |  Type  | Description                                           |
| :---------- | :----: | :---------------------------------------------------- |
| sprite      | Sprite | The sprite to be drawn                                |
| subimage    |  Real  | The subimage of the sprite to be drawn                |
| x           |  Real  | The x position of the sprite                          |
| y           |  Real  | The y position of the sprite                          |
| blur_amount |  Real  | The amount of the blur. (recommended from 0.0 to 1.0) |
| xscale      |  Real  | The x scale of the sprite. (default: 1)               |
| yscale      |  Real  | The y scale of the sprite. (default: 1)               |
| rot         |  Real  | The rotation of the sprite. (default: 0)              |
| alpha       |  Real  | The alpha of the sprite. (default: 1)                 |

## Returns

```js
None;
```

### Example

```js
draw_sprite_blur(spr_test, 0, x, y, 0.5);
```

The above code will draw the sprite with the blur amount of 0.5.

<p style="text-align: center;">
  <img src="https://i.imgur.com/dm61oMA.png" />
<p>

---

# draw_surface_recolor

Draws a surface and recolors it fully or partially. The recoloring is done by multiplying the color of the surface with the color specified by the user. If the user specifies a color with `blend` param as 0, the surface will be drawn with the original color. **This function depends on the `shd_gml_ext_recolor` shader, so it is necessary to import it into the project.**

### Syntax

```js
draw_surface_recolor(
  surface,
  color,
  blend,
  x,
  y,
  [(xscale = 1)],
  [(yscale = 1)],
  [(rot = 0)],
  [(alpha = 1)]
);
```

| Argument |  Type   | Description                                 |
| :------- | :-----: | :------------------------------------------ |
| surface  | Surface | The surface to be drawn                     |
| color    |  Color  | The color to be used to recolor the surface |
| blend    |  Real   | The blend of the color                      |
| x        |  Real   | The x position of the surface               |
| y        |  Real   | The y position of the surface               |
| xscale   |  Real   | The x scale of the surface. (default: 1)    |
| yscale   |  Real   | The y scale of the surface. (default: 1)    |
| rot      |  Real   | The rotation of the surface. (default: 0)   |
| alpha    |  Real   | The alpha of the surface. (default: 1)      |

## Returns

```js
None;
```

### Example

```js
srf_test = surface_create(200, 200);
surface_set_target(surf);
draw_sprite(spr_test, 0, 16, 16);
surface_reset_target();

draw_surface_recolor(srf_test, #FF00FF, .66, x, y);
```

The above code will draw the surface with the purple color with the blend of 0.66.

<p style="text-align: center;">
  <img src="https://i.imgur.com/PRaG1VT.png" />
<p>

---

# draw_surface_blur

Draws a surface and blurs it fully or partially. The blurring is done by using a gaussian blur shader. **This function depends on the `shd_gml_ext_blur_gauss` shader, so it is necessary to import it into the project.**

### Syntax

```js
draw_surface_blur(
  surface,
  blur_amount,
  x,
  y,
  [(xscale = 1)],
  [(yscale = 1)],
  [(rot = 0)],
  [(alpha = 1)]
);
```

| Argument    |  Type   | Description                                           |
| :---------- | :-----: | :---------------------------------------------------- |
| surface     | Surface | The surface to be drawn                               |
| blur_amount |  Real   | The amount of the blur. (recommended from 0.0 to 1.0) |
| x           |  Real   | The x position of the surface                         |
| y           |  Real   | The y position of the surface                         |
| xscale      |  Real   | The x scale of the surface. (default: 1)              |
| yscale      |  Real   | The y scale of the surface. (default: 1)              |
| rot         |  Real   | The rotation of the surface. (default: 0)             |
| alpha       |  Real   | The alpha of the surface. (default: 1)                |

## Returns

```js
None;
```

### Example

```js
srf_test = surface_create(200, 200);
surface_set_target(surf);
draw_sprite(spr_test, 0, 16, 16);
surface_reset_target();

draw_surface_blur(srf_test, 0.5, x, y);
```

The above code will draw the surface with the blur amount of 0.5.

<p style="text-align: center;">
  <img src="https://i.imgur.com/6X673jd.png" />
<p>

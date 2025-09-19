# Colors

### Table of Contents

- [rgb](#rgb)
- [hsv](#hsv)
- [color_get_rgb](#color_get_rgb)
- [color_get_hsv](#color_get_hsv)
- [color_get_rgb_normalized](#color_get_rgb_normalized)
- [color_get_hsv_normalized](#color_get_hsv_normalized)
- [color_to_hex_rgb](#color_to_hex_rgb)
- [color_to_hex_rgba](#color_to_hex_rgba)
- [color_hex_rgba_to_abgr](#color_hex_rgba_to_abgr)
- [color_rgba_get_alpha](#color_rgba_get_alpha)

# rgb

Creates a color from the RGB values passed as arguments. Serves as a shortcut for `make_color_rgb`. The values passed as arguments will be wrapped between 0 and 255.

### Syntax

```js
rgb(red, green, blue);
```

| Argument | Type  | Description                  |
| :------- | :---: | :--------------------------- |
| red      | Real  | The red value of the color   |
| green    | Real  | The green value of the color |
| blue     | Real  | The blue value of the color  |

### Returns

```js
Real;
```

### Example

```js
var _color = rgb(255, 0, 0);
```

The above code will create a color with the RGB values of 255, 0, 0.

---

# hsv

Creates a color from the HSV values passed as arguments. Serves as a shortcut for `make_color_hsv`. The values passed as arguments will be wrapped between 0 and 255.

### Syntax

```js
hsv(hue, saturation, value);
```

| Argument   | Type  | Description                       |
| :--------- | :---: | :-------------------------------- |
| hue        | Real  | The hue value of the color        |
| saturation | Real  | The saturation value of the color |
| value      | Real  | The value of the color            |

### Returns

```js
Real;
```

### Example

```js
var _color = hsv(0, 255, 255);
```

The above code will create a color with the HSV values of 0, 255, 255.

---

# color_get_rgb ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Gets the RGB values of the color passed as argument. Serves as a shortcut for `color_get_red`, `color_get_green`, and `color_get_blue`.

### Syntax

```js
color_get_rgb(color);
```

| Argument |          Type          | Description                          |
| :------- | :--------------------: | :----------------------------------- |
| color    | Real or Constant.Color | The color to get the RGB values from |

### Returns

```js
Array<Color>;
```

### Example

```js
var _color = color_get_rgb(25000);
```

The above code will get the RGB values of the color 25000 and store them in the array `_color `. The resulting array being [0, 97, 168].

---

# color_get_hsv ![](https://img.shields.io/badge/v1.3.0-7a6e7e?style=flat)

Gets the HSV values of the color passed as argument. Serves as a shortcut for `color_get_hue`, `color_get_saturation`, and `color_get_value`.

### Syntax

```js
color_get_hsv(color);
```

| Argument |          Type          | Description                          |
| :------- | :--------------------: | :----------------------------------- |
| color    | Real or Constant.Color | The color to get the HSV values from |

### Returns

```js
Array<Color>;
```

### Example

```js
var _color = color_get_hsv(25000);
```

The above code will get the HSV values of the color 25000 and store them in the array `_color`. The resulting array being [210, 255, 168].

---

# color_get_rgb_normalized ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)

Gets the RGB values of the color passed as argument, normalized between 0 and 1. Works the same way as `color_get_rgb`, but the values are divided by 255.

### Syntax

```js
color_get_rgb_normalized(color);
```

| Argument |          Type          | Description                                     |
| :------- | :--------------------: | :---------------------------------------------- |
| color    | Real or Constant.Color | The color to get the normalized RGB values from |

### Returns

```js
Array<Color>;
```

### Example

```js
var _color = color_get_rgb_normalized(c_white);
```

The above code will get the normalized RGB values of the color `c_white` and store them in the array `_color`. The resulting array being [1, 1, 1].

---

# color_get_hsv_normalized ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)
Gets the HSV values of the color passed as argument, normalized between 0 and 1. Works the same way as `color_get_hsv`, but the values are divided by 255.

### Syntax

```js
color_get_hsv_normalized(color);
```

| Argument |          Type          | Description                                     |
| :------- | :--------------------: | :---------------------------------------------- |
| color    | Real or Constant.Color | The color to get the normalized HSV values from |

### Returns

```js
Array<Color>;
```

### Example

```js
var _color = color_get_hsv_normalized(c_white);
```

The above code will get the normalized HSV values of the color `c_white` and store them in the array `_color`. The resulting array being [0, 0, 1].

---

# color_to_hex_rgb ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)
Converts a decimal color value to a hexadecimal string. The resulting string will be in the format `RRGGBB`.

### Syntax

```js
color_to_hex_rgb(color);
```

| Argument |          Type          | Description                        |
| :------- | :--------------------: | :--------------------------------- |
| color    | Real or Constant.Color | The decimal color value to convert |

### Returns

```js
String;
```

### Example

```js
var _hexColor = color_to_hex_rgb(c_red);
return "#" + _hexColor;
```

The above code will convert the decimal color value of `c_red` to a hexadecimal string and store it in the variable `_hexColor`. The returning string being `#FF0000`.

---

# color_to_hex_rgba ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)
Converts a decimal color value to a hexadecimal string. The resulting string will be in the format `RRGGBBAA`.

### Syntax

```js
color_to_hex_rgba(color, alpha);
```

| Argument |          Type          | Description                             |
| :------- | :--------------------: | :-------------------------------------- |
| color    | Real or Constant.Color | The decimal color value to convert      |
| alpha    |          Real          | The normalized alpha value of the color |

### Returns

```js
String;
```

### Example

```js
var _hexColor = color_to_hex_rgba(c_red, 0.5);
return "#" + _hexColor;
```

The above code will convert the decimal color value of `c_red` with an alpha of 0.5 to a hexadecimal string and store it in the variable `_hexColor`. The returning string being `#FF000080`.

---

# color_hex_rgba_to_abgr ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)
Converts a hexadecimal color string in the format `RRGGBBAA` to a decimal color value in the ABGR format `AABBGGRR` to comply with GameMaker color code.

### Syntax

```js
color_hex_rgba_to_abgr(hex);
```

| Argument |  Type  | Description                             |
| :------- | :----: | :-------------------------------------- |
| hex      | String | The hexadecimal color string to convert |
### Returns

```js
String;
```

### Example

```js
var _color = color_hex_rgba_to_abgr("FF000080");
return _color;
```

The above code will convert the hexadecimal color string `FF000080` to a decimal color value in the ABGR format and store it in the variable `_color`. The returning string will be `800000FF` transformed value being `2147483903` in GameMaker terms.

---

# color_rgba_get_alpha ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)
Gets the alpha value of a color in the range of 0 to 1.

### Syntax

```js
color_rgba_get_alpha(color);
```

| Argument | Type  | Description                     |
| :------- | :---: | :------------------------------ |
| color    | Real  | The color to get the alpha from |

### Returns

```js
Real;
```

### Example

```js
var _alpha = color_rgba_get_alpha(2147483903);
```

The above code will get the alpha value of the color `2147483903` and store it in the variable `_alpha`. The resulting value being `0.5`.


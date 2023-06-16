# Colors

### Table of Contents

- [rgb](#rgb)
- [hsv](#hsv)
- [color_get_rgb](#color_get_rgb)
- [color_get_hsv](#color_get_hsv)
- [color_get_alpha](#color_get_alpha)
- [dec_rgb2rgba](#dec_rgb2rgba)
- [dec2hex](#dec2hex)
- [rgba_dec2hex](#rgba_dec2hex)
- [hex_rgba2abgr](#hex_rgba2abgr)

# rgb

Creates a color from the RGB values passed as arguments. Serves as a shortcut for `make_color_rgb`. The values passed as arguments will be wrapped between 0 and 255.

### Syntax

```js
rgb(red, green, blue);
```

| Argument | Type | Description                  |
| :------- | :--: | :--------------------------- |
| red      | Real | The red value of the color   |
| green    | Real | The green value of the color |
| blue     | Real | The blue value of the color  |

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

| Argument   | Type | Description                       |
| :--------- | :--: | :-------------------------------- |
| hue        | Real | The hue value of the color        |
| saturation | Real | The saturation value of the color |
| value      | Real | The value of the color            |

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

# color_get_rgb

Gets the RGB values of the color passed as argument. Serves as a shortcut for `color_get_red`, `color_get_green`, and `color_get_blue`.

### Syntax

```js
color_get_rgb(color);
```

| Argument | Type | Description                          |
| :------- | :--: | :----------------------------------- |
| color    | Real | The color to get the RGB values from |

### Returns

```js
Array;
```

### Example

```js
var _color = color_get_rgb(25000);
```

The above code will get the RGB values of the color 25000 and store them in the array `_color `. The resulting array being [0, 97, 168].

---

# color_get_hsv

Gets the HSV values of the color passed as argument. Serves as a shortcut for `color_get_hue`, `color_get_saturation`, and `color_get_value`.

### Syntax

```js
color_get_hsv(color);
```

| Argument | Type | Description                          |
| :------- | :--: | :----------------------------------- |
| color    | Real | The color to get the HSV values from |

### Returns

```js
Array;
```

### Example

```js
var _color = color_get_hsv(25000);
```

The above code will get the HSV values of the color 25000 and store them in the array `_color`. The resulting array being [210, 255, 168].

---

# color_get_alpha

Gets the alpha value of the color passed as argument.

### Syntax

```js
color_get_alpha(color);
```

| Argument | Type | Description                           |
| :------- | :--: | :------------------------------------ |
| color    | Real | The color to get the alpha value from |

### Returns

```js
Real;
```

### Example

```js
var _alpha = color_get_alpha(25000);
```

The above code will get the alpha value of the color 25000 and store it in the variable `_alpha`. The resulting value being 255.

---

# dec_rgb2rgba

Converts a color from RGB to RGBA. Returns the color passed as argument with an alpha value of 255.

### Syntax

```js
dec_rgb2rgba(color);
```

| Argument | Type | Description                  |
| :------- | :--: | :--------------------------- |
| color    | Real | The color to convert to RGBA |

### Returns

```js
Real;
```

### Example

```js
var _color = dec_rgb2rgba(25000);
```

The above code will convert the color 25000 to RGBA and store it in the variable `_color`.

---

# dec2hex

Converts a decimal value to hexadecimal.

### Syntax

```js
dec2hex(dec);
```

| Argument | Type | Description                  |
| :------- | :--: | :--------------------------- |
| dec      | Real | The decimal value to convert |

### Returns

```js
String;
```

### Example

```js
var _hex = dec2hex(25000);
```

The above code will convert the decimal value 25000 to hexadecimal and store it in the variable `_hex`. The resulting value being "0061A8".

---

# rgba_dec2hex

Converts a color from RGBA to hexadecimal. Returns the hexadecimal value of 8 chars of the color passed as argument.

### Syntax

```js
rgba_dec2hex(color);
```

| Argument | Type | Description                         |
| :------- | :--: | :---------------------------------- |
| color    | Real | The color to convert to hexadecimal |

### Returns

```js
String;
```

### Example

```js
var _hex = rgba_dec2hex(25000);
```

The above code will convert the color 25000 to hexadecimal and store it in the variable `_hex`. The resulting value being "0061A8FF".

---

# hex_rgba2abgr

Converts a color from rgba hexadecimal to ABGR. Returns the hexadecimal color passed as argument in ABGR format.

### Syntax

```js
hex_rgba2abgr(hex);
```

| Argument |  Type  | Description                      |
| :------- | :----: | :------------------------------- |
| hex      | String | The hexadecimal value to convert |

### Returns

```js
Real;
```

### Example

```js
var _color = hex_rgba2abgr("0061A8FF");
```

The above code will convert the hexadecimal value "0061A8FF" to ABGR and store it in the variable `_color`. The resulting value being "FFA86100".

---

# Colors

# Table of Contents

- [rgb](#rgb)
- [hsv](#hsv)
- [color_get_rgb](#color_get_rgb)
- [color_get_hsv](#color_get_hsv)

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

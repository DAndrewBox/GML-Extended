# Colors

> [!WARNING]
> This is an experimental feature. This functions are subject to change. Use at your own risk.

### Table of Contents

- [color_rgba_get_alpha](#color_rgba_get_alpha)
- [dec_rgb2rgba](#dec_rgb2rgba)
- [dec2hex](#dec2hex)
- [rgba_dec2hex](#rgba_dec2hex)
- [hex_rgba2abgr](#hex_rgba2abgr)

# color_rgba_get_alpha

Gets the alpha value of the color passed as argument.

### Syntax

```js
color_rgba_get_alpha(color);
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
var _alpha = color_rgba_get_alpha(25000);
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

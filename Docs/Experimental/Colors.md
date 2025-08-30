# Colors

> [!WARNING]
> This is an experimental feature. This functions are subject to change. Use at your own risk.

### Table of Contents

- [dec_rgb2rgba](#dec_rgb2rgba)

# dec_rgb2rgba

Converts a color from RGB to RGBA. Returns the color passed as argument with an alpha value of 255.

### Syntax

```js
dec_rgb2rgba(color);
```

| Argument | Type  | Description                  |
| :------- | :---: | :--------------------------- |
| color    | Real  | The color to convert to RGBA |

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

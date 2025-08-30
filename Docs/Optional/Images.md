# Images

### Table of Contents

- [image_loop_index](#image_loop_index)
- [image_set](#image_set)
- [image_set_scale](#image_set_scale)
- [image_smooth_rotate](#image_smooth_rotate)

---

# image_loop_index ![](https://img.shields.io/badge/v1.2.1-3e5f4a?style=flat)

Loops the index of an image between a start and end index (end frame included).

### Syntax

```js
image_loop_index(start_index, end_index, speed);
```

| Argument    | Type  | Description                  |
| :---------- | :---: | :--------------------------- |
| start_index | Real  | The first index of the image |
| end_index   | Real  | The last index of the image  |
| speed       | Real  | The speed of the animation   |

### Returns

```js
Real;
```

### Example

```js
image_speed = 0.5;
image_index = image_loop_index(0, 3, image_speed);
```

The above code will loop the image_index between 0 and 3 with a speed of 0.5. So after 8 frames, the image_index will be 0 again since the end_index is included and image_index is floored.

---

# image_set ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Sets the image properties. This function is used to set the image properties of the instance. The properties are the index, speed, xscale, yscale, angle, blend, and alpha.

### Syntax

```js
image_set([index], [speed], [xscale], [yscale], [angle], [blend], [alpha]);
```

| Argument | Type  | Description                       |
| :------- | :---: | :-------------------------------- |
| index    | Real  | The index of the image            |
| speed    | Real  | The speed of the animation        |
| xscale   | Real  | The horizontal scale of the image |
| yscale   | Real  | The vertical scale of the image   |
| angle    | Real  | The angle of the image            |
| blend    | Real  | The blend mode of the image       |
| alpha    | Real  | The alpha value of the image      |

### Returns

```js
Bool;
```

### Example

```js
image_set(0, 0.5, 1, 1, 0, 0, 1);
```

The above code will set the image properties of the instance to the index 0, speed 0.5, xscale 1, yscale 1, angle 0, blend 0, and alpha 1.

---

# image_set_scale ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Sets the image xscale and yscale properties.

### Syntax

```js
image_set_scale(xscale, yscale);
```

| Argument | Type  | Description                       |
| :------- | :---: | :-------------------------------- |
| xscale   | Real  | The horizontal scale of the image |
| yscale   | Real  | The vertical scale of the image   |

### Returns

```js
Bool;
```

### Example

```js
image_set_scale(1, 1);
```

The above code will set the image xscale and yscale properties of the instance to 1.

---

# image_smooth_rotate ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Rotates the image smoothly to a given angle. This function should be used on the step event.

### Syntax

```js
image_smooth_rotate(angle, [speed_factor]);
```

| Argument     | Type  | Description                               |
| :----------- | :---: | :---------------------------------------- |
| angle        | Real  | The angle to rotate the image to          |
| speed_factor | Real  | The speed of the rotation. (Default: 0.1) |

### Returns

```js
Bool;
```

### Example

```js
image_smooth_rotate(90, 0.1);
```

The above code will rotate the image smoothly to 90 degrees with a speed factor of 0.1.

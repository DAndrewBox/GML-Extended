# Math

### Table of Contents

- [round_dec](#round_dec)
- [near](#near)
- [between](#between)
- [rng](#rng)
- [choice_weighted](#choice_weighted)
- [range](#range)
- [wrap](#wrap)
- [random_linear](#random_linear)
- [random_range_linear](#random_range_linear)
- [uuid_v4](#uuid_v4)
- [percentage](#percentage)
- [dec2hex](#dec2hex)

---

# round_dec

Returns a rounded number with N decimal places to the nearest tenth.

### Syntax

```js
round_dec(x, [(decimals = 0)]);
```

| Argument | Type  | Description                              |
| :------- | :---: | :--------------------------------------- |
| x        | Real  | The number to round                      |
| decimals | Real  | The number of decimal places to round to |

### Returns

```js
Real;
```

### Example

```js
var _x = 1.23456789;
var _dec = 3;
var _x_3dec = round_dec(_x, _dec);
show_debug_message(
  "Rounded to 3 decimals: " + string_format(_x_3dec, _dec, _dec)
);
```

The above code will set the var `_x_3dec` as an rounded number with 3 decimal places and the show on console. The result will be `1.235`.

---

# near

Returns a boolean if the first value is near the second value with a defined offset.

### Syntax

```js
near(value, value_to, offset);
```

| Argument | Type  | Description                |
| :------- | :---: | :------------------------- |
| value    | Real  | The value to check         |
| value_to | Real  | The value to check against |
| offset   | Real  | The offset to check        |

### Returns

```js
Bool;
```

### Example

```js
var _value_base = 0;
var _value_to = 10;
var _offset = 1;

while (!near(_value_base, _value_to, _offset)) {
  _value_base += 1;
  show_debug_message("Value: " + string(_value_base));
}
```

The above code will check if the `_value_to_check` is near the `_value_to` with an offset of `_offset`. If it's not, it will add 1 to the `_value_to_check` and show the value on console.

The output will be: `Value: 1`, `Value: 2`, [...] , `Value: 9`, and will stop before `Value: 10` since the offset is 1.

---

# between

Returns a boolean if the first value is near the second value with an offset.

### Syntax

```js
between(value, min, max);
```

| Argument | Type  | Description        |
| :------- | :---: | :----------------- |
| value    | Real  | The value to check |
| min      | Real  | The minimum value  |
| max      | Real  | The maximum value  |

### Returns

```js
Bool;
```

### Example

```js
var _val = 5;
var _min = 0;
var _max = 10;

if (between(_val, _min, _max)) {
  show_debug_message(
    "Value is between " + string(_min) + " and " + string(_max)
  );
}
```

The above code will check if the `_val` is between `_min` and `_max`. If it is, it will show a message on console.

---

# rng

Returns a boolean if the random value is less than the chance. All values must be between 0 and 1 where 0 is 0% chance and 1 is 100%.

### Syntax

```js
rng(value);
```

| Argument | Type  | Description                   |
| :------- | :---: | :---------------------------- |
| value    | Real  | The normalized value to check |

### Returns

```js
Bool;
```

### Example

```js
var _chance = 0.5; // 50% chance

if (rng(_chance)) {
  global.random_event = true;
}
```

The above code will check if the `_chance` is less than the random value. If it is, it will set the global variable `random_event` to `true`.

---

# choice_weighted

Returns a random value from an array of values with a weight. Both arrays must be the same length and weights must sum to 1, if not, `noone` will be returned.

### Syntax

```js
choice_weighted(values, weights);
```

| Argument | Type  | Description               |
| :------- | :---: | :------------------------ |
| values   | Array | The values to choose from |
| weights  | Array | The weights of the values |

### Returns

```js
Real, String, Bool, Array or Struct
```

### Example

```js
var _values = [0, 1, 2, 3];
var _chance = [0.5, 0.25, 0.15, 0.1];
var _choice = choice_weighted(_values, _chance);

global.random_choice[_choice] = true;
```

The above code will choose a random value from the `_values` array with a weight of the `_chance` array. It will then set the global variable `random_choice` to `true` for the chosen value.

---

# range

Returns an array of numbers from `from` to `to` with a step of `step`. If `step` is not provided, it will default to 1. If `from` is greater than `to`, the array will be reversed.

### Syntax

```js
range(to, [(from = 0)], [(step = 1)]);
```

| Argument | Type  | Description                           |
| :------- | :---: | :------------------------------------ |
| to       | Real  | The end of the range                  |
| from     | Real  | The start of the range. (default = 0) |
| step     | Real  | The step of the range. (default = 1)  |

### Returns

```js
Array;
```

### Example

```js
global.hp_per_level = range(1000, 75, 25);

for (var i = 0; i < array_length_1d(global.hp_per_level); i++) {
  show_debug_message(
    "Level " + string(i) + " HP: " + string(global.hp_per_level[i])
  );
}
```

The above code will create an array of numbers from 75 to 1000 with a step of 25 for player's hp. Then it will show the values on console.

---

# wrap

Wraps the value to the range of `min` to `max`. If the value is less than `min`, it will return `max`. If the value is greater than `max`, it will return `min`.

### Syntax

```js
wrap(value, min, max);
```

| Argument | Type  | Description       |
| :------- | :---: | :---------------- |
| value    | Real  | The value to wrap |
| min      | Real  | The minimum value |
| max      | Real  | The maximum value |

### Returns

```js
Real;
```

### Example

```js
var _val = 9;
var _min = 0;
var _max = 5;

show_debug_message("Wrapped value: " + string(wrap(_val, _min, _max)));
```

The above code will wrap the `_val` to the range of `_min` to `_max`. Then it will show the wrapped value on console.

The output will be `Wrapped value: 4`.

---

# random_linear ![](https://img.shields.io/badge/v1.4.0-916800?style=flat)

Returns a random value with a linear distribution. This is more random than `random()` since the .

### Syntax

```js
random_linear(value);
```

| Argument | Type  | Description                      |
| :------- | :---: | :------------------------------- |
| value    | Real  | The value to check. (Default: 1) |

### Returns

```js
Real;
```

### Example

```js
var _val = random_linear(10);

show_debug_message("Random value: " + string(_val));
```

The above code will return a random value with a linear distribution. Then it will show the random value on console.

---

# random_linear_range ![](https://img.shields.io/badge/v1.5.3-5cd3b4?style=flat)

Returns a random value with a linear distribution within a range. This is more random than `random_range()`.

### Syntax

```js
random_linear_range(n1, n2);
```

| Argument | Type  | Description                          |
| :------- | :---: | :----------------------------------- |
| n1       | Real  | Minimum value of the range to check. |
| n2       | Real  | Maximum value of the range to check. |

### Returns

```js
Real;
```

### Example

```js
var _val = random_linear_range(5, 15);
show_debug_message("Random value: " + string(_val));
```

The above code will return a random value with a linear distribution between `5` and `15`. Then it will show the random value on console.

---


# uuid_v4 ![](https://img.shields.io/badge/v1.4.0-916800?style=flat)

Returns a random UUID v4.

### Syntax

```js
uuid_v4();
```

### Returns

```js
String;
```

### Example

```js
var _uuid = uuid_v4();

show_debug_message("UUID: " + _uuid);
```

The above code will return a random UUID v4. Then it will show the UUID on console.

---

# percentage ![](https://img.shields.io/badge/v1.5.0-5cd3b4?style=flat)

Returns the percentage of the given values.

### Syntax

```js
percentage(current_value, total_value);
```

| Argument      | Type  | Description                |
| :------------ | :---: | :------------------------- |
| current_value | Real  | The current value          |
| total_value   | Real  | The total value to compare |

### Returns

```js
Real;
```

### Example

```js
var _current = 50;
var _total = 100;

show_debug_message("Percentage: " + string(percentage(_current, _total)) + "%");
```

The above code will return the percentage of the `_current` value compared to the `_total` value. Then it will show the percentage on console. The output will be `Percentage: 50%`.

---

# dec2hex ![](https://img.shields.io/badge/v1.5.2-5cd3b4?style=flat)

Converts a decimal number to a hexadecimal string. The resulting string will have a minimum length, padded with leading zeros if necessary.

### Syntax

```js
dec2hex(value, [min_length = 6]);
```

| Argument   | Type  | Description                                               |
| :--------- | :---: | :-------------------------------------------------------- |
| value      | Real  | The decimal number to convert                             |
| min_length | Real  | The minimum length of the resulting string. (default = 6) |

### Returns

```js
String;
```

### Example

```js
var _dec = 255;
var _hex = dec2hex(_dec, 4);
show_debug_message("Hex: " + _hex);
```

The above code will convert the decimal number `255` to a hexadecimal string with a minimum length of `4`. The resulting string will be `00FF`. Then it will show the hexadecimal string on console.
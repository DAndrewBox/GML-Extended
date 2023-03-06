# Date & Time

### Table of Contents

- [unix_timestamp](#unix_timestamp)
- [now](#now)
- [unix_timestamp_format](#unix_timestamp_format)
- [unix_to_datetime](#unix_to_datetime)
- [datetime_get_timestamp](#datetime_get_timestamp)
- [time_performance](#time_performance)

---

# unix_timestamp

Returns a Unix timestamp for the current or given GameMaker datetime. If no argument is given, the current datetime is used.

Originally written by Xot on [GMLscripts](https://www.gmlscripts.com/script/unix_timestamp).

### Syntax

```js
unix_timestamp(datetime);
```

| Argument |   Type   | Description                                  |
| :------- | :------: | :------------------------------------------- |
| datetime | DateTime | The datetime to get the Unix timestamp from. |

### Returns

```js
Real;
```

### Example

```js
var _datetime = date_time_create(2022, 1, 1, 0, 0, 0);
var _timestamp = unix_timestamp(_datetime);
show_debug_message(_timestamp);
```

The above code will return `1640995200` since it"s the Unix timestamp for the given datetime since the epoch.

---

# now

Returns the current datetime in unix timestamp format.

### Syntax

```js
now();
```

### Returns

```js
Real;
```

### Example

```js
var _timestamp = now();
show_debug_message(_timestamp);
```

The above code will return the current datetime in Unix timestamp format.

---

# unix_timestamp_format

Returns a formatted datetime from a Unix timestamp. If no argument is given, the current datetime is used.

### Syntax

```js
unix_timestamp_format(timestamp, [(format = "%YYYY-%MM-%DD %HH:%NN:%SS")]);
```

| Argument  |  Type  | Description                                                  |
| :-------- | :----: | :----------------------------------------------------------- |
| timestamp |  Real  | The Unix timestamp to format.                                |
| format    | String | The format to use. (default = `"%YYYY-%MM-%DD %HH:%NN:%SS"`) |

### Formats

| Format | Description                   |
| :----- | :---------------------------- |
| %YYYY  | The year.                     |
| %YY    | The year without the century. |
| %MM    | The month with 0 padding.     |
| %M     | The month without 0 padding.  |
| %DD    | The day with 0 padding.       |
| %D     | The day without 0 padding.    |
| %HH    | The hour with 0 padding.      |
| %H     | The hour without 0 padding.   |
| %NN    | The minute with 0 padding.    |
| %SS    | The second with 0 padding.    |
| %mm    | The month name.               |
| %m     | The month abbreviation.       |
| %dd    | The weekday name.             |
| %d     | The weekday abbreviation.     |

### Returns

```js
String;
```

### Examples

**Example 1:**

```js
var _timestamp = now();
var _datetime = unix_timestamp_format(_timestamp, "%YYYY-%MM-%DD %HH:%NN:%SS");

show_debug_message(_datetime);
```

The above code will return the current datetime in the format `YYYY-MM-DD HH:MM:SS`.

**Example 2:**

```js
var _now = now();
var _now_formatted = unix_timestamp_format(
  _now,
  "%dd, %mm %DD, %YYYY at %HH:%NN"
);
show_debug_message(_now_formatted);
```

The above code will return the current datetime as `Monday, November 11, 2022 at 20:05`.

---

# unix_to_datetime

Returns a GameMaker datetime from a Unix timestamp.

### Syntax

```js
unix_to_datetime(timestamp);
```

### Returns

```js
Datetime;
```

### Example

```js
var _timestamp = now();
var _dt = unix_to_datetime(_timestamp);
var _day = date_get_day(_dt);
show_debug_message(_day);
```

The above code will return the current day of the month as a number.

---

# datetime_get_timestamp

Returns a string of the current time in format `<%HH:%NN:%SS>`.

### Syntax

```js
datetime_get_timestamp();
```

### Returns

```js
String;
```

### Example

```js
var _time = datetime_get_timestamp();
show_debug_message(_time);
```

The above code will show the current time in format `<HH:MM:SS>`.

---

# time_performance

A way to test the performance of a function or code block. It will show in console the time it took to execute the code. It's useful for testing the performance of your code.

### Syntax

```js
time_performance(function, args, [iterations=1]);
```

| Argument   |   Type   | Description                                              |
| :--------- | :------: | :------------------------------------------------------- |
| function   | Function | The function to test.                                    |
| args       |  Array   | The arguments to pass to the function.                   |
| iterations | Integer  | The number of times to run the function. (default = `1`) |

### Returns

```js
None
```

### Example

```js
time_performance(function() {
  var _datetime = date_time_create(2022, 1, 1, 0, 0, 0);
  var _timestamp = unix_timestamp(_datetime);
  show_debug_message(_timestamp);
}, [], 1000);
```

The above code will test the performance of the `unix_timestamp` function 1000 times on your machine.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Surfaces.md">Surfaces</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Draw.md">Draw</a>
    </h3>
  </div>

</div>

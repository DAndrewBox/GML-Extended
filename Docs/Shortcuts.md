# Shortcuts
### Table of Contents
- [del](#del)
- [size](#size)


# del
Deletes an instance and executes the destroy event of the object. Serves as a shortcut for `instance_destroy`.

### Syntax
  ```js
  del(object_index | id);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| object_index or id | Real or Ref | The index of the object or the id of the instance |

### Returns
  ```js
  None
  ```

### Example
```js
del(obj_Player);
```
The above code will delete the player and execute the destroy event of the object.

---
# size
Returns the size or length of the element. If the element is an array, it will return the length of the array. If the element is a string, it will return the length of the string. If the element is a struct, it will return the number of variables in the struct. If the element is a real, it will return the length of a string of the value.

### Syntax
  ```js
  size(element);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| element | Real, String, Bool, Array or Struct | The element to get the size of |
### Returns
  ```js
  Real
  ```

### Example
```js
var _array = [0, 1, 2, 3];
var _string = "Hello World!";
var _struct = {a: 0, b: 1, c: 2};
var _real = 123;

show_debug_message("Array size: " + string(size(_array)));
show_debug_message("String size: " + string(size(_string)));
show_debug_message("Struct size: " + string(size(_struct)));
show_debug_message("Real size: " + string(size(_real)));
```

The above code will show the size of the `_array`, `_string`, `_struct`, and `_real` on console.

The output will be:
```
Array size: 4
String size: 12
Struct size: 3
Real size: 3
```

---
# trace
Prints a message to the console. Serves as a shortcut for `show_debug_message`.

### Syntax
  ```js
  trace(*args);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| *args | any | The messages to print |

### Returns
  ```js
  None
  ```

### Example
```js
trace("Hello World!");
```

The above code will print "Hello World!" to the console.

---
# alert
# alert
Shows an alert dialog with the message passed as argument. The dialog will stop anything happening in the game until the user clicks the OK button. Server as a shortcut for `show_message`.

### Syntax
  ```js
  alert(message);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| message | String | The message to show |

### Returns
  ```js
  None
  ```

### Example
```js
alert("Hello World!");
```

The above code will show an alert dialog with the message "Hello World!".

---
# alert_async
Shows an alert dialog with the message passed as argument. The dialog **will not** stop anything happening in the game. Server as a shortcut for `show_message_async`.

### Syntax
  ```js
  alert_async(message);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| message | String | The message to show |

### Returns
  ```js
  None
  ```

### Example
```js
alert_async("Hello World!");
```

The above code will show an alert dialog with the message "Hello World!".

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Images.md">Images</a>
    </h3>
  </div>
</div>
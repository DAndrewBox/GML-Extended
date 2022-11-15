# Logger

This is a new Logger struct type that allows to work with the game's logger in a more convenient way instead of just using the GameMaker's built-in output console function.

A new logger object can be created using `gloabal.logger = new Logger(filename, [path=working_directory])`. Using a global variable or assigned to a macro is optional but recommended.

**This library requires for `lib_time` & `lib_structs` to work.**

### Internal Parameters
| Parameter | Type | Description |
| :--- | :---: | :--- |
| file | File ID | The logger file index |
| filename | String | The logger filename |
| filepath | String | The logger filepath |
| linked | Struct | The logger linked instance struct |

The following methods are available:

### Table of Contents
- [open](#open)
- [close](#close)
- [log](#log)
- [warn](#warn)
- [error](#error)
- [link_instance](#link_instance)

---
# open
Opens the logger file. (This is done automatically when the logger is created but can be used to reopen the file if it was closed manually.)

**Remember to close the file when you are done using the logger or any change made into the file will not be saved.**

### Syntax
  ```js
  Logger.open();
  ```

### Returns
  ```js
  None
  ```

### Example
```js
global.logger = new Logger("log.txt");
global.logger.open();
global.logger.log("Hello World!");
global.logger.close();
```

The above code will create a new log.txt file in the working directory and write "Hello World!" to it.

---

# close
Closes the logger file. Remember to add this function on your game's exit event to save any changes made into the file.

**Remember to close the file when you are done using the logger or any change made into the file will not be saved.**

### Syntax
  ```js
  Logger.close();
  ```

### Returns
  ```js
  None
  ```

### Example
```js
global.logger = new Logger("log.txt");
global.logger.open();
global.logger.log("Hello World!");
global.logger.close();
```

The above code will create a new log.txt file in the working directory and write "Hello World!" to it. Then it will close the file to save the changes.

---

# log
Writes a message to the logger file. The message will be written in the following format: `<timestamp> message`.

If there's any linked instance, the loger will execute the `onLog` callback on it.

**The Logger file should be open before using this function or the message will not be written to the file and the callback will not be executed.**

### Syntax
  ```js
  Logger.log([*args]);
  ```


| Argument | Type | Description |
| :--- | :---: | :--- |
| *args | Any | The message to write to the logger file. Can be separated by commas and will be converted to a string. |

### Returns
  ```js
  String
  ```

### Example
```js
global.logger = new Logger("log.txt");

global.logger.link_instance(oConsole, callbacks={onLog: console_log});

global.logger.open();
global.logger.log("Hello World!");
global.logger.close();

```

The above code will create a new log.txt file in the working directory and write "Hello World!" to it. Then it will close the file to save the changes. The message will also be written to the console object using the `console_log` callback.

---

# warn
Writes a message to the logger file. The message will be written in the following format: `<timestamp> [⚠] message`.

If there's any linked instance, the loger will execute the `onWarn` callback on it.

**The Logger file should be open before using this function or the message will not be written to the file and the callback will not be executed.**

### Syntax
  ```js
  Logger.warn([*args]);
  ```


| Argument | Type | Description |
| :--- | :---: | :--- |
| *args | Any | The message to write to the logger file. Can be separated by commas and will be converted to a string. |

### Returns
  ```js
  String
  ```

### Example
```js
global.logger = new Logger("log.txt");

global.logger.link_instance(oConsole, callbacks={onWarn: console_warn});

global.logger.open();
global.logger.warn("Hello World!");
global.logger.close();

```

The above code will create a new log.txt file in the working directory and write "Hello World!" to it. Then it will close the file to save the changes. The message will also be written to the console object using the `console_warn` callback.

---

# error
Writes a message to the logger file. The message will be written in the following format: `<timestamp> [❌] message`.

If there's any linked instance, the loger will execute the `onError` callback on it.

**The Logger file should be open before using this function or the message will not be written to the file and the callback will not be executed.**

### Syntax
  ```js
  Logger.error([*args]);
  ```


| Argument | Type | Description |
| :--- | :---: | :--- |
| *args | Any | The message to write to the logger file. Can be separated by commas and will be converted to a string. |

### Returns
  ```js
  String
  ```

### Example
```js
global.logger = new Logger("log.txt");

global.logger.link_instance(oConsole, callbacks={onErrorWarn: console_error});

global.logger.open();
global.logger.error("Hello World!");
global.logger.close();

```

The above code will create a new log.txt file in the working directory and write "Hello World!" to it. Then it will close the file to save the changes. The message will also be written to the console object using the `console_error` callback.

---

# link_instance
Link an instance to execute callbacks when logger is used. The callbacks will be executed on the linked instance.

If the instance is already linked, the callbacks will be overwritten.

If any of the callbacks are not defined, the default value is `-1` and the callback event will not be executed.

### Syntax
  ```js
  Logger.link_instance(instance, callbacks={onLog: -1, onWarn: -1, onError: -1});
  ```


| Argument | Type | Description |
| :--- | :---: | :--- |
| instance | Ref ID | The instance Ref ID to link to the logger. |
| callbacks | Struct | A dictionary containing the callbacks to execute on the linked instance. |

### Returns
  ```js
  None
  ```

### Example
```js
global.logger = new Logger("log.txt");

var _callbacks = {
    onLog: console_log,
    onWarn: console_warn,
    onError: console_error
};

global.logger.link_instance(oConsole, callbacks=_callbacks);
```

The above code will link the console object to the logger and execute the `console_log`, `console_warn` and `console_error` callbacks when the logger is used inside the `oConsole` object.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="HTTP.md">HTTP</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Math.md">Math</a>
    </h3>
  </div>
</div>
# Compatibility

> [!NOTE]
> This section contains functions that are used to make the extension compatible with different GameMaker versions. You should import them if you are having issues with the extension in your project or if you are using a GameMaker version previous to v2024. There will not be detailed explanations for these functions since they are used internally by the extension and should not be used directly in your project.

## Table of Contents

- [Compatibility](#compatibility)
  - [Table of Contents](#table-of-contents)
- [Macros](#macros)
- [How it works](#how-it-works)
- [\_\_gml\_ext\_comp\_init](#__gml_ext_comp_init)
- [\_\_gml\_ext\_comp\_build\_features](#__gml_ext_comp_build_features)
- [\_\_gml\_ext\_comp\_has](#__gml_ext_comp_has)
- [\_\_gml\_ext\_comp\_get\_version](#__gml_ext_comp_get_version)
- [\_\_gml\_ext\_comp\_version\_at\_least](#__gml_ext_comp_version_at_least)
- [\_\_gml\_ext\_comp\_json\_stringify](#__gml_ext_comp_json_stringify)
- [\_\_gml\_ext\_comp\_is\_callable](#__gml_ext_comp_is_callable)
- [\_\_gml\_ext\_comp\_instance\_create\_layer](#__gml_ext_comp_instance_create_layer)
- [\_\_gml\_ext\_comp\_instance\_create\_depth](#__gml_ext_comp_instance_create_depth)
- [\_\_gml\_ext\_comp\_string\_ext](#__gml_ext_comp_string_ext)
- [\_\_gml\_ext\_comp\_string\_split](#__gml_ext_comp_string_split)
- [\_\_gml\_ext\_comp\_variable\_clone](#__gml_ext_comp_variable_clone)
- [\_\_gml\_ext\_comp\_array\_contains](#__gml_ext_comp_array_contains)

---

# Macros

|              Macro               | Description                                                                          |
| :------------------------------: | :----------------------------------------------------------------------------------- |
|     GML_EXT_CURRENT_VERSION      | The current version of the GML-Extended extension.                                   |
| GML_EXT_FORCE_COMPATIBILITY_MODE | Set to `true` to run every fallback even on a modern runtime.                        |
|        GM_CURRENT_VERSION        | The runtime version as a struct with `major`, `minor` and `as_string`.               |
|       GM_VERSION_AT_LEAST        | `GM_VERSION_AT_LEAST(major, [minor])`, whether the runtime is that version or newer. |
|              GM_HAS              | `GM_HAS("feature")`, whether the runtime ships a given GameMaker function.           |
|        GM_VERSION_IS_2_3         | Check if the GameMaker version is 2.3.x.                                             |
|        GM_VERSION_IS_2022        | Check if the GameMaker version is 2022.                                              |
|        GM_VERSION_IS_2023        | Check if the GameMaker version is 2023.                                              |
|        GM_VERSION_IS_2024        | Check if the GameMaker version is 2024.                                              |
|        GM_VERSION_IS_2025        | Check if the GameMaker version is 2025.                                              |
|        GM_VERSION_IS_2026        | Check if the GameMaker version is 2026 (Includes LTS).                               |

---

# How it works

Every GameMaker function GML-Extended needs but that older runtimes do not ship is listed **once** in `__gml_ext_comp_build_features`, next to the version that introduced it:

```js
return {
  instance_create_params: GM_VERSION_AT_LEAST(2022, 8),
  string_ext:             GM_VERSION_AT_LEAST(2022, 11),
  string_split:           GM_VERSION_AT_LEAST(2022, 11),
  array_contains:         GM_VERSION_AT_LEAST(2023, 1),
  is_callable:            GM_VERSION_AT_LEAST(2023, 2),
  json_stringify_ext:     GM_VERSION_AT_LEAST(2023, 2),
  variable_clone:         GM_VERSION_AT_LEAST(2023, 4),
  gpu_set_depth:          GM_VERSION_AT_LEAST(2023, 8),
  window_mouse_delta:     GM_VERSION_AT_LEAST(2023, 8),
};
```

That table is the only place a GameMaker version number is written down. Every fallback then asks for the feature by name instead of comparing versions itself:

```js
function __gml_ext_comp_string_ext(_str, _args = []) {
  static _has = GM_HAS("string_ext");

  if (!_has) {
    // ... fallback ...
  }

  return script_execute(string_ext, _str, _args);
}
```

Reading the answer through a `static` keeps the lookup to once per function for the whole run.

To add a new fallback: add the feature to the table with the version that introduced the function, then guard the call with `static _has = GM_HAS("<feature>");`. Asking for a feature that is not in the table returns `false` and logs an error, so a typo shows up immediately instead of silently taking the wrong branch.

---

# __gml_ext_comp_init

Initialize the compatibility functions. Runs automatically at game start through `gml_pragma`.

---

# __gml_ext_comp_build_features

Returns which of the GameMaker functions GML-Extended relies on the current runtime has. See [How it works](#how-it-works).

---

# __gml_ext_comp_has

`GM_HAS("feature")`. Returns whether the current runtime ships the given GameMaker function. Returns `false` and logs an error for a name that is not in the table.

---

# __gml_ext_comp_get_version

Returns the runtime version as a struct holding `major`, `minor` and `as_string`. GameMaker 2.3.x reports a major of `2`, every later release reports its year. Parsed once and cached.

---

# __gml_ext_comp_version_at_least

`GM_VERSION_AT_LEAST(major, [minor])`. Returns whether the runtime is the given version or a newer one. The major is always compared before the minor, so `GM_VERSION_AT_LEAST(2023, 8)` is `false` on `2022.11` no matter how high the minor is.

---

# __gml_ext_comp_json_stringify

Stringify a JSON object with prettify options. (Used for compatibility with GameMaker versions previous to v2023.2)

---

# __gml_ext_comp_is_callable

Check if a function is callable. (Used for compatibility with GameMaker versions previous to v2023.2)

---

# __gml_ext_comp_instance_create_layer

Create an instance on a specific layer, can specify params as last argument. (Used for compatibility with GameMaker versions previous to v2023.8)

---

# __gml_ext_comp_instance_create_depth

Create an instance on a specific depth, can specify params as last argument. (Used for compatibility with GameMaker versions previous to v2023.8)

---

# __gml_ext_comp_string_ext

Get the extension of a string. (Used for compatibility with GameMaker versions previous to v2022.11)

---

# __gml_ext_comp_string_split

Split a string into an array. (Used for compatibility with GameMaker versions previous to v2022.11)

---

# __gml_ext_comp_variable_clone

Clone a variable or struct. (Used for compatibility with GameMaker versions previous to v2023.4)

---

# __gml_ext_comp_array_contains

Check if an array contains a value. (Used for compatibility with GameMaker versions previous to v2023.1)
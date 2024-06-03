# Compatibility

> [!NOTE]
> This section contains functions that are used to make the extension compatible with different GameMaker versions. You should import them if you are having issues with the extension in your project or if you are using a GameMaker version previous to v2024. There will not be detailed explanations for these functions since they are used internally by the extension and should not be used directly in your project.

## Table of Contents

- [Macros](#macros)
- [\_\_gml_ext_comp_init](#__gml_ext_comp_init)
- [\_\_gml_ext_comp_get_gamemaker_version](#__gml_ext_comp_get_gamemaker_version)
- [\_\_gml_ext_comp_is_gamemaker_major_version](#__gml_ext_comp_is_gamemaker_major_version)
- [\_\_gml_ext_comp_json_stringify](#__gml_ext_comp_json_stringify)
- [\_\_gml_ext_comp_is_callable](#__gml_ext_comp_is_callable)
- [\_\_gml_ext_comp_instance_create_layer](#__gml_ext_comp_instance_create_layer)
- [\_\_gml_ext_comp_instance_create_depth](#__gml_ext_comp_instance_create_depth)
- [\_\_gml_ext_comp_string_ext](#__gml_ext_comp_string_ext)
- [\_\_gml_ext_comp_string_split](#__gml_ext_comp_string_split)
- [\_\_gml_ext_comp_variable_clone](#__gml_ext_comp_variable_clone)
- [\_\_gml_ext_comp_array_contains](#__gml_ext_comp_array_contains)

---

# Macros

|          Macro          | Description                                            |
| :---------------------: | :----------------------------------------------------- |
| GML_EXT_CURRENT_VERSION | The current version of the GML-Extended extension.     |
|   GM_CURRENT_VERSION    | The current version of the GameMaker based on runtime. |
|   GM_VERSION_IS_2022    | Check if the GameMaker version is 2022.                |
|   GM_VERSION_IS_2023    | Check if the GameMaker version is 2023.                |
|   GM_VERSION_IS_2024    | Check if the GameMaker version is 2024.                |

---

# __gml_ext_comp_init

Initialize the compatibility functions.

---

# __gml_ext_comp_get_gamemaker_version

Get the GameMaker version based on the runtime.

---

# __gml_ext_comp_is_gamemaker_major_version

Check if the GameMaker version is a specific major version.

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
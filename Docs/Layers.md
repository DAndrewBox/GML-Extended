# Layers
### Table of Contents
- [layer_get_element_ids_fixed](#layer_get_element_ids_fixed)

---
# layer_get_element_ids_fixed
A way to get the elements of a dynamically created layer. This is a fix for the original `layer_get_element_ids` function that doesn't work with dynamically created layers. This function is based on the [original](https://itch.io/post/2224479) by [YellowAfterLife](https://yal.cc).

### Syntax
  ```js
  layer_get_element_ids_fixed(layer_id, layer_element_type);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| layer_id | Integer | The layer id |
| layer_element_type | Integer | The layer element type (see [Layer Element Types](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Rooms/General_Layer_Functions/layer_get_element_type.htm)) |
### Returns
  ```js
  Real
  ```

### Example
```js
var _layer_id = layer_create();
var _layer_element_type = layer_get_element_type(_layer_id);
var _layer_element_ids = layer_get_element_ids_fixed(_layer_id, _layer_element_type);

```

The above code will show on console the keys and values of the struct.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Instances_and_Events.md">Instances & Events</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Images.md">Images</a>
    </h3>
  </div>
</div>
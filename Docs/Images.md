# Images
### Table of Contents
- [image_loop_index](#image_loop_index)

---
# image_loop_index
Loops the index of an image between a start and end index (end frame included).

### Syntax
  ```js
  image_loop_index(start_index, end_index, speed);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| start_index | Real | The first index of the image |
| end_index | Real | The last index of the image |
| speed | Real | The speed of the animation |
### Returns
  ```js
  Real
  ```

### Example
```js
image_speed = .5;
image_index = image_loop_index(0, 3, image_speed);
```

The above code will loop the image_index between 0 and 3 with a speed of 0.5. So after 8 frames, the image_index will be 0 again since the end_index is included and image_index is floored. 

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="Layers.md">Layers</a>
    </h3>
  </div>
</div>
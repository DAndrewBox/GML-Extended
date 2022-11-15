# Shaders
### Table of Contents
- [shader_set_ext](#shader_set_ext)

---
# shader_set_ext
Setup a shader with uniforms and attributes from a parameters struct. 

This function will automatically get the shader uniforms by the key names, and define if the uniforms are real numbers or arrays, and use the correct function to set them.

The main structs should be named `u_float` and `u_int` for the floats and ints respectively. Inside this structs there should be subkeys with uniform name and value as seen on the example below. 

### Syntax
  ```js
  shader_set_ext(shader, [params={}]);
  ```

| Argument | Type | Description |
| :--- | :---: | :--- |
| shader | Shader | The shader to setup. |
| params | Struct | The parameters to setup the shader with. |
### Returns
  ```js
  None
  ```

### Example
```js
shader_set(shd_passthrough, {
  u_float: {
    "uSomethingFloat":	.8,
    "uOtherThingFloat": [.2, 1.0, .5],
  },
  u_int: {
    "uSomethingInt":	100,
    "uOtherThingInt":	[20, 30, 5, 10],
  },
});

draw_self();

shader_reset();
```

The above code will setup the shader with the following uniforms:

```glsl
uniform float uSomethingFloat;
uniform vec3 uOtherThingFloat;
uniform int uSomethingInt;
uniform ivec4 uOtherThingInt;
```
Then, draw the object with the shader, and reset the shader.

---

<div style="display: flex; justify-content: space-between; align-items: center;">
  <div style="text-align: left; width: 50%">
    <h3>
      Prev: 
      <a href="ServerTCP.md">Server (TCP)</a>
    </h3>
  </div>

  <div style="text-align: right; width: 50%">
    <h3>
      Next: 
      <a href="Sprites.md">Sprites</a>
    </h3>
  </div>
</div>
#region Definitions
surface_depth_disable(true);	// For performance reasons keep this disabled on 2D games.
#endregion

/// @func Surface(width, height, name)
/// @param	{real}	width
/// @param	{real}	height
/// @param	{str}	name
function Surface(_width, _height, _name="") constructor {
	/// @func	__init__(width, height, name)
	/// @param	{real}	width
	/// @param	{real}	height
	/// @param	{str}	name
	function __init__(_width, _height, _name) {
		self.width	= abs(_width);
		self.height = abs(_height);
		self.name	= _name;
		self.surf	= surface_create_ext(self.name, self.width, self.height);
	}
	
	/// @func	exists()
	/// @desc	Returns if the surface still exists.
	function exists() {
		return surface_exists(self.surf) != -1;
	}
	
	/// @func	free()
	/// @desc	Free the surface from memory.
	function free() {
		surface_free(self.surf);
		self.width	= undefined;
		self.height = undefined;
		self.name	= undefined;
	}
	
	/// @func	setTarget(mrt_target)
	/// @param	{real}	mrt_target
	/// @desc	Set this surface as target.
	function setTarget(_target = 0) {
		surface_set_target_ext(_target, self.surf);
	}
	
	/// @func	resetTarget()
	/// @desc	Reset target to application surface.
	function resetTarget() {
		surface_reset_target();
	}
	
	/// @func	clear(color, alpha)
	/// @param	{real}	color
	/// @param	{real}	alpha
	/// @desc	Clear the surface canvas.
	function clear(_col=c_fuchsia, _alpha=.0) {
		self.setTarget();
		draw_clear_alpha(_col, _alpha);
		self.resetTarget();
	}
	
	/// @func	resize(width, height)
	/// @param	{real}	width
	/// @param	{real}	height
	/// @desc	Resize surface canvas.
	function resize(_width, _height) {
		self.width	= abs(_width);
		self.height = abs(_height);
		surface_resize(self.surf, self.width, self.height);
	}
	
	/// @func	getWidth()
	/// @desc	Returns the width of the surface.
	function getWidth() {
		return self.width;
	}
	
	/// @func	getHeight()
	/// @desc	Returns the height of the surface.
	function getHeight() {
		return self.height;
	}
	
	/// @func getTexture()
	/// @desc	Returns the texture of the surface.
	function getTexture() {
		return surface_get_texture(self.surf);
	}
	
	/// @func	getPixel(x, y)
	/// @param	{real}	x
	/// @param	{real}	y
	/// @desc	Returns the pixel color of the surface.
	function getPixel(_x, _y) {
		return surface_getpixel(self.surf, _x, _y);
	}
	
	/// @func	getPixelExt(x, y)
	/// @param	{real}	x
	/// @param	{real}	y
	/// @desc	Returns the pixel color & alpha of the surface.
	function getPixelExt(_x, _y) {
		return surface_getpixel_ext(self.surf, _x, _y);
	}
	
	/// @func	save(filename, x, y, width, height)
	/// @param	{str}	filename
	/// @param	{real}	x
	/// @param	{real}	y
	/// @param	{real}	width
	/// @param	{real}	height
	/// @desc	Save the surface into a *.png file
	function save(_filename, _x=0, _y=0, _width=self.width, _height=self.height) {
		surface_save_part(self.surf, _filename, _x, _y, _width, _height);
	}
	
	/// @func	draw(x, y, xscale, yscale, rot, col, alpha)
	/// @param	{real}	x
	/// @param	{real}	y
	/// @param	{real}	xscale
	/// @param	{real}	yscale
	/// @param	{real}	rot
	/// @param	{real}	col
	/// @param	{real}	alpha
	/// @desc	Draws the surface on screen.
	function draw(_x, _y, _xscale=1, _yscale=1, _rot=0, _col=-1, _alpha=draw_get_alpha(), _from_center=false) {
		if (_from_center) {
			_x -= self.width / 2 * _xscale;
			_y -= self.height / 2 * _yscale;
		}
		draw_surface_ext(self.surf, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
	}
	
	/// @func	drawPart(x, y, left, top, width, height, xscale, yscale, col, alpha)
	/// @param	{real}	x
	/// @param	{real}	y
	/// @param	{real}	left
	/// @param	{real}	top
	/// @param	{real}	width
	/// @param	{real}	height
	/// @param	{real}	xscale
	/// @param	{real}	yscale
	/// @param	{real}	col
	/// @param	{real}	alpha
	/// @desc	Draws a part of the surface on screen.
	function drawPart(_x, _y, _left=0, _top=0, _width=self.width, _height=self.height, _xscale=1, _yscale=1, _col=-1, _alpha=draw_get_alpha()) {
		draw_surface_part_ext(self.surf, _left, _top, _width, _height, _x, _y, _xscale, _yscale, _col, _alpha);
	}
	
	/// @func	drawStretched(x, y, width, height, col, alpha)
	/// @param	{real}	x
	/// @param	{real}	y
	/// @param	{real}	width
	/// @param	{real}	height
	/// @param	{real}	col
	/// @param	{real}	alpha
	/// @desc	Draws the surface stretched on screen.
	function drawStretched(_x, _y, _width=self.width, _height=self.height, _col=-1, _alpha=draw_get_alpha()) {
		draw_surface_stretched_ext(self.surf, _x, _y, _width, _height, _col, _alpha);
	}
	
	/// @func	drawTiled(x, y, xscale, yscale, col, alpha)
	/// @param	{real}	x
	/// @param	{real}	y
	/// @param	{real}	xscale
	/// @param	{real}	yscale
	/// @param	{real}	col
	/// @param	{real}	alpha
	/// @desc	Draws the surface tiled on screen.
	function drawTiled(_x, _y, _xscale=1, _yscale=1, _col=-1, _alpha=draw_get_alpha()) {
		draw_surface_tiled_ext(self.surf, _x, _y, _xscale, _yscale, _col, _alpha);
	}
	
	__init__(_width, _height, _name);
}

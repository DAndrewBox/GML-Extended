/// @func Sprite(sprite_index)
/// @param {real}	sprite_index 
function Sprite(_spr_index) constructor {
	function __init__(_spr_index) {
		if !(sprite_exists(_spr_index)) return undefined;
		var _info = sprite_get_info(_spr_index);
		
		self.index		= _spr_index;
		self.speed		= sprite_get_speed(_spr_index);
		self.width		= _info.width;
		self.height		= _info.height;
		self.origin		= [_info.xoffset, _info.yoffset];
		self.image_type	= _info.type;
		self.bbox		= [_info.bbox_left, _info.bbox_top, _info.bbox_right, _info.bbox_bottom];
		self.bbox_mode	= sprite_get_bbox_mode(_spr_index);
		self.name		= _info.name;
		self.frames		= _info.subimages;
		self.frames_info= _info.frame_info;
		
		self.use_mask	= _info.use_mask;
		self.num_masks	= _info.num_masks;
		self.messages	= _info.messages;
		self.nineslice	= _info.nineslice;
		self.smooth		= _info.smooth;
		self.transparent= _info.transparent
		
		self.texture	= [];
		self.uvs		= [];
		
		for (var i = 0; i < self.frames; i++) {
			self.texture.push(sprite_get_texture(self.index, i));
			self.uvs.push(sprite_get_uvs(self.index, i));
		}
		
		delete _info;
	}
	
	/// @func	getSize()
	/// @desc	Returns an array with the size of the sprite
	function getSize() {
		return new Array([self.width, self.height]);
	}
	
	/// @func	getOrigin()
	/// @desc	Returns an array with the orgin coords of the sprite
	function getOrigin() {
		return self.origin;
	}
	
	/// @func	getSpriteType()
	/// @desc	Returns the type of the sprite image
	function getSpriteType() {
		return self.image_type;
	}
	
	/// @func	getBbox()
	/// @desc	Returns an array with the bbox of the sprite
	function getBbox() {
		return self.bbox;
	}
	
	/// @func	getBboxMode()
	/// @desc	Returns the bbox type of the sprite image
	function getBboxMode() {
		return self.bbox_mode;
	}
	
	/// @func	getFrames()
	/// @desc	Returns the subimages count of the sprite
	function getFrames() {
		return self.frames;
	}
	
	/// @func	getFramesInfo()
	/// @desc	Returns an array with the frames information of the sprite
	function getFramesInfo() {
		return self.frames_info;
	}
	
	/// @func	getTexture()
	/// @desc	Returns the texture of the sprite
	function getTexture() {
		return self.texture;
	}
	
	/// @func	getUVS()
	/// @desc	Returns the UVS of the sprite
	function getUVS() {
		return self.uvs;
	}
	
	/// @func	getMessages()
	/// @desc	Returns the messages of the sprite
	function getMessages() {
		return self.messages;
	}
	
	/// @func	isNineslice()
	/// @desc	Returns a bool about nineslice of the sprite
	function isNineslice() {
		return self.nineslice;
	}
	
	__init__(_spr_index);
}
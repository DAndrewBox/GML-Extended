#macro	layer_element_type_background		layerelementtype_background
#macro	layer_element_type_instance			layerelementtype_instance
#macro	layer_element_type_sprite			layerelementtype_sprite
#macro	layer_element_type_tilemap			layerelementtype_tilemap
#macro	layer_element_type_particle_system	layerelementtype_particlesystem
#macro	layer_element_type_sequence			layerelementtype_sequence
#macro	layer_element_type_undefined		layerelementtype_undefined

// This is only valid for projects that have been imported from previous versions of GameMaker.
///	@deprecated
#macro	layer_element_type_tilemap_old		layerelementtype_oldtilemap
///	@deprecated
#macro	layer_element_type_tile				layerelementtype_tile

///	@func	layer_get_element_ids_fixed(layer_id, layer_element_type)
/// @param	{Id.Layer}					layer_id				The layer id
/// @param	{Constant.LayerElementType}	layer_element_type		The layer element type.
/// @desc	A way to get the elements of a dynamically created layer. This is a fix for the original `layer_get_element_ids` function that doesn't work with dynamically created layers. [Read the documentation for more information]
function layer_get_element_ids_fixed(_layer, _element_type = layer_element_type_tilemap) {
	if (!layer_exists(_layer)) return -1;

	var els = layer_get_all_elements(_layer);
	var n = get_size(els);

	for (var i = 0; i < n; i++) {
	    var el = els[i];
	    if (layer_get_element_type(el) == _element_type) {
	        return el;
	    }
	}
	
	return -1;
}

/// @func	layer_get_background(layer_id_or_name)
/// @param	{Real|String}	layer_id_or_name	The layer id or the layer name to get the background from.
///	@desc	A way to get the background of a layer using the ID or the name. This only serves to simplify the process of getting the background of a layer with multiple functions and different variables storing the ids on every step.
///	@return	{Asset.GMSprite|Real}
function layer_get_background(_layer_id) {
	if (is_string(_layer_id)) {
		_layer_id = layer_get_id(_layer_id);
	}
	if (!_layer_id) return -1;
	var _background = layer_background_get_id(_layer_id);
	if (!_background) return -1;
	
	return layer_background_get_sprite(_background);
}

/// @func	layer_get_tileset(layer_id_or_name)
/// @param	{Id.Layer|String}	layer_id_or_name	The layer id or the layer name to get the tileset from.
///	@desc	A way to get the tileset of a layer using the ID or the name. This only serves to simplify the process of getting the tileset of a layer with multiple functions and different variables storing the ids on every step.
///	@return	{Real}
function layer_get_tileset(_layer_id) {
	if (is_string(_layer_id)) {
		_layer_id = layer_get_id(_layer_id);
	}
	if (!_layer_id) return -1;
	var _tilemap = layer_tilemap_get_id(_layer_id);
	if (!_tilemap) return -1;
	
	return tilemap_get_tileset(_tilemap);
}

/// @func	layer_set_depth(layer_name, depth)
/// @param	{String}	layer_name	The layer name to check and set the depth.
/// @param	{Real}		depth		The depth to set the layer
///	@desc	Sets the depth of a layer by using jus the name of the layer.
function layer_set_depth(_layer_name, _depth) {
	var _layer = layer_get_id(_layer_name);
	if (!layer_exists(_layer)) {
		trace("(GML-Extended) WARNING! - layer_set_depth - layer with that name doesn't exists.");
		return;
	}
	
	layer_depth(_layer, _depth);
}
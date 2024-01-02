#macro	layer_element_type_background		layerelementtype_background
#macro	layer_element_type_instance			layerelementtype_instance
#macro	layer_element_type_sprite			layerelementtype_sprite
#macro	layer_element_type_tilemap			layerelementtype_tilemap
#macro	layer_element_type_particle_system	layerelementtype_particlesystem
#macro	layer_element_type_sequence			layerelementtype_sequence
#macro	layer_element_type_undefined		layerelementtype_undefined

/* @DEPRECATED START */
// This is only valid for projects that have been imported from previous versions of GameMaker.
#macro	layer_element_type_tilemap_old		layerelementtype_oldtilemap
#macro	layer_element_type_tile				layerelementtype_tile
/* @DEPRECATED END */

///	@func	layer_get_element_ids_fixed(layer_id, layer_element_type)
/// @param	{real}	layer_id
/// @param	{real}	layer_element_type
/// @desc	A way to get the elements of a dynamically created layer.
function layer_get_element_ids_fixed(_layer, _element_type = layer_element_type_tilemap) {
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

/// @func	layer_get_background(layer_id|layer_name)
/// @param	{real|string}	layer_id|layer_name
function layer_get_background(_layer_id) {
	if (is_string(_layer_id)) {
		_layer_id = layer_get_id(_layer_id);
	}
	if (!_layer_id) return -1;
	var _background = layer_background_get_id(_layer_id);
	if (!_background) return -1;
	
	return layer_background_get_sprite(_background);
}

/// @func	layer_get_tileset(layer_id|layer_name)
/// @param	{real|string}	layer_id|layer_name
function layer_get_tileset(_layer_id) {
	if (is_string(_layer_id)) {
		_layer_id = layer_get_id(_layer_id);
	}
	if (!_layer_id) return -1;
	var _tilemap = layer_tilemap_get_id(_layer_id);
	if (!_tilemap) return -1;
	
	return tilemap_get_tileset(_tilemap);
}
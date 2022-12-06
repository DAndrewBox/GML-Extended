///	@func	layer_get_element_ids_fixed(layer_id, layer_element_type)
/// @param	{real}	layer_id
/// @param	{real}	layer_element_type
/// @desc	A way to get the elements of a dynamically created layer.
function layer_get_element_ids_fixed(_layer, _element_type = layerelementtype_tilemap) {
	var els = layer_get_all_elements(_layer);
	var n = array_length(els);

	for (var i = 0; i < n; i++) {
	    var el = els[i];
	    if (layer_get_element_type(el) == _element_type) {
	        return el;
	    }
	}
	
	return -1;
}
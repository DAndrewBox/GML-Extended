/// @description
draw_set_alpha(1);
if (surface_exists(surf)) {
	surface_set_target(surf);
	draw_clear_alpha(c_black, .0);
	draw_surface_part(application_surface, x - 100, y - 100, 200, 200, 0, 0);
	surface_reset_target();
	
	draw_surface_blur(surf, abs(dsin(current_time / 25)), x - 100, y - 100);
	draw_surface_recolor(surf, #FF00FF, .45, x - 150, y + 300);
}
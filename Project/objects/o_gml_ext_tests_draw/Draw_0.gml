/// @description Draw tests
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_align(fa_left, fa_top);

draw_text(8, 8, script_get_name(page[page_index].callback));
script_execute_ext(page[page_index].callback, page[page_index].args);

draw_text(8, 24, $"Mouse LB is hold: {mouse_check_button(mb_left)}");
draw_text(8, 40, $"Mouse RB is hold: {mouse_check_button(mb_right)}");
draw_text(8, 56, $"Mouse middle is hold: {mouse_check_button(mb_middle)}");

/*
draw_set_colour(c_lime);
draw_figure(x - 100, 128, 3, 32, 25, 2);
draw_set_colour(c_teal);
draw_figure(x, 128, 6, 32, 0, 1);
draw_set_colour(c_purple);
draw_quad([x, y], [x + 20, y], [x - 50, y + 200], [x + 150, y + 150], c_lime, c_blue, .75);
draw_figure(x + 100, 128, 4, 32, 45, 3);
draw_rectangle_width(x - 100, y - 100, x + 150, y + 100, 5);

draw_rectangle_rotated(x, y, 64, 32, 45, true);
draw_rectangle_rotated(x + 128, y, 64, 32, -65, false);
draw_set_font(-1);
draw_text_outline(x, y - 32, "Hello World!", 2, c_yellow, c_dkgray);
draw_text_shadow(x, y, "Hello World!", 1, 1, c_white, c_red);
draw_set_align(fa_center, fa_top);
draw_text_size(x, y, "Hello World!", 32);
draw_text_size(x, y + 32, "Hello World!", 24);
draw_text_size(x, y + 64, "Hello World!", 20);
draw_text_size(x, y + 96, "Hello World!", 18);

if (surface_exists(surf)) {
	surface_set_target(surf);
	draw_clear_alpha(c_white, .50);
	surface_reset_target();
}
if (keyboard_check(vk_right)) ROT++;
if (keyboard_check(vk_left)) ROT--;
draw_surface_from_center(surf, 200, 200, 1, 1, ROT);

draw_sprite_recolor(sprite_index, image_index, x, y, #FF00FF, max(0, dsin(current_time/10)));
draw_sprite_blur(sprite_index, image_index, x + 300, y + 300, .2 * abs(dsin(current_time/10)));
*/
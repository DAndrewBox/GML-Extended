/// @description
surf = surface_create(200, 200);
ROT = 0;
page_index = 0;
page = [
	{
		callback: draw_self_ext,
		args: [undefined],
		args_str: "[sprite], [index], [x], [y], [xscale], [yscale], [rot], [color], [alpha]"
	},
	{
		callback: draw_figure,
		args: [x + 64, y + 64, 6, 128, 0, 2],
		args_str: "x, y, sides, size, [(rot = 0)], [(width = 1)]",
	},
	{
		callback: draw_quad,
		args: [[x, y], [x + 20, y], [x - 50, y + 200], [x + 150, y + 150], c_lime, c_blue, .75],
		args_str: "xy1, xy2, xy3, xy4, color_init, color_final, alpha"
	},
	{
		callback: draw_rectangle_width,
		args: [x - 100, y - 100, x + 150, y + 100, 5],
		args_str: "x1, y1, x2, y2, [(width = 1)]"
	},
	{
		callback: draw_rectangle_rotated,
		args: [x, y, 64, 32, 45, true],
		args_str: "x, y, width, height, rot, [(outline = true)]"
	},
	{
		callback: draw_rectangle_rotated,
		args: [x + 128, y, 64, 32, -65, false],
		args_str: "x, y, width, height, rot, [(outline = true)]"
	},
	{
		callback: draw_text_outline,
		args: [x, y - 32, "Hello World!", 2, c_yellow, c_dkgray],
		args_str: "x, y, string, width, [(color = c_white)], [(color_outline = c_black)], [(xscale = 1)], [(yscale = 1)], [(angle = 0)]"
	},
	{
		callback: draw_text_shadow,
		args: [x, y, "Hello World!", 1, 1, c_white, c_red],
		args_str:
			@"x, y, string, [(shadow_xoff = 1)], [(shadow_yoff = 1)], [(color = c_white)], [(color_shadow = c_black)],
			[(xscale = 1)], [(yscale = 1)], [(angle = 0)]"
	},
	{
		callback: draw_text_size,
		args: [x, y + 32, "Hello World! This is the same font.", 32],
		args_str: "x, y, string, font_size"
	},
	{
		callback: draw_fps,
		args: [x, y],
		args_str: "x, y"
	},
	{
		callback: draw_fps_real,
		args: [x, y],
		args_str: "x, y"
	},
];

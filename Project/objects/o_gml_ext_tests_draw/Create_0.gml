/// @description
page_index = 0;
page = [
	{callback: draw_self_ext, args: []},
	{callback: draw_figure, args: [x, y, 3, 20, 0, 2]}
];


surf = surface_create(200, 200);
ROT = 0;
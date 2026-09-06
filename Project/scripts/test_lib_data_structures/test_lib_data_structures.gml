suite(function() {
	describe("ds_grid_write_buffer", function() {
		it("Should return a non empty string for a grid", function() {
			var _grid = ds_grid_create(4, 3);
			ds_grid_set(_grid, 0, 0, 1);

			expect(ds_grid_write_buffer(_grid)).never().toBe("");

			ds_grid_destroy(_grid);
		});

		it("Should return an empty string for a grid that does not exist", function() {
			var _grid = ds_grid_create(2, 2);
			ds_grid_destroy(_grid);

			expect(ds_grid_write_buffer(_grid)).toBe("");
		});

		it("Should return the same string for two identical grids", function() {
			var _grid_a = ds_grid_create(3, 3);
			var _grid_b = ds_grid_create(3, 3);

			ds_grid_set(_grid_a, 1, 1, 42);
			ds_grid_set(_grid_b, 1, 1, 42);

			expect(ds_grid_write_buffer(_grid_a)).toBe(ds_grid_write_buffer(_grid_b));

			ds_grid_destroy(_grid_a);
			ds_grid_destroy(_grid_b);
		});

		it("Should return a different string when a cell changes", function() {
			var _grid = ds_grid_create(3, 3);
			var _before = ds_grid_write_buffer(_grid);

			ds_grid_set(_grid, 2, 2, 7);

			expect(ds_grid_write_buffer(_grid)).never().toBe(_before);

			ds_grid_destroy(_grid);
		});
	});

	describe("ds_grid_read_buffer", function() {
		it("Should restore every cell of the grid", function() {
			var _src = ds_grid_create(4, 3);
			for (var _y = 0; _y < 3; _y++) {
				for (var _x = 0; _x < 4; _x++) {
					ds_grid_set(_src, _x, _y, _x + _y * 4);
				}
			}

			var _dest = ds_grid_create(4, 3);
			ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src));

			for (var _y = 0; _y < 3; _y++) {
				for (var _x = 0; _x < 4; _x++) {
					expect(ds_grid_get(_dest, _x, _y)).toBe(_x + _y * 4);
				}
			}

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});

		it("Should resize the destination grid to the stored size", function() {
			var _src = ds_grid_create(6, 2);
			ds_grid_set(_src, 5, 1, 9);

			var _dest = ds_grid_create(1, 1);
			ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src));

			expect(ds_grid_width(_dest)).toBe(6);
			expect(ds_grid_height(_dest)).toBe(2);
			expect(ds_grid_get(_dest, 5, 1)).toBe(9);

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});

		it("Should keep large and negative values intact", function() {
			var _src = ds_grid_create(2, 2);
			ds_grid_set(_src, 0, 0, 16777215);
			ds_grid_set(_src, 1, 0, -98765);
			ds_grid_set(_src, 0, 1, 1234567890);
			ds_grid_set(_src, 1, 1, 0);

			var _dest = ds_grid_create(2, 2);
			ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src));

			expect(ds_grid_get(_dest, 0, 0)).toBe(16777215);
			expect(ds_grid_get(_dest, 1, 0)).toBe(-98765);
			expect(ds_grid_get(_dest, 0, 1)).toBe(1234567890);
			expect(ds_grid_get(_dest, 1, 1)).toBe(0);

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});

		it("Should keep decimals intact", function() {
			var _src = ds_grid_create(1, 2);
			ds_grid_set(_src, 0, 0, 0.125);
			ds_grid_set(_src, 0, 1, -3.75);

			var _dest = ds_grid_create(1, 2);
			ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src));

			expect(ds_grid_get(_dest, 0, 0)).toBe(0.125);
			expect(ds_grid_get(_dest, 0, 1)).toBe(-3.75);

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});

		it("Should round-trip a single cell grid", function() {
			var _src = ds_grid_create(1, 1);
			ds_grid_set(_src, 0, 0, 5);

			var _dest = ds_grid_create(1, 1);
			ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src));

			expect(ds_grid_get(_dest, 0, 0)).toBe(5);

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});

		it("Should write 0 for a cell that is not a real", function() {
			var _src = ds_grid_create(2, 1);
			ds_grid_set(_src, 0, 0, "not a number");
			ds_grid_set(_src, 1, 0, 3);

			var _dest = ds_grid_create(2, 1);
			ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src));

			expect(ds_grid_get(_dest, 0, 0)).toBe(0);
			expect(ds_grid_get(_dest, 1, 0)).toBe(3);

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});

		it("Should return the grid unchanged for an invalid string", function() {
			var _grid = ds_grid_create(2, 2);
			ds_grid_set(_grid, 0, 0, 4);

			ds_grid_read_buffer(_grid, "this is not a grid buffer");

			expect(ds_grid_width(_grid)).toBe(2);
			expect(ds_grid_get(_grid, 0, 0)).toBe(4);

			ds_grid_destroy(_grid);
		});

		it("Should return the grid it was given", function() {
			var _src = ds_grid_create(2, 2);
			var _dest = ds_grid_create(2, 2);

			expect(ds_grid_read_buffer(_dest, ds_grid_write_buffer(_src))).toBe(_dest);

			ds_grid_destroy(_src);
			ds_grid_destroy(_dest);
		});
	});

	describe("ds_list_write_buffer / ds_list_read_buffer", function() {
		it("Should round-trip every value of the list", function() {
			var _src = ds_list_create();
			ds_list_add(_src, 1, "two", 3.5, -4);

			var _dest = ds_list_create();
			ds_list_read_buffer(_dest, ds_list_write_buffer(_src));

			expect(ds_list_size(_dest)).toBe(4);
			expect(_dest[| 0]).toBe(1);
			expect(_dest[| 1]).toBe("two");
			expect(_dest[| 2]).toBe(3.5);
			expect(_dest[| 3]).toBe(-4);

			ds_list_destroy(_src);
			ds_list_destroy(_dest);
		});

		it("Should replace the contents of the destination list", function() {
			var _src = ds_list_create();
			ds_list_add(_src, "only");

			var _dest = ds_list_create();
			ds_list_add(_dest, "a", "b", "c");
			ds_list_read_buffer(_dest, ds_list_write_buffer(_src));

			expect(ds_list_size(_dest)).toBe(1);
			expect(_dest[| 0]).toBe("only");

			ds_list_destroy(_src);
			ds_list_destroy(_dest);
		});

		it("Should round-trip an empty list", function() {
			var _src = ds_list_create();
			var _dest = ds_list_create();
			ds_list_add(_dest, "gone");

			ds_list_read_buffer(_dest, ds_list_write_buffer(_src));

			expect(ds_list_size(_dest)).toBe(0);

			ds_list_destroy(_src);
			ds_list_destroy(_dest);
		});

		it("Should return an empty string for a list that does not exist", function() {
			var _list = ds_list_create();
			ds_list_destroy(_list);

			expect(ds_list_write_buffer(_list)).toBe("");
		});

		it("Should leave the list untouched for an invalid string", function() {
			var _list = ds_list_create();
			ds_list_add(_list, "keep");

			ds_list_read_buffer(_list, "not a buffer");

			expect(ds_list_size(_list)).toBe(1);
			expect(_list[| 0]).toBe("keep");

			ds_list_destroy(_list);
		});

		it("Should return the list it was given", function() {
			var _src = ds_list_create();
			var _dest = ds_list_create();

			expect(ds_list_read_buffer(_dest, ds_list_write_buffer(_src))).toBe(_dest);

			ds_list_destroy(_src);
			ds_list_destroy(_dest);
		});
	});

	describe("ds_map_write_buffer / ds_map_read_buffer", function() {
		it("Should round-trip every entry of the map", function() {
			var _src = ds_map_create();
			_src[? "name"] = "player";
			_src[? "hp"] = 100;
			_src[? "speed"] = 2.5;

			var _dest = ds_map_create();
			ds_map_read_buffer(_dest, ds_map_write_buffer(_src));

			expect(ds_map_size(_dest)).toBe(3);
			expect(_dest[? "name"]).toBe("player");
			expect(_dest[? "hp"]).toBe(100);
			expect(_dest[? "speed"]).toBe(2.5);

			ds_map_destroy(_src);
			ds_map_destroy(_dest);
		});

		it("Should keep a numeric key as a number", function() {
			var _src = ds_map_create();
			_src[? 7] = "seven";

			var _dest = ds_map_create();
			ds_map_read_buffer(_dest, ds_map_write_buffer(_src));

			expect(_dest[? 7]).toBe("seven");

			ds_map_destroy(_src);
			ds_map_destroy(_dest);
		});

		it("Should replace the contents of the destination map", function() {
			var _src = ds_map_create();
			_src[? "only"] = 1;

			var _dest = ds_map_create();
			_dest[? "old"] = 2;
			ds_map_read_buffer(_dest, ds_map_write_buffer(_src));

			expect(ds_map_size(_dest)).toBe(1);
			expect(ds_map_exists(_dest, "old")).toBeFalsy();

			ds_map_destroy(_src);
			ds_map_destroy(_dest);
		});

		it("Should round-trip an empty map", function() {
			var _src = ds_map_create();
			var _dest = ds_map_create();

			ds_map_read_buffer(_dest, ds_map_write_buffer(_src));

			expect(ds_map_size(_dest)).toBe(0);

			ds_map_destroy(_src);
			ds_map_destroy(_dest);
		});

		it("Should return an empty string for a map that does not exist", function() {
			var _map = ds_map_create();
			ds_map_destroy(_map);

			expect(ds_map_write_buffer(_map)).toBe("");
		});

		it("Should leave the map untouched for an invalid string", function() {
			var _map = ds_map_create();
			_map[? "keep"] = 1;

			ds_map_read_buffer(_map, "not a buffer");

			expect(ds_map_size(_map)).toBe(1);
			expect(_map[? "keep"]).toBe(1);

			ds_map_destroy(_map);
		});
	});

	describe("struct_write_buffer / struct_read_buffer", function() {
		it("Should round-trip a flat struct", function() {
			var _out = struct_read_buffer(struct_write_buffer({ name: "player", hp: 100 }));

			expect(_out.name).toBe("player");
			expect(_out.hp).toBe(100);
		});

		it("Should round-trip nested structs and arrays", function() {
			var _src = {
				player: { stats: { hp: 100, mp: 50 } },
				items: ["sword", "shield"],
			};
			var _out = struct_read_buffer(struct_write_buffer(_src));

			expect(struct_get_path(_out, "player.stats.hp")).toBe(100);
			expect(struct_get_path(_out, "items.1")).toBe("shield");
			expect(struct_equal(_out, _src)).toBeTruthy();
		});

		it("Should round-trip an array", function() {
			var _out = struct_read_buffer(struct_write_buffer([1, 2, 3]));

			expect(_out).toBeEqual([1, 2, 3]);
		});

		it("Should round-trip an empty struct", function() {
			expect(struct_read_buffer(struct_write_buffer({}))).toHaveLength(0);
		});

		it("Should keep decimals and negative numbers", function() {
			var _out = struct_read_buffer(struct_write_buffer({ a: -3.75, b: 0.125 }));

			expect(_out.a).toBe(-3.75);
			expect(_out.b).toBe(0.125);
		});

		it("Should not share a reference with the original struct", function() {
			var _src = { nested: { value: 1 } };
			var _out = struct_read_buffer(struct_write_buffer(_src));

			_out.nested.value = 999;

			expect(_src.nested.value).toBe(1);
		});

		it("Should return an empty string for a value that is not a struct or array", function() {
			// Feather ignore once all - This should fail and return an empty string
			expect(struct_write_buffer(5)).toBe("");
			// Feather ignore once all - This should fail and return an empty string
			expect(struct_write_buffer("text")).toBe("");
		});

		it("Should return an empty struct for an invalid string", function() {
			expect(struct_read_buffer("not a buffer")).toHaveLength(0);
			expect(struct_read_buffer("")).toHaveLength(0);
		});
	});

});

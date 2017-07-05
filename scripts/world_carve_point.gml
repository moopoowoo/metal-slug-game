/// world_carve_point(x, y);
var _x = argument[0];
var _y = argument[1];

// check world_generate for terrain IDs

surface_set_target(World.surTerrain);

World.terrain[_x, _y] = 0; // air
draw_set_blend_mode(bm_subtract); // delete mode
draw_point_color(_x, _y, c_black);
draw_set_blend_mode(bm_normal);

surface_reset_target();


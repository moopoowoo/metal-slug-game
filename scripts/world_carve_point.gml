/// world_carve_point(x, y, strength);
var _x = argument[0];
var _y = argument[1];
var _strength = argument[2];

// check world_generate for terrain IDs

World.terrain_durability[_x, _y] -= _strength;
if(World.terrain_durability[_x, _y] <= 0)
{
    World.terrain_durability[_x, _y] = 0;
    World.terrain[_x, _y] = 0; // air
    
    surface_set_target(World.surTerrain);
    draw_set_blend_mode(bm_subtract); // delete mode
    draw_point_color(_x, _y, c_black);
    draw_set_blend_mode(bm_normal);
    surface_reset_target();
}


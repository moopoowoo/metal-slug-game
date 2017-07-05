/// world_carve_circle(x, y, radius);
var _x = argument[0];
var _y = argument[1];
var _radius = argument[2];

// check world_generate for terrain IDs

surface_set_target(World.surTerrain);

for(var i = clamp(_x-_radius, 0, World.width); i < clamp(_x+_radius, 0, World.width); i += 1)
{
    for(var j = clamp(_y-_radius, 0, World.height); j < clamp(_y+_radius, 0, World.height); j += 1)
    {
        if(point_distance(i, j, _x, _y) <= _radius)
        {
            World.terrain[i, j] = 0; // air
            draw_set_blend_mode(bm_subtract); // delete mode
            draw_point_color(i, j, c_black);
            draw_set_blend_mode(bm_normal);
        }
    }
}

surface_reset_target();


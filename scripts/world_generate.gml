/// world_generate(width, height);
var _width = argument[0];
var _height = argument[1];

/*
0 - air
1 - dirt
*/

World.surTerrain = surface_create(_width, _height);
surface_set_target(World.surTerrain);

for(var i = 0; i < _width; i += 1)
{
    for(var j = 0; j < _height; j += 1)
    {
        World.terrain[i, j] = 1; // dirt
        World.terrain_durability[i, j] = 30;
        var _col = make_color_hsv(25, 125+random(100), 125+random(100));
        World.terrain_color[i, j] = _col;
        draw_point_color(i, j, _col);
    }
}

surface_reset_target();


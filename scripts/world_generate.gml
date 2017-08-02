/// world_generate(width, height);
var _width = argument[0];
var _height = argument[1];

/*
0 - air
1 - dirt
2 - gem
*/

World.surTerrain = surface_create(_width, _height);
surface_set_target(World.surTerrain);

// dirt
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

// gems
for(var i = 0; i < _width; i += 1)
{
    for(var j = 0; j < _height; j += 1)
    {
        if(random(100) <= 0.01)
        {
            var _frame = random(sprite_get_number(sprGems)-1);
            var __sur = surface_create(sprite_get_width(sprGems), sprite_get_height(sprGems));
            surface_set_target(__sur);
            draw_sprite(sprGems, _frame, 0, 0);
            surface_reset_target();
            draw_sprite(sprGems, _frame, i, j);
            
            for(var k = 0; k < sprite_get_width(sprGems); k += 1)
            {
                for(var l = 0; l < sprite_get_height(sprGems); l += 1)
                {
                    var col = surface_getpixel_ext(__sur, k, l);
                    var alpha = (col >> 24) & 255;
                    
                    if(alpha > 0)
                    {
                        var blue = (col >> 16) & 255;
                        var green = (col >> 8) & 255;
                        var red = col & 255;
                        
                        World.terrain[i+k, j+l] = 2; // gem
                        World.terrain_durability[i+k, j+l] = 120;
                        //var _col = make_color_hsv(25, 125+random(100), 125+random(100));
                        World.terrain_color[i+k, j+l] = col;
                        //draw_point_color(i+k, j+l, col);
                    }
                }
            }
            
            surface_free(__sur);
        }
    }
}

surface_reset_target();

World.surTerrainBG = surface_create(_width, _height);
surface_copy(World.surTerrainBG, 0, 0, World.surTerrain);


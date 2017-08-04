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

// noise settings
var _lacunarity = 0.5;      // ???                              0.5
var _gain = 0.5;            // transparency? bigger holes       0.5
var _offset = 0.25;         // tunnel width                     0.25
var _octaves = 1.25;           // noise quality                    5
var _xScale = 0.025;        // horizontal scale                 0.025
var _yScale = 0.025;        // vertical scale                   0.025
//var _seed = current_time/1000;
var _seed = current_time;

// dirt
show_debug_message("Filling in the world...");
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

// background
show_debug_message("Creating the background...");
World.surTerrainBG = surface_create(_width, _height);
surface_copy(World.surTerrainBG, 0, 0, World.surTerrain);

// caves
show_debug_message("Carving caves...");
draw_set_blend_mode(bm_subtract); // delete mode
for(var i = 0; i <= width; i += 1)
{
    show_debug_message(string((i/width)*100) + "%");
    
    for(var j = 0; j <= height; j += 1)
    {
        var _res = ridgedMF(i, j, _seed, _lacunarity, _gain, _offset, _octaves, _xScale, _yScale);
        
        if(_res <= 0.01)
        {
            World.terrain_durability[i, j] = 0;
            World.terrain[i, j] = 0; // air
            
            //surface_set_target(World.surTerrain);
            draw_point_color(i, j, c_black);
            //surface_reset_target();
        }
        
        //show_debug_message(_res);
    }
}
draw_set_blend_mode(bm_normal);

// gems
show_debug_message("Placing gems...");
for(var i = 0; i <= _width; i += 1)
{
    for(var j = 0; j <= _height; j += 1)
    {
        if(random(100) <= 0.025
        && World.terrain[clamp(i+round(sprite_get_width(sprGems)/2), 0, World.width-1), clamp(j+round(sprite_get_height(sprGems)/2), 0, World.height-1)] != 0) // air
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
show_debug_message("Done!");

instance_create(width/2, 48, Player);
generated = 1;


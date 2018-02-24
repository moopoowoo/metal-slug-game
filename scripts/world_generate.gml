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
for(var i = 0; i < _width; i += 1)
{
    var _bars = "";
    repeat(floor(i/width*25)) _bars += "!";
    repeat(25-floor(i/width*25)) _bars += ".";
    window_set_caption("Filling in the world... [" + _bars + "] " + string(floor((i/width)*100)) + "%");
    
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
window_set_caption("Creating the background...");
World.surTerrainBG = surface_create(_width, _height);
surface_copy(World.surTerrainBG, 0, 0, World.surTerrain);

// caves
draw_set_blend_mode(bm_subtract); // delete mode
/*for(var i = 0; i <= width; i += 1)
{
    var _bars = "";
    repeat(floor(i/width*25)) _bars += "!";
    repeat(25-floor(i/width*25)) _bars += ".";
    window_set_caption("Carving caves... [" + _bars + "] " + string(floor((i/width)*100)) + "%");
    
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
}*/
var _nextTunnel = 100;
for(var j = _nextTunnel; j <= _height; j += 1)
{
    var _jbars = "";
    repeat(floor(j/height*25)) _jbars += "!";
    repeat(25-floor(j/height*25)) _jbars += ".";
    window_set_caption("Carving caves... [" + _jbars + "] " + string(floor((j/height)*100)) + "%");
    
    if(j == _nextTunnel)
    {
        var tunnelY = 0;
        var tunnelDirMaxDeviation = 5+random(85);
        var tunnelDir = random_range(-tunnelDirMaxDeviation, tunnelDirMaxDeviation);
        var tunnelDirSpeed = 1+random(20);
        var tunnelTargetDir = (-1*sign(tunnelDir))*abs(random_range(-tunnelDirMaxDeviation, tunnelDirMaxDeviation));
        var tunnelRadius = 10+random(40);
        var tunnelRadiusMaxRand = random(10);
        
        for(var i = 0; i <= _width; i += 1)
        {
            var _ibars = "";
            repeat(floor(i/width*25)) _ibars += "!";
            repeat(25-floor(i/width*25)) _ibars += ".";
            window_set_caption("Carving caves... [" + _jbars + "] " + string(floor((j/height)*100))
            + "% - Carving tunnel... [" + _ibars + "] " + string(floor((i/width)*100)) + "%");
            
            tunnelY += lengthdir_y(1, tunnelDir);
            //tunnelDir += tunnelDirSpeed*(-abs(tunnelTargetDir));
            tunnelDir -= tunnelDirSpeed*sign(tunnelTargetDir);
            
            if(abs(tunnelDir) >= abs(tunnelTargetDir))
            {
                tunnelTargetDir = (-1*sign(tunnelTargetDir))*random(tunnelDirMaxDeviation);
                tunnelDirSpeed = (1+random(20))/(tunnelRadius/50);
            }
            
            /*World.terrain_durability[i, j+tunnelY] = 0;
            World.terrain[i, j+tunnelY] = 0; // air
            
            draw_point_color(i, j+tunnelY, c_black);*/
            world_carve_circle(i, j+tunnelY, tunnelRadius+random(tunnelRadiusMaxRand), 3);
            i += irandom(tunnelRadius/2);
        }
        
        _nextTunnel += round(tunnelRadius*5+random(tunnelRadius*5));
    }
}
draw_set_blend_mode(bm_normal);


// grass
for(var i = 0; i < _width; i += 1)
{
    var _bars = "";
    repeat(floor(i/width*25)) _bars += "!";
    repeat(25-floor(i/width*25)) _bars += ".";
    window_set_caption("Adding grass... [" + _bars + "] " + string(floor((i/width)*100)) + "%");
    
    for(var j = 0; j < _height; j += 1)
    {
        if(world_detect_point(i, j)
        && !world_detect_point(i, clamp(j-1, 0, _height-1)))
        {
            var _y = 0
            
            repeat(1+irandom(3))
            {
                var __y = clamp(j+_y, 0, _height-1);
                World.terrain[i, __y] = 2; // grass
                World.terrain_durability[i, __y] = 3;
                var _col = make_color_hsv((256/3), 125+random(100), 75+random(100));
                World.terrain_color[i, __y] = _col;
                draw_point_color(i, __y, _col);
                _y -= 1;
            }
            
            _y = 1
            
            repeat(1+irandom(2))
            {
                var __y = clamp(j+_y, 0, _height-1);
                //World.terrain[i, __y] = 2; // grass
                //World.terrain_durability[i, __y] = 3;
                var _col = make_color_hsv((256/3), 125+random(100), 25+random(100));
                World.terrain_color[i, __y] = _col;
                draw_point_color(i, __y, _col);
                _y += 1;
            }
        }
    }
}

// gems
/*window_set_caption("Placing gems...");
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
}*/

surface_reset_target();
window_set_caption("Done!");

instance_create(width/2, 48, Player);
generated = 1;


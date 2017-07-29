///tool_use(tool id, tool direction)
var toolid, tooldir;
toolid=argument0;
tooldir=argument1;

switch toolid {
    case 0:
    {
        
        break;
    }
    case 1:
    {
    
        break;
    }
    case 2:
    {
    
        break;
    }
    case 3: // drill
    {
        var _length = 12;
        var _maxLength = 38;
        var _coneWidth = 20;
        
        while(_length < _maxLength)
        {
            for(var i = -_coneWidth; i < _coneWidth; i += 1)
            {
                var _x = clamp(x+lengthdir_x(_length, tooldir)+lengthdir_x(i, tooldir+90), 0, World.width-1);
                var _y = clamp(y+lengthdir_y(_length, tooldir)+lengthdir_y(i, tooldir+90), 0, World.height-1);
                
                if(World.terrain[_x, _y] != 0)
                {
                    // particles
                    var _dir = random(360);
                    var _hspd = lengthdir_x(random(4), _dir);
                    var _vspd = lengthdir_y(random(4), _dir);
                    var _col = make_color_hsv(random(255), 255, 255);
                    
                    var _touchingAir = -1;
                    for(var j = 0; j < 4; j += 1)
                    {
                        if(World.terrain[clamp(_x+lengthdir_x(2, j*90), 0, World.width-1),
                                         clamp(_y+lengthdir_y(2, j*90), 0, World.height-1)] == 0)
                        {
                            _touchingAir = j;
                        }
                    }
                    if(_touchingAir > -1
                    && random(World.terrain_durability[_x, _y]) <= 0.1)
                    /*particle_spawn(_x, _y, lengthdir_x(random(2), tooldir+180)+lengthdir_x(2, _touchingAir*360),
                                           lengthdir_y(random(2), tooldir+180)+lengthdir_y(2, _touchingAir*360), World.terrain_color[_x, _y]);*/
                    particle_spawn(_x+lengthdir_x(1, point_direction(_x, _y, x, y)),
                                   _y+lengthdir_y(1, point_direction(_x, _y, x, y)),
                    lengthdir_x(random(2), tooldir+180),
                    lengthdir_y(random(2), tooldir+180),
                    merge_color(World.terrain_color[_x, _y], c_black, 0.25));
                    
                    // mine
                    world_carve_point(_x, _y, 1);
                }
            }
            
            _length += 1;
            _coneWidth -= 0.5;
        }
    
        break;
    }
}


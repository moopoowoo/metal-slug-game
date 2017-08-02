///tool_use(tool id, tool direction)
var toolid, tooldir;
toolid=argument0;
tooldir=argument1;

switch toolid {
    case 0: // cannon
    {
        if(cannonReload <= 0)
        {
            cannonReload = 30;
            
            with(instance_create(x, y, Cannon))
            {
                speed = 8;
                direction = tooldir;
                gravity = 0.25;
            }
        }
        
        break;
    }
    case 1: // laser
    {
        var _length = 8;
        var _maxLength = 320;
        
        while(_length < _maxLength)
        {
            var _x = clamp(x+lengthdir_x(_length, tooldir), 0, World.width-1);
            var _y = clamp(y+lengthdir_y(_length, tooldir), 0, World.height-1);
            
            if(World.terrain[_x, _y] != 0)
            {
                world_carve_circle(_x, _y, 6, 5);
                
                // lighting
                with(instance_create(_x, _y, Light))
                {
                    lightColor = make_color_rgb(0, 125, 255);
                    lightRadius = 32;
                    lightOvershoot = 8;
                    lightFadeSpeed = 1/8;
                    lightRadiusSpeed = 2;
                }
                
                break;
            }
            
            _length += 4;
        }
    
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
                
                    if(random(World.terrain_durability[_x, _y]) <= 0.1)
                    particle_spawn(_x+lengthdir_x(1, point_direction(_x, _y, x, y)),
                                   _y+lengthdir_y(1, point_direction(_x, _y, x, y)),
                    lengthdir_x(random(_hspd), _dir),
                    lengthdir_y(random(_vspd), _dir),
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


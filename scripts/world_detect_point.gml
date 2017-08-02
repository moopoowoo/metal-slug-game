/// world_detect_point(x, y);
var _x = argument[0];
var _y = argument[1];

if(World.terrain[_x, _y] != 0)
{
    return 1;
}

return 0;

